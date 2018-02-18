#include "controllerconnectionmanagerimpl.h"

#include <QEventLoop>
#include <QFutureWatcher>
#include <QJsonDocument>
#include <QJsonDocument>
#include <QPointer>
#include <QThreadPool>
#include <QTimer>
#include <QtConcurrent>
#include <qmqtt_message.h>
#include "controllerconnectionconstants.h"

ControllerConnectionManagerImpl::ControllerConnectionManagerImpl(QObject *parent) : QObject(parent)
{
    this->mDataContainer = new ControllerDataContainer(this);

    client = nullptr;

    qRegisterMetaType<QMQTT::Message>("QMQTT::Message");

    connect(&establishConnectionFutureWatcher,&QFutureWatcher<bool>::finished,this,[this]
    {
        emit establishConnectionResult(establishConnectionFuture.resultAt(0));
    });


}

bool ControllerConnectionManagerImpl::waitForMqttConnected()
{
    QTimer connectionTimeout;
    connectionTimeout.setInterval(3000);
    connectionTimeout.setSingleShot(true);
    QEventLoop eventLoop;

    connect(client,&QMQTT::Client::connected,&eventLoop,&QEventLoop::quit);
    connect(client,&QMQTT::Client::error,&eventLoop,&QEventLoop::quit);

    connect(&connectionTimeout,&QTimer::timeout,&eventLoop,&QEventLoop::quit);
    connectionTimeout.start();
    eventLoop.exec();

    // connection state may still be INIT but DISCONNECTED when there was an error
    return client->connectionState() != QMQTT::ConnectionState::STATE_DISCONNECTED;
}

bool ControllerConnectionManagerImpl::waitForInitialDataReceived()
{
    QTimer connectionTimeout;
    connectionTimeout.setInterval(3000);
    connectionTimeout.setSingleShot(true);

    bool initialDataReceived = false;

    QEventLoop eventLoop;

    connect(client,&QMQTT::Client::received,&eventLoop,[&eventLoop,&initialDataReceived]
    {
        initialDataReceived = true;
        eventLoop.quit();
    });
    connect(client,&QMQTT::Client::error,&eventLoop,&QEventLoop::quit);

    connect(&connectionTimeout,&QTimer::timeout,&eventLoop,&QEventLoop::quit);
    connectionTimeout.start();
    eventLoop.exec();
    return initialDataReceived;
}

bool ControllerConnectionManagerImpl::establishConnectionBlocking(const QString& brokerAddress, const QString& clientId)
{
    delete client;
    client = createMqttClient(brokerAddress);

    client->setClientId(clientId);
    client->connectToHost();

    bool successfull = waitForMqttConnected();

    if(!successfull)
    {
        qDebug("establishConnection failed: Connection timeout");
        return false;
    }

    registerSubscriptions();
    testConnection(); // this will cause the receiving end to respond with the initial data

    bool initialDataReceived = waitForInitialDataReceived();
    if(!initialDataReceived)
    {
        qDebug("failed to receive initial Data");
        return false;
    }

    qDebug("initialDataReceived");
    currentClientId = clientId;
    return true;

}

void ControllerConnectionManagerImpl::establishConnection(QString brokerAddress,QString clientId)
{
    establishConnectionFuture = QtConcurrent::run([=]{
                  bool result =  establishConnectionBlocking(brokerAddress,clientId);

                  client->moveToThread(QCoreApplication::instance()->thread());
                  return result;
    });
    establishConnectionFutureWatcher.setFuture(establishConnectionFuture);

}


bool ControllerConnectionManagerImpl::closeConnection()
{
    if(client->connectionState() != QMQTT::ConnectionState::STATE_DISCONNECTED)
    {
        client->disconnectFromHost();
        client->deleteLater();
    }
    return true;
}

void ControllerConnectionManagerImpl::publishSimpleStringMessage(const QString& path, const QString& simpleMessage)
{
   QMQTT::Message message;
   message.setTopic(path);
   message.setPayload(simpleMessage.toUtf8());
    client->publish(message);
}

void ControllerConnectionManagerImpl::publishJSONMessage(const QByteArray& jsonObjectString, const QString& objectPath)
{
    QMQTT::Message message;
    message.setTopic(objectPath);
    message.setPayload(jsonObjectString);
    client->publish(message);
    storeSendingMessageLocally(objectPath,jsonObjectString);

}

void ControllerConnectionManagerImpl::registerSubscriptions()
{
    client->subscribe(ControllerConnectionConstants::TESTSUBSCRIPTIONPATH, 2);

    client->subscribe(ControllerConnectionConstants::BIRTHDAYPLANSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::TRASHPLANSUBSCRIPTIONPATH, 2);

    client->subscribe(ControllerConnectionConstants::PERSONLISTSUBSCRIPTIONPATH, 2);

    client->subscribe(ControllerConnectionConstants::BASEOPTIONSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::DISPLAYOPTIONSUBSCRIPTIONPATH, 2);

    client->subscribe(ControllerConnectionConstants::CALENDARIMAGESUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::CINEMAIMAGESUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::FOOTBALLIMAGESUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::NEWSIMAGESUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::WEATHERIMAGESUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::IMAGEFILESUBSCRIPTIONPATH, 2);

    client->subscribe(ControllerConnectionConstants::FOOTBALLLEAGUESUBSCRIPTIONPATH, 2);

    client->subscribe(ControllerConnectionConstants::FIRSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::SECONDLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::SUPERLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::LEAGUEONEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::PREMIERELEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::SERIEALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::LEAGUEBBVALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
}

void ControllerConnectionManagerImpl::testConnection()
{
    QMQTT::Message message;
    message.setTopic(ControllerConnectionConstants::TESTCONNECTIONPATH);
    message.setPayload(QByteArray("Connection successfull"));
    client->publish(message);
}

void ControllerConnectionManagerImpl::listenToPublishes(QMQTT::Message msg)
{
    storeIncomingMessageLocally(msg);
}

void ControllerConnectionManagerImpl::storeIncomingMessageLocally(QMQTT::Message msg)
{
    MqttMessageParser mqttMessageParser(mDataContainer);

   mqttMessageParser.storeIncomingMessageLocally(msg);

}

void ControllerConnectionManagerImpl::storeSendingMessageLocally(QString subscriptionPath, QByteArray jsonString)
{
    MqttMessageParser mqttMessageParser(mDataContainer);
    mqttMessageParser.storeSendingMessageLocally(subscriptionPath,jsonString);
}

QMQTT::Client *ControllerConnectionManagerImpl::createMqttClient(QString brokerAddress)
{
    auto mqttClient = new QMQTT::Client(brokerAddress,brokerPort,false, true);

    connect(mqttClient,&QMQTT::Client::error,this,&ControllerConnectionManagerImpl::onClientError);

    connect(mqttClient,&QMQTT::Client::received,this,&ControllerConnectionManagerImpl::listenToPublishes);

    return mqttClient;
}

ControllerDataContainer *ControllerConnectionManagerImpl::dataContainer() const
{
    return mDataContainer;
}



void ControllerConnectionManagerImpl::onClientError(QMQTT::ClientError error)
{
    qDebug(qPrintable(QString("FIXME: ClientError enum enum %1 received").arg(error)));
}



