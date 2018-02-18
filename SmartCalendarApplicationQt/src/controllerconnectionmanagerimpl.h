#ifndef CONTROLLERCONNECTIONMANAGERIMPL_H
#define CONTROLLERCONNECTIONMANAGERIMPL_H

#include "controllerdatacontainer.h"

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

     void establishConnection(QString brokerAddress, QString clientId);

     bool closeConnection();

     void publishSimpleStringMessage(const QString& path, const QString& simpleMessage);

     void publishJSONMessage(const QByteArray &jsonObjectString, const QString &objectPath);

     ControllerDataContainer *dataContainer() const;

signals:

     void establishConnectionResult(bool isEstablished);

public slots:

private slots:

     void onClientError(QMQTT::ClientError error);

private:

     void testConnection();

     void registerSubscriptions();

     void listenToPublishes(QMQTT::Message msg);

     void storeIncomingMessageLocally(QMQTT::Message msg);

     void storeSendingMessageLocally(QString subscriptionPath, QByteArray jsonString);


     QMQTT::Client* createMqttClient(QString brokerAddress);

    const int brokerPort = 1337;
    QMQTT::Client * client;
    QString currentClientId;
    ControllerDataContainer * mDataContainer;
    bool messageContainsSendingImage(QString topic);
    bool messageContainsIncomingImage(QString topic);
    void storeImage(QByteArray jsonString, QString topic);

    QJsonArray convertMessageToArray(QByteArray msg);
    bool waitForMqttConnected();
    bool waitForInitialDataReceived();

    QFuture<bool> establishConnectionFuture;
    QFutureWatcher<bool> establishConnectionFutureWatcher;
};

#endif // CONTROLLERCONNECTIONMANAGERIMPL_H
