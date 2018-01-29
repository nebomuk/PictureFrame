#include "controllerconnectionmanagerimpltest.h"

#include <QUuid>

ControllerConnectionManagerImplTest::ControllerConnectionManagerImplTest(QObject *parent) : QObject(parent)
{
    mControllerConnectionManagerImpl = new ControllerConnectionManagerImpl(QHostAddress(QHostAddress::LocalHost).toString(),new ControllerDataContainer(),this);
}

void ControllerConnectionManagerImplTest::initTestCase()
{

}

void ControllerConnectionManagerImplTest::establishConnectionTest()
{
    QVERIFY2(mControllerConnectionManagerImpl->establishConnection(QUuid::createUuid().toString()),"establishConnection() failed");
}

void ControllerConnectionManagerImplTest::cleanupTestCase()
{

}
