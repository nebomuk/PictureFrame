#ifndef SMARTCALENDARACCESSIMPL_H
#define SMARTCALENDARACCESSIMPL_H

#include "responderclient.h"

#include <QHostAddress>
#include <QObject>

class SmartCalendarAccessImpl : public QObject
{
    Q_OBJECT
public:
    explicit SmartCalendarAccessImpl(QObject *parent = nullptr);

    const QString BROADCASTMESSAGE = "Broadcast controller";

    const int BROADCASTPORT = 3912;
    const int BUFFERTIMEOUT = 100;

    bool IsConnected;
    void CheckNetworkConnection();

    QList<QHostAddress> GetAllAvailableDevicesInNetwork();

    QList<ResponderClient> GetControllerInNetworkFromBroadcast(int timeOut);

    QString GetCurrentTargetConnectionAddress();

    bool IsConnectedToActiveNetwork();

    bool IsConnectedToWifi();

    bool IsCurrentlyRoaming();


public slots:
};

#endif // SMARTCALENDARACCESSIMPL_H
