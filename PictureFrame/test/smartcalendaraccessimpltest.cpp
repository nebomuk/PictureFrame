#include "smartcalendaraccessimpltest.h"
#include <QNetworkConfiguration>
#include <QNetworkConfigurationManager>
#include <QSignalSpy>
#include <QtDebug>
#include <src/qvariantlistconversion.h>

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

void SmartCalendarAccessImplTest::GetControllerInNetworkFromBroadcastBlockingTest()
{
    QSKIP("This test can only be run if GetControllerInNetworkFromBroadcastTest() does not run, because one of the tests will fail when there are two "
          "broadcasts in rapid succession");

    auto controllers = mSmartcalendarAccessImpl.getControllerInNetworkFromBroadcastBlocking(2000);

    if(controllers.empty())
    {
        QWARN("No Controllers found, java MQTT Client not running?");
    }
    else
    {
        qDebug() << "found controllers: " << QVariantListConversion::fromVariantList(controllers);
    }
}


void SmartCalendarAccessImplTest::GetControllerInNetworkFromBroadcastTest()
{
    qRegisterMetaType<QList<ResponderClient>>();
    qRegisterMetaType<ResponderClient>();
    QSignalSpy spy(&mSmartcalendarAccessImpl, SIGNAL(controllerInNetworkReceived(QList<ResponderClient>)));
    mSmartcalendarAccessImpl.getControllerInNetworkFromBroadcast();
    QVERIFY(spy.wait(2000));

    QList<ResponderClient> controllers = qvariant_cast<QList<ResponderClient>>(spy.at(0).at(0));

    if(controllers.empty())
    {
        QWARN("No Controllers found, java MQTT Client not running?");
    }
    else
    {
        qDebug() << "found controllers: " << controllers;
    }

}

void SmartCalendarAccessImplTest::cleanupTestCase()
{
}

void SmartCalendarAccessImplTest::IsConnectedToWifiTest()
{
    QVERIFY(mSmartcalendarAccessImpl.isConnectedToWifi());
//    QNetworkConfigurationManager manager;
//    for(QNetworkConfiguration man : manager.allConfigurations(QNetworkConfiguration::Active))
//    {

//    qDebug() << man.bearerTypeName();
//    qDebug() << man.bearerType();
//    qDebug() << man.bearerTypeFamily();
//    }
}
