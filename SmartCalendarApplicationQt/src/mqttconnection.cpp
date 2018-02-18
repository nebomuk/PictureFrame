#include "mqttconnection.h"

#include <qmqtt_client.h>

MqttConnection::MqttConnection(QMQTT::Client * client, const QString &brokerAddress, const QString &clientId,
                               QObject *parent) : QObject(parent)
{
    mClient = client;

    timeout = new QTimer(this);
    timeout->setInterval(3000);
    timeout->setSingleShot(true);


    connect(timeout, &QTimer::timeout,this,[this]{
        establishConnectionResult(false);
    });

    connect(client,&QMQTT::Client::error,this,&MqttConnection::onClientError);

    connect(client,&QMQTT::Client::connected,this,&MqttConnection::onConnected);


    connect(client,&QMQTT::Client::received,this,&MqttConnection::onReceived);

    client->setClientId(clientId);
    client->connectToHost();

    timeout->start();

}

void MqttConnection::onClientError()
{
    resultFalse();
}

void MqttConnection::onReceived()
{
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
    establishConnectionResult(true);
}

void MqttConnection::resultFalse()
{
    establishConnectionResult(false);
}

bool MqttConnection::clientHasError()
{
    return mClient->connectionState() == QMQTT::ConnectionState::STATE_DISCONNECTED;
}
