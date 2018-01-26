#include <QObject>
#include <QTest>

#include <src/smartcalendaraccessimpl.h>

class SmartCalendarAccessImplTest : public QObject
{
    Q_OBJECT
private slots:
    void initTestCase();
    void GetControllerInNetworkFromBroadcastTest();
    void GetAllAvailableDevicesInNetworkTest();
    void cleanupTestCase();

private:
    SmartCalendarAccessImpl mSmartcalendarAccessImpl;
};


