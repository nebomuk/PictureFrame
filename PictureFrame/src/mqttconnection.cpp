#include "mqttconnection.h"

#include <qmqtt_client.h>
#include <qmqtt_message.h>
#include "controllerconnectionconstants.h"

MqttConnection::MqttConnection(QObject *parent) : QObject(parent)
{
    mClient =  new QMQTT::Client();

}

void MqttConnection::publish(QMQTT::Message msg)
{
    mClient->publish(msg);
}

bool MqttConnection::closeConnection()
{
    if(mClient->connectionState() != QMQTT::ConnectionState::STATE_DISCONNECTED)
    {
        mClient->disconnectFromHost();
        mClient->deleteLater();
    }
    return true;
}

void MqttConnection::establishConnection(const QString &brokerAddress, const QString &clientId)
{
    timeout = new QTimer(this);
    timeout->setInterval(3000);
    timeout->setSingleShot(true);


    mConnections << new QMetaObject::Connection(connect(timeout, SIGNAL(timeout()),this,SLOT(resultFalse())));

    mConnections << new QMetaObject::Connection(connect(mClient,&QMQTT::Client::error,this,&MqttConnection::onClientError));

    mConnections << new QMetaObject::Connection(connect(mClient,&QMQTT::Client::connected,this,&MqttConnection::onConnected));

    mConnections << new QMetaObject::Connection(connect(mClient,&QMQTT::Client::received,this,&MqttConnection::onReceived)); // private slot

    connect(mClient,&QMQTT::Client::received,this,&MqttConnection::received); // signal


    mClient->setClientId(clientId);
    mClient->connectToHost();

    timeout->start();
}

void MqttConnection::registerSubscriptions()
{
    mClient->subscribe(ControllerConnectionConstants::TESTSUBSCRIPTIONPATH, 2);

    mClient->subscribe(ControllerConnectionConstants::BIRTHDAYPLANSUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::TRASHPLANSUBSCRIPTIONPATH, 2);

    mClient->subscribe(ControllerConnectionConstants::PERSONLISTSUBSCRIPTIONPATH, 2);

    mClient->subscribe(ControllerConnectionConstants::BASEOPTIONSUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::DISPLAYOPTIONSUBSCRIPTIONPATH, 2);

    mClient->subscribe(ControllerConnectionConstants::CALENDARIMAGESUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::CINEMAIMAGESUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::FOOTBALLIMAGESUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::NEWSIMAGESUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::WEATHERIMAGESUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::IMAGEFILESUBSCRIPTIONPATH, 2);

    mClient->subscribe(ControllerConnectionConstants::FOOTBALLLEAGUESUBSCRIPTIONPATH, 2);

    mClient->subscribe(ControllerConnectionConstants::FIRSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::SECONDLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::SUPERLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::LEAGUEONEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::PREMIERELEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::SERIEALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    mClient->subscribe(ControllerConnectionConstants::LEAGUEBBVALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
}

void MqttConnection::testConnection()
{
    QMQTT::Message message;
    message.setTopic(ControllerConnectionConstants::TESTCONNECTIONPATH);
    message.setPayload(QByteArray("Connection successfull"));
    mClient->publish(message);
}


void MqttConnection::onClientError()
{
    resultFalse();
}

void MqttConnection::onReceived()
{
    // first Json received
    resultTrue();
}

void MqttConnection::onConnected()
{
    if(clientHasError())
    {
        resultFalse();
    }
}

void MqttConnection::resultTrue()
{
    disconnectAndDeleteConnections();
    establishConnectionResult(true);
}

void MqttConnection::resultFalse()
{
    disconnectAndDeleteConnections();
    establishConnectionResult(false);
}

void MqttConnection::disconnectAndDeleteConnections()
{
    for(QMetaObject::Connection * connection : mConnections)
    {
        QObject::disconnect(*connection);
        delete connection;
    }
    mConnections.clear();
}

bool MqttConnection::clientHasError()
{
    return mClient->connectionState() == QMQTT::ConnectionState::STATE_DISCONNECTED;
}
