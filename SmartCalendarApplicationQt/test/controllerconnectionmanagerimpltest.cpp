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

    QTest::qWait(1000); // wait until all stuff received, establishConnectionBlocking will only block until first json received

    auto mControllerDataContainer = mControllerConnectionManagerImpl->dataContainer();

    // will fail if mosquitto mqtt broker not running on port 1337
    QVERIFY(!mControllerDataContainer->personList().isEmpty());
    QVERIFY(!mControllerDataContainer->baseOptions().isEmpty());
    QVERIFY(!mControllerDataContainer->displayOptions().isEmpty());


    mControllerConnectionManagerImpl->closeConnection();
}

void ControllerConnectionManagerImplTest::establishConnectionTest()
{
    QSKIP("only one establishConnnectionTest can be run in a single test run");

    auto uuid = QUuid::createUuid().toString().mid(1, 36).toUpper();

    QSignalSpy spy(mControllerConnectionManagerImpl,SIGNAL(establishConnectionResult(bool)));
    mControllerConnectionManagerImpl->establishConnection(QHostAddress(QHostAddress::LocalHost).toString(),uuid);
    QVERIFY(spy.wait(4000)); // fires only after first json received, not all

    auto mControllerDataContainer = mControllerConnectionManagerImpl->dataContainer();

    // will fail if mosquitto mqtt broker not running on port 1337
    // may fails if data not yet arrived
    QVERIFY(!mControllerDataContainer->personList().isEmpty());
    QVERIFY(!mControllerDataContainer->baseOptions().isEmpty());
    QVERIFY(!mControllerDataContainer->displayOptions().isEmpty());


    mControllerConnectionManagerImpl->closeConnection();

}

void ControllerConnectionManagerImplTest::cleanupTestCase()
{
    delete mControllerConnectionManagerImpl;
}
