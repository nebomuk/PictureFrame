#include "controllerconnectionmanagerimpl.h"

#include <qmqtt_message.h>

ControllerConnectionManagerImpl::ControllerConnectionManagerImpl(QString brokerAddress, ControllerDataContainer dataContainer, QObject *parent) : QObject(parent)
{
    client = new QMQTT::Client(brokerAddress,brokerPort,this);
    dataContainer = dataContainer;

    connect(client, &QMQTT::Client::connected,this,&ControllerConnectionManagerImpl::onConnected);
}

bool ControllerConnectionManagerImpl::establishConnection(QString clientId)
{
    client->setClientId(clientId);
    client->connectToHost();
}

bool ControllerConnectionManagerImpl::closeConnection()
{

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

void ControllerConnectionManagerImpl::onConnected()
{

}
