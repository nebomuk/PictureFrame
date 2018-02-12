#include "controllerconnectionmanagerimpltest.h"

#include <QUuid>

ControllerConnectionManagerImplTest::ControllerConnectionManagerImplTest(QObject *parent) : QObject(parent)
{
    mControllerDataContainer =  new ControllerDataContainer();
    mControllerConnectionManagerImpl = new ControllerConnectionManagerImpl(QHostAddress(QHostAddress::LocalHost).toString(),mControllerDataContainer,this);
}

void ControllerConnectionManagerImplTest::initTestCase()
{

}

void ControllerConnectionManagerImplTest::establishConnectionTest()
{
    auto uuid = QUuid::createUuid().toString().mid(1, 36).toUpper();
    QVERIFY2(mControllerConnectionManagerImpl->establishConnection(uuid),"establishConnection() failed");

    QTest::qWait(1000); // wait until stuff received

    QVERIFY(!mControllerDataContainer->personList().isEmpty());
    QVERIFY(!mControllerDataContainer->baseOptions().isEmpty());
    QVERIFY(!mControllerDataContainer->smartCalendarDeviceOptionsDisplayOptions().isEmpty());


    mControllerConnectionManagerImpl->closeConnection();
}

void ControllerConnectionManagerImplTest::cleanupTestCase()
{
    delete mControllerConnectionManagerImpl;
}
