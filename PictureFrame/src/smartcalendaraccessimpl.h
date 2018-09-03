#ifndef SMARTCALENDARACCESSIMPL_H
#define SMARTCALENDARACCESSIMPL_H

#include "responderclient.h"

#include <QHostAddress>
#include <QObject>
#include <QQmlEngine>
#include <QUdpSocket>

class SmartCalendarAccessImpl : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool isConnectedToWifi READ isConnectedToWifi NOTIFY networkConfigurationChanged)

public:
    explicit SmartCalendarAccessImpl(QObject *parent = nullptr);


    Q_INVOKABLE void checkNetworkConnection();

    Q_INVOKABLE QList<QHostAddress> getAllAvailableDevicesInNetwork();

    Q_INVOKABLE QVariantList getControllerInNetworkFromBroadcastBlocking(int timeOut);

    Q_INVOKABLE void getControllerInNetworkFromBroadcast();

    Q_INVOKABLE QString getCurrentTargetConnectionAddress();

    Q_INVOKABLE bool isConnectedToActiveNetwork();

    bool isConnectedToWifi();

    Q_INVOKABLE bool isCurrentlyRoaming();

signals:
    void controllerInNetworkReceived(QVariantList controllers);

    void networkConfigurationChanged(); // QNetworkConfigurationManager::configurationChanged forward

private:
    bool mIsConnected;
    const QString BROADCASTMESSAGE = "Broadcast controller";

    const int BROADCASTPORT = 3912;
    const int BUFFERTIMEOUT = 100;
    QList<ResponderClient> readResponderClientsFromUdpSocket(QUdpSocket *socket);
};





#endif // SMARTCALENDARACCESSIMPL_H
