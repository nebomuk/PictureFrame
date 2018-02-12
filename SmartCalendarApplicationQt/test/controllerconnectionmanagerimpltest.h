#ifndef CONTROLLERCONNECTIONMANAGERIMPLTEST_H
#define CONTROLLERCONNECTIONMANAGERIMPLTEST_H

#include <QObject>
#include <QTest>
#include "../src/controllerconnectionmanagerimpl.h"

class ControllerConnectionManagerImplTest : public QObject
{
    Q_OBJECT
public:
    explicit ControllerConnectionManagerImplTest(QObject *parent = nullptr);

private slots:
    void initTestCase();
    void establishConnectionTest();
    void cleanupTestCase();

private:
    ControllerConnectionManagerImpl * mControllerConnectionManagerImpl;
    ControllerDataContainer * mControllerDataContainer;
};

#endif // CONTROLLERCONNECTIONMANAGERIMPLTEST_H
