#ifndef CONTROLLERCONNECTIONMANAGERIMPL_H
#define CONTROLLERCONNECTIONMANAGERIMPL_H

#include "controllerdatacontainer.h"

#include <QObject>
#include <qmqtt_client.h>

class ControllerConnectionManagerImpl : public QObject
{
    Q_OBJECT
public:
    explicit ControllerConnectionManagerImpl(QString brokerAddress, ControllerDataContainer *dataContainer, QObject *parent = nullptr);

     bool establishConnection(QString clientId);

     bool closeConnection();

     void publishSimpleStringMessage(QString path, QString simpleMessage);

     void publishJSONMessage(QString jsonObjectString, QString objectPath);

     void registerSubscriptions();

     void testConnection();

     void listenToPublishes(QMQTT::Message msg);

     void storeIncomingMessageLocally(QMQTT::Message msg);

     void storeSendingMessageLocally(QString subscriptionPath, QString jsonString);


signals:

public slots:

private slots:
     void onClientError(QMQTT::ClientError error);

private:

    const int brokerPort = 1337;
    QMQTT::Client * client;
    QString currentClientId;
    ControllerDataContainer * dataContainer;
};

#endif // CONTROLLERCONNECTIONMANAGERIMPL_H
