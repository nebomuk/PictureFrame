#include "devicemanagermodel.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

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
