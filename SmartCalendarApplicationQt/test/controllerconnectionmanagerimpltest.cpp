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
    auto uuid = QUuid::createUuid().toString().mid(1, 36).toUpper();
    QVERIFY2(mControllerConnectionManagerImpl->establishConnection(uuid),"establishConnection() failed");
    mControllerConnectionManagerImpl->closeConnection();
}

void ControllerConnectionManagerImplTest::cleanupTestCase()
{
    delete mControllerConnectionManagerImpl;
}
