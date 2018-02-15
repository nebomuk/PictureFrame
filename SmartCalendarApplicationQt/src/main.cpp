#include "devicemanagermodel.h"
#include "platformhelper.h"

#if defined(Q_OS_WIN) || defined(Q_OS_LINUX) || defined(Q_OS_OSX)
#include <QApplication>
#else
#include <QGuiApplication>
#endif

#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

#if defined(Q_OS_WIN) || defined(Q_OS_LINUX) || defined(Q_OS_OSX)
    QApplication app(argc,argv);
#else
    QGuiApplication app(argc, argv);
#endif

    qmlRegisterSingletonType<PlatformHelper>("de.vitecvisual.native",1,0,"PlatformHelper",&PlatformHelper::platform_helper_singletontype_provider);
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
