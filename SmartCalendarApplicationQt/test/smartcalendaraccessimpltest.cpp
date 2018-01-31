#include "smartcalendaraccessimpltest.h"
#include <QtDebug>

void SmartCalendarAccessImplTest::initTestCase()
{
}


void SmartCalendarAccessImplTest::GetAllAvailableDevicesInNetworkTest()
{
    auto devices =  mSmartcalendarAccessImpl.getAllAvailableDevicesInNetwork();

    QVERIFY2(!devices.empty(),"no devices found");
    if(!devices.empty())
    {
        qDebug() << "found devices: " << devices;
    }
}

void SmartCalendarAccessImplTest::GetControllerInNetworkFromBroadcastTest()
{
    auto controllers = mSmartcalendarAccessImpl.getControllerInNetworkFromBroadcast(2000);
    if(controllers.empty())
    {
        QWARN("No Controllers found, java MQTT Client not running?");
    }
}

void SmartCalendarAccessImplTest::cleanupTestCase()
{
}
