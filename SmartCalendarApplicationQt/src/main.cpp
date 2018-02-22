#include "controllerconnectionmanagerimpl.h"
#include "controllerdatacontainer.h"
#include "deviceaccessorimpl.h"
#include "devicemanagermodel.h"
#include "googlecalendarauthorization.h"
#include "platformhelper.h"
#include "smartcalendaraccessimpl.h"

#include <QLoggingCategory>

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

    // QApplication is required for the QWidget based Qml.labs message dialog on desktops,
    // but QApplication will use desktop style instead of material style
#if (defined(Q_OS_WIN) || defined(Q_OS_LINUX) || defined(Q_OS_OSX)) && defined(USE_QAPPLICATION)
    QApplication app(argc,argv);
#else
    QGuiApplication app(argc, argv);
#endif

    // log accidental binding ovewrite
    QLoggingCategory::setFilterRules(QStringLiteral("qt.qml.binding.removal.info=true"));

    qmlRegisterUncreatableMetaObject(QLocale::staticMetaObject,"QmlRegistered",1,0,"QLocale","Qt Core class registered for qml");

    // C++ singletons
    qmlRegisterSingletonType<GoogleCalendarAuthorization>("de.vitecvisual.core",1,0,"GoogleCalendarAuthorization",&GoogleCalendarAuthorization::singletontype_provider);
    qmlRegisterSingletonType<DeviceAccessorImpl>("de.vitecvisual.core",1,0,"DeviceAccessor",&DeviceAccessorImpl::singletontype_provider);
    qmlRegisterSingletonType<SmartCalendarAccessImpl>("de.vitecvisual.core", 1, 0, "SmartCalendarAccess", &SmartCalendarAccessImpl::singletontype_provider);
    qmlRegisterSingletonType<PlatformHelper>("de.vitecvisual.native",1,0,"PlatformHelper",&PlatformHelper::singletontype_provider);

    // instantiable C++ type
    qmlRegisterType<DeviceManagerModel>("de.vitecvisual.model",1,0,"DeviceManagerModel");

    // QML singletons
    qmlRegisterSingletonType( QUrl("qrc:/src/Style.qml"), "de.vitecvisual.style", 1, 0, "Style" );
    qmlRegisterSingletonType(QUrl("qrc:/src/NotifyingSettings.qml"),"de.vitecvisual.util",1,0,"NotifyingSettings");

    // Q_GADGET type return type
    qRegisterMetaType<ResponderClient>();

    // pointer type Q_PROPERTY
    qRegisterMetaType<ControllerDataContainer*>("ControllerDataContainer");
    qmlRegisterUncreatableType<ControllerDataContainer>("de.vitecvisual.core",1,0,"ControllerDataContainer","Property of DeviceAccessor singleton");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/src/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
