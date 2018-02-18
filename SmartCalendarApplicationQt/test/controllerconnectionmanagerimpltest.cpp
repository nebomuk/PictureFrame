#include "controllerconnectionmanagerimpltest.h"

#include <QSignalSpy>
#include <QUuid>

ControllerConnectionManagerImplTest::ControllerConnectionManagerImplTest(QObject *parent) : QObject(parent)
{

}

void ControllerConnectionManagerImplTest::initTestCase()
{
    mControllerConnectionManagerImpl = new ControllerConnectionManagerImpl(this);
}

void ControllerConnectionManagerImplTest::establishConnectionBlockingTest()
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

void ControllerConnectionManagerImplTest::establishConnectionTest()
{
    QSKIP("This test can only be run if establishConnectionTest() does not run, because one of the tests will fail when there are two connections in rapid successsion");


    auto uuid = QUuid::createUuid().toString().mid(1, 36).toUpper();

    QSignalSpy spy(mControllerConnectionManagerImpl,SIGNAL(establishConnectionResult(bool)));
    mControllerConnectionManagerImpl->establishConnection(QHostAddress(QHostAddress::LocalHost).toString(),uuid);
    QVERIFY(spy.wait(4000));

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
