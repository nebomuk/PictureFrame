#include "blockingmqttconnection.h"

#include <QTimer>
#include <QEventLoop>
#include <qmqtt_message.h>
#include <QCoreApplication>
#include <QtConcurrent>

#include "controllerconnectionconstants.h"

BlockingMqttConnection::BlockingMqttConnection(QObject *parent) : QObject(parent)
{
    client = nullptr;

    qRegisterMetaType<QMQTT::Message>("QMQTT::Message"); // required for QueuedConnection
    qRegisterMetaType<QMQTT::ClientError>("QMQTT::ClientError"); // required for QueuedConnection

    connect(&establishConnectionFutureWatcher,&QFutureWatcher<bool>::finished,this,[this]
    {
        emit establishConnectionResult(establishConnectionFuture.resultAt(0));
    });

}

bool BlockingMqttConnection::waitForMqttConnected()
{
    QTimer connectionTimeout;
    connectionTimeout.setInterval(2000);
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

bool BlockingMqttConnection::waitForInitialDataReceived()
{
    QTimer connectionTimeout;
    connectionTimeout.setInterval(2000);
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

bool BlockingMqttConnection::establishConnectionBlocking(const QString& brokerAddress, const QString& clientId)
{
    delete client;
    client = createMqttClient(brokerAddress,1337);


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

void BlockingMqttConnection::publish(QMQTT::Message msg)
{
    client->publish(msg);
}

bool BlockingMqttConnection::closeConnection()
{
    if(client->connectionState() != QMQTT::ConnectionState::STATE_DISCONNECTED)
    {
        client->disconnectFromHost();
        client->deleteLater();
    }
    return true;
}

void BlockingMqttConnection::registerSubscriptions()
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

void BlockingMqttConnection::testConnection()
{
    QMQTT::Message message;
    message.setTopic(ControllerConnectionConstants::TESTCONNECTIONPATH);
    message.setPayload(QByteArray("Connection successfull"));
    client->publish(message);
}

QMQTT::Client *BlockingMqttConnection::createMqttClient(QString brokerAddress, int brokerPort)
{
    auto mqttClient = new QMQTT::Client(brokerAddress,brokerPort,false, true);

    connect(mqttClient,&QMQTT::Client::error,this,&BlockingMqttConnection::onClientError);

    connect(mqttClient,&QMQTT::Client::received,this,&BlockingMqttConnection::received);

    return mqttClient;
}

void BlockingMqttConnection::onClientError(QMQTT::ClientError error)
{
    qDebug(qPrintable(QString("ClientError enum enum %1 received").arg(error)));
}

void BlockingMqttConnection::establishConnection(QString brokerAddress,QString clientId)
{
    establishConnectionFuture = QtConcurrent::run([=]{
                  bool result =  establishConnectionBlocking(brokerAddress,clientId);

                  client->moveToThread(QCoreApplication::instance()->thread());
                  return result;
    });
    establishConnectionFutureWatcher.setFuture(establishConnectionFuture);

}

