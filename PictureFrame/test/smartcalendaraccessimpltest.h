#ifndef SMARTCALENDARACCESSIMPLTEST_H
#define SMARTCALENDARACCESSIMPLTEST_H

#include <QObject>
#include <QTest>

#include "../src/smartcalendaraccessimpl.h"

class SmartCalendarAccessImplTest : public QObject
{
    Q_OBJECT
private slots:
    void initTestCase();
    void GetControllerInNetworkFromBroadcastBlockingTest();
    void GetControllerInNetworkFromBroadcastTest();
    void GetAllAvailableDevicesInNetworkTest();
    void cleanupTestCase();

    void IsConnectedToWifiTest();

private:
    SmartCalendarAccessImpl mSmartcalendarAccessImpl;
};

#endif // SMARTCALENDARACCESSIMPLTEST_H
