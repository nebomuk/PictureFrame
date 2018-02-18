#include "controllerconnectionmanagerimpl.h"
#include "controllerdatacontainer.h"
#include "devicemanagermodel.h"
#include "platformhelper.h"
#include "smartcalendaraccessimpl.h"

//#define USE_QAPPLICATION


#if (defined(Q_OS_WIN) || defined(Q_OS_LINUX) || defined(Q_OS_OSX)) && defined(USE_QAPPLICATION)
#include <QApplication>
#else
#include <QGuiApplication>
#endif

#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

#if (defined(Q_OS_WIN) || defined(Q_OS_LINUX) || defined(Q_OS_OSX)) && defined(USE_QAPPLICATION)
    QApplication app(argc,argv);
#else
    QGuiApplication app(argc, argv);
#endif

   // qmlRegisterSingletonType<ControllerConnectionManagerImpl>("de.vitecvisual.core",1,0,"ControllerConnectionManager",&ControllerConnectionManagerImpl::singletontype_provider);
    qmlRegisterSingletonType<SmartCalendarAccessImpl>("de.vitecvisual.core", 1, 0, "SmartCalendarAccess", &SmartCalendarAccessImpl::singletontype_provider);
    qmlRegisterSingletonType<PlatformHelper>("de.vitecvisual.native",1,0,"PlatformHelper",&PlatformHelper::singletontype_provider);

    qmlRegisterSingletonType( QUrl("qrc:/src/Style.qml"), "de.vitecvisual.style", 1, 0, "Style" );
    qRegisterMetaType<ResponderClient>();
    qmlRegisterSingletonType(QUrl("qrc:/src/NotifyingSettings.qml"),"de.vitecvisual.util",1,0,"NotifyingSettings");
    qmlRegisterType<DeviceManagerModel>("de.vitecvisual.model",1,0,"DeviceManagerModel");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/src/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
