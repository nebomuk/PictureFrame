#include "controllerconnectionmanagerimpl.h"
#include "controllerdatacontainer.h"
#include "deviceaccessorimpl.h"
#include "devicemanagermodel.h"
#include "googlecalendarauthorization.h"
#include "platformhelper.h"
#include "smartcalendaraccessimpl.h"

#include <QLoggingCategory>

#ifdef Q_OS_ANDROID
#include "androidhelper.h"
#endif

//#define USE_QAPPLICATION


#if (defined(Q_OS_WIN) || defined(Q_OS_LINUX) || defined(Q_OS_OSX)) && defined(USE_QAPPLICATION)
#include <QApplication>
#else
#include <QGuiApplication>
#endif

#include <QFontDatabase>
#include <QQmlApplicationEngine>

#include <QAndroidJniObject>
int fibonacci(int n)
{
    return QAndroidJniObject::callStaticMethod<jint>
                        ("de/vitecvisual/java/MyJavaClass" // class name
                        , "fibonacci" // method name
                        , "(I)I" // signature
                        , n);
}


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

    int res = fibonacci(23);


    // load Font Awesome icon font
    Q_ASSERT(QFontDatabase::addApplicationFont(":fa-solid-900.ttf") != -1);

    // log accidental binding ovewrite
    QLoggingCategory::setFilterRules(QStringLiteral("qt.qml.binding.removal.info=true"));

    qmlRegisterUncreatableMetaObject(QLocale::staticMetaObject,"QmlRegistered",1,0,"QLocale","Qt Core class registered for qml");

    // C++ singletons
    qmlRegisterSingletonType<GoogleCalendarAuthorization>("de.vitecvisual.core",1,0,"GoogleCalendarAuthorization",&GoogleCalendarAuthorization::singletontype_provider);
    qmlRegisterSingletonType<DeviceAccessorImpl>("de.vitecvisual.core",1,0,"DeviceAccessor",&DeviceAccessorImpl::singletontype_provider);
    qmlRegisterSingletonType<SmartCalendarAccessImpl>("de.vitecvisual.core", 1, 0, "SmartCalendarAccess", &SmartCalendarAccessImpl::singletontype_provider);

    qmlRegisterModule("de.vitecvisual.native",1,0);
#ifdef Q_OS_ANDROID
    qmlRegisterSingletonType<AndroidHelper>("de.vitecvisual.native",1,0,"AndroidHelper",&AndroidHelper::singletontype_provider);
#endif
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
