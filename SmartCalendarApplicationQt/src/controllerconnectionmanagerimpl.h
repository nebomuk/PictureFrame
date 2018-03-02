#ifndef CONTROLLERCONNECTIONMANAGERIMPL_H
#define CONTROLLERCONNECTIONMANAGERIMPL_H

#include "blockingmqttconnection.h"
#include "controllerdatacontainer.h"
#include "mqttmessageparser.h"

#include <QFuture>
#include <QFutureWatcher>
#include <QObject>
#include <qmqtt_client.h>
#include <qqmlengine.h>

class ControllerConnectionManagerImpl : public QObject
{
    Q_PROPERTY(ControllerDataContainer controllerDataContainer READ dataContainer)

    Q_OBJECT
public:
    explicit ControllerConnectionManagerImpl(QObject *parent = nullptr);

    bool establishConnectionBlocking(const QString &brokerAddress, const QString &clientId);

     bool closeConnection();

     void publishSimpleStringMessage(const QString& path, const QString& simpleMessage);

     void publishJSONMessage(const QByteArray &jsonObjectString, const QString &objectPath);

     ControllerDataContainer *dataContainer() const;

public slots:

private slots:

     void listenToPublishes(QMQTT::Message msg);

private:


     void storeIncomingMessageLocally(QMQTT::Message msg);

     void storeSendingMessageLocally(QString subscriptionPath, QByteArray jsonString);

    ControllerDataContainer * mDataContainer;
    BlockingMqttConnection * blockingMqttConnection;


};

#endif // CONTROLLERCONNECTIONMANAGERIMPL_H
