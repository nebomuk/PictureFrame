#include "controllerconnectionmanagerimpl.h"

#include <QEventLoop>
#include <QTimer>
#include <qmqtt_message.h>
#include "controllerconnectionconstants.h"

ControllerConnectionManagerImpl::ControllerConnectionManagerImpl(QString brokerAddress, ControllerDataContainer * dataContainer, QObject *parent) : QObject(parent)
{
    this->dataContainer = dataContainer;

    client = new QMQTT::Client(brokerAddress,brokerPort,false, true,this);

    connect(client,&QMQTT::Client::error,this,&ControllerConnectionManagerImpl::onClientError);
}

bool ControllerConnectionManagerImpl::establishConnection(QString clientId)
{
    client->setClientId(clientId);
    client->connectToHost();

    QTimer connectionTimeout;
    connectionTimeout.setInterval(3000);
    connectionTimeout.setSingleShot(true);
    QEventLoop eventLoop;
    connect(client,&QMQTT::Client::connected,&eventLoop,&QEventLoop::quit);
    connect(&connectionTimeout,&QTimer::timeout,&eventLoop,&QEventLoop::quit);
    eventLoop.exec();
    if(client->connectionState() == QMQTT::ConnectionState::STATE_CONNECTED)
    {
        registerSubscriptions();
        testConnection();
        currentClientId = clientId;
        qDebug("establishConnection successfull");
        return true;
    }
    else
    {
        qDebug("establishConnection failed: Connection timeout");
        return false;
    }

}

bool ControllerConnectionManagerImpl::closeConnection()
{
    if(client->connectionState() == QMQTT::ConnectionState::STATE_CONNECTED)
    {
        client->disconnectFromHost();
    }
    return true;
}

void ControllerConnectionManagerImpl::publishSimpleStringMessage(QString path, QString simpleMessage)
{
   QMQTT::Message message;
   message.setTopic(path);
   message.setPayload(simpleMessage.toUtf8());
    client->publish(message);
}

void ControllerConnectionManagerImpl::publishJSONMessage(QString jsonObjectString, QString objectPath)
{
    QMQTT::Message message;
    message.setTopic(objectPath);
    message.setPayload(jsonObjectString.toUtf8());
    client->publish(message);

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

void ControllerConnectionManagerImpl::onClientError(QMQTT::ClientError error)
{
    qDebug(qPrintable("FIXME: ClientError enum number " + QString::number(error) + " received"));
}



