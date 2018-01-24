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
    // multiple test suites can be ran like this
    return QTest::qExec(&scait, argc, argv);
}
