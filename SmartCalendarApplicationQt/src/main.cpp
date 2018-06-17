#include "controllerconnectionmanagerimpl.h"
#include "controllerdatacontainer.h"
#include "deviceaccessorimpl.h"
#include "googlecalendarauthorization.h"
#include "iimagecapture.h"
#include "iimagegallery.h"
#include "imagecropper.h"
#include "loggingfilter.h"
#include "smartcalendaraccessimpl.h"
#include "messagehandler.h"
#include "simplesettings.h"


#include <QLoggingCategory>
#include <QQmlContext>

#ifdef Q_OS_ANDROID
#include "androidhelper.h"
#include "androidimagecapture.h"
#include "androidimagegallery.h"
#endif

#define USE_QAPPLICATION


#if (defined(Q_OS_WIN) || defined(Q_OS_LINUX) || defined(Q_OS_OSX)) && defined(USE_QAPPLICATION)
#include <QApplication>
#else
#include <QGuiApplication>
#endif

#include <QDir>
#include <QFontDatabase>
#include <QQmlApplicationEngine>

//#include <QAndroidJniObject>
//int fibonacci(int n)
//{
//    return QAndroidJniObject::callStaticMethod<jint>
//                        ("de/vitecvisual/java/MyJavaClass" // class name
//                        , "fibonacci" // method name
//                        , "(I)I" // signature
//                        , n);
//}

template<class T>
QObject *newObject(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return new T;
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QCoreApplication::setApplicationName("Smart Calendar Thync");
    QCoreApplication::setOrganizationName("Vitec Visual");
    QCoreApplication::setOrganizationDomain("vitec-visual.de");

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
    qmlRegisterSingletonType<DeviceAccessorImpl>("de.vitecvisual.core",1,0,"DeviceAccessor",&newObject<DeviceAccessorImpl>);
    qmlRegisterSingletonType<SmartCalendarAccessImpl>("de.vitecvisual.core", 1, 0, "SmartCalendarAccess", &newObject<SmartCalendarAccessImpl>);
    qmlRegisterSingletonType<ImageCropper>("de.vitecvisual.core",1,0,"ImageCropper",&newObject<ImageCropper>);
    qmlRegisterSingletonType<LoggingFilter>("de.vitecvisual.core",1,0,"LoggingFilter",&newObject<LoggingFilter>);
    qmlRegisterSingletonType<LoggingFilter>("de.vitecvisual.core",1,0,"MessageHandler",&newObject<MessageHandler>);
    qmlRegisterSingletonType<SimpleSettings>("de.vitecvisual.core",1,0,"SimpleSettings",&newObject<SimpleSettings>);


    // instantiable C++ types
#ifdef Q_OS_ANDROID
    qmlRegisterType<AndroidImageGallery>("de.vitecvisual.native",1,0,"ImageGallery");
#elif Q_OS_IOS
    qmlRegisterType<IImageGallery>("de.vitecvisual.native",1,0,"ImageGallery");
#else
    qmlRegisterType<IImageGallery>("de.vitecvisual.native",1,0,"ImageGallery");
#endif



#ifdef Q_OS_ANDROID
    qmlRegisterType<AndroidImageCapture>("de.vitecvisual.native",1,0,"ImageCapture");
#elif Q_OS_IOS
    qmlRegisterType<IImageCapture>("de.vitecvisual.native",1,0,"ImageCapture");
#else
    qmlRegisterType<IImageCapture>("de.vitecvisual.native",1,0,"ImageCapture");
#endif

    qmlRegisterType<GoogleCalendarAuthorization>("de.vitecvisual.core",1,0,"GoogleCalendarAuthorization");


    // uncreatable return types
    qmlRegisterType<O2Google>();

    qmlRegisterModule("de.vitecvisual.native",1,0);

    // QML singletons
    qmlRegisterSingletonType( QUrl("qrc:/src/Style.qml"), "de.vitecvisual.style", 1, 0, "Style" );
    qmlRegisterSingletonType(QUrl("qrc:/src/NotifyingSettings.qml"),"de.vitecvisual.util",1,0,"NotifyingSettings");

    // Q_GADGET type return type
    qRegisterMetaType<ResponderClient>();

    // pointer type Q_PROPERTY
    qRegisterMetaType<ControllerDataContainer*>("ControllerDataContainer");
    qmlRegisterUncreatableType<ControllerDataContainer>("de.vitecvisual.core",1,0,"ControllerDataContainer","Property of DeviceAccessor singleton");

    // enums
    //qRegisterMetaType<QNetworkReply::NetworkError>("QNetworkReply::NetworkError");

    qmlRegisterType<QNetworkReply>();


    QQmlApplicationEngine engine;

    QString qmlFsPath = QUrl(QSettings().value("qmlFsPath","").toString()).toLocalFile();
    QString mainQmlFile = QDir(qmlFsPath).filePath("main.qml");
    if(QFile::exists(mainQmlFile) && QFileInfo(mainQmlFile).isReadable() && QSettings().value("checkBoxLoadQmlFromFs",false).toBool())
    {
        qDebug("loading main.qml from local file system");
        engine.rootContext()->setContextProperty("loadedFromLocalFs",true);
        engine.load(mainQmlFile);
    }
    else
    {
        qDebug("loading main.qml from embedded resources");
        engine.rootContext()->setContextProperty("loadedFromLocalFs",false);
        engine.load(QUrl(QStringLiteral("qrc:/src/main.qml")));
    }
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}


