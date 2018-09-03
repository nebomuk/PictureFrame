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
    connect(blockingMqttConnection,&BlockingMqttConnection::published,this,&ControllerConnectionManagerImpl::published);
    connect(blockingMqttConnection,&BlockingMqttConnection::error,this,&ControllerConnectionManagerImpl::error);

}

bool ControllerConnectionManagerImpl::establishConnectionBlocking(const QString &brokerAddress, const QString &clientId)
{
    return blockingMqttConnection->establishConnectionBlocking(brokerAddress,clientId);
}

bool ControllerConnectionManagerImpl::closeConnection()
{
    return blockingMqttConnection->closeConnection();
}


quint16 ControllerConnectionManagerImpl::publishSimpleStringMessage(const QString& path, const QString& simpleMessage)
{
   QMQTT::Message message;
   message.setTopic(path);
   message.setPayload(simpleMessage.toUtf8());
   message.setQos(2); // exactly once
   return blockingMqttConnection->publish(message);
}

quint16 ControllerConnectionManagerImpl::publishJSONMessage(const QByteArray& jsonObjectString, const QString& objectPath)
{
    QMQTT::Message message;
    message.setTopic(objectPath);
    message.setPayload(jsonObjectString);
    message.setQos(2); // exactly once
    quint16 msgid = blockingMqttConnection->publish(message);
    storeSendingMessageLocally(objectPath,jsonObjectString);
    return msgid;

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

void ControllerConnectionManagerImpl::clearLocalImageCache()
{
    mDataContainer->footballImages(QJsonArray());
    mDataContainer->newsImages(QJsonArray());
    mDataContainer->weatherImages(QJsonArray());
    mDataContainer->imageFileImages(QJsonArray());
    mDataContainer->cinemaImages(QJsonArray());
    mDataContainer->calendarImages(QJsonArray());

}







