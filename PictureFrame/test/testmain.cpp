#include "controllerconnectionmanagerimpltest.h"
#include "mqtttest.h"
#include "smartcalendaraccessimpltest.h"

#include <QtTest>
#include <QTextCodec>
#include <QtWidgets/QApplication>
//#include "moc_smartcalendaraccessimpl.cpp"


int main(int argc, char** argv) {
    QApplication app(argc, argv);
//    QTextCodec::setCodecForTr(QTextCodec::codecForName("UTF-8"));
//    QTextCodec::setCodecForCStrings(QTextCodec::codecForName("UTF-8"));


    SmartCalendarAccessImplTest scait;
    MqttTest mqtttest;
    ControllerConnectionManagerImplTest ccmitest;

    // multiple test suites can be ran like this

    return
            QTest::qExec(&scait, argc, argv) |
             QTest::qExec(&mqtttest,argc,argv)
            | QTest::qExec(&ccmitest,argc,argv);
}
