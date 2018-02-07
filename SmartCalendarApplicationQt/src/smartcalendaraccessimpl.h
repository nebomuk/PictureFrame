#ifndef SMARTCALENDARACCESSIMPL_H
#define SMARTCALENDARACCESSIMPL_H

#include "responderclient.h"

#include <QHostAddress>
#include <QObject>
#include <QUdpSocket>

class SmartCalendarAccessImpl : public QObject
{
    Q_OBJECT
public:
    explicit SmartCalendarAccessImpl(QObject *parent = nullptr);


    void checkNetworkConnection();

    QList<QHostAddress> getAllAvailableDevicesInNetwork();

    QList<ResponderClient> getControllerInNetworkFromBroadcastBlocking(int timeOut);

    void getControllerInNetworkFromBroadcast();

    QString getCurrentTargetConnectionAddress();

    bool isConnectedToActiveNetwork();

    bool isConnectedToWifi();

    bool isCurrentlyRoaming();

signals:
    void controllerInNetworkReceived(QList<ResponderClient> controllers);


public slots:

private:
    bool mIsConnected;
    const QString BROADCASTMESSAGE = "Broadcast controller";

    const int BROADCASTPORT = 3912;
    const int BUFFERTIMEOUT = 100;
    QList<ResponderClient> readResponderClientsFromUdpSocket(QUdpSocket *socket);
};

#endif // SMARTCALENDARACCESSIMPL_H
