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


    void checkNetworkConnection();

    QList<QHostAddress> getAllAvailableDevicesInNetwork();

    QList<ResponderClient> getControllerInNetworkFromBroadcast(int timeOut);

    QString getCurrentTargetConnectionAddress();

    bool isConnectedToActiveNetwork();

    bool isConnectedToWifi();

    bool isCurrentlyRoaming();


public slots:

private:
    bool mIsConnected;
    const QString BROADCASTMESSAGE = "Broadcast controller";

    const int BROADCASTPORT = 3912;
    const int BUFFERTIMEOUT = 100;
};

#endif // SMARTCALENDARACCESSIMPL_H
