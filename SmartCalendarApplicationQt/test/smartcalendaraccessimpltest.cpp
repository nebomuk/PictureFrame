#include "smartcalendaraccessimpltest.h"
#include <QtDebug>

void SmartCalendarAccessImplTest::initTestCase()
{
    qDebug("called before everything else"); }

void SmartCalendarAccessImplTest::mySecondTest()
{ QVERIFY(1 != 2); }

void SmartCalendarAccessImplTest::GetAllAvailableDevicesInNetworkTest()
{
    qDebug() << "printing all devices in network";
    qDebug() << mSmartcalendarAccessImpl.GetAllAvailableDevicesInNetwork();
}

void SmartCalendarAccessImplTest::GetControllerInNetworkFromBroadcastTest()
{
    qDebug() << "printing controller in network";

    qDebug() << mSmartcalendarAccessImpl.GetControllerInNetworkFromBroadcast(2000);
}

void SmartCalendarAccessImplTest::cleanupTestCase()
{ qDebug("called after myFirstTest and mySecondTest"); }

void SmartCalendarAccessImplTest::myFirstTest()
{ QVERIFY(1 == 1); }
