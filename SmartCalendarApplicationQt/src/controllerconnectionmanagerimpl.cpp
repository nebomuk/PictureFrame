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
    blockingMqttConnection = new BlockingMqttConnection(this);
    connect(blockingMqttConnection,SIGNAL(received(QMQTT::Message)),this,SLOT(listenToPublishes(QMQTT::Message)));

}

bool ControllerConnectionManagerImpl::establishConnectionBlocking(const QString &brokerAddress, const QString &clientId)
{
    return blockingMqttConnection->establishConnectionBlocking(brokerAddress,clientId);
}

void ControllerConnectionManagerImpl::establishConnection(QString brokerAddress, QString clientId)
{
    blockingMqttConnection->establishConnection(brokerAddress,clientId);
    connect(blockingMqttConnection,SIGNAL(establishConnectionResult(bool)),this,SIGNAL(establishConnectionResult(bool)));
}

bool ControllerConnectionManagerImpl::closeConnection()
{
    return blockingMqttConnection->closeConnection();
}


void ControllerConnectionManagerImpl::publishSimpleStringMessage(const QString& path, const QString& simpleMessage)
{
   QMQTT::Message message;
   message.setTopic(path);
   message.setPayload(simpleMessage.toUtf8());
    blockingMqttConnection->publish(message);
}

void ControllerConnectionManagerImpl::publishJSONMessage(const QByteArray& jsonObjectString, const QString& objectPath)
{
    QMQTT::Message message;
    message.setTopic(objectPath);
    message.setPayload(jsonObjectString);
    blockingMqttConnection->publish(message);
    storeSendingMessageLocally(objectPath,jsonObjectString);

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



ControllerDataContainer *ControllerConnectionManagerImpl::dataContainer() const
{
    return mDataContainer;
}







