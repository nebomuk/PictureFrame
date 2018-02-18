#include "controllerconnectionmanagerimpltest.h"

#include <QUuid>

ControllerConnectionManagerImplTest::ControllerConnectionManagerImplTest(QObject *parent) : QObject(parent)
{

}

void ControllerConnectionManagerImplTest::initTestCase()
{
    mControllerConnectionManagerImpl = new ControllerConnectionManagerImpl(this);
}

void ControllerConnectionManagerImplTest::establishConnectionTest()
{
    auto uuid = QUuid::createUuid().toString().mid(1, 36).toUpper();
    QVERIFY2(mControllerConnectionManagerImpl->establishConnectionBlocking(QHostAddress(QHostAddress::LocalHost).toString(),uuid),"establishConnection() failed");

    QTest::qWait(1000); // wait until stuff received

    auto mControllerDataContainer = mControllerConnectionManagerImpl->dataContainer();

    // will fail if mosquitto mqtt broker not running on port 1337
    QVERIFY(!mControllerDataContainer->personList().isEmpty());
    QVERIFY(!mControllerDataContainer->baseOptions().isEmpty());
    QVERIFY(!mControllerDataContainer->smartCalendarDeviceOptionsDisplayOptions().isEmpty());


    mControllerConnectionManagerImpl->closeConnection();
}

void ControllerConnectionManagerImplTest::cleanupTestCase()
{
    delete mControllerConnectionManagerImpl;
}
