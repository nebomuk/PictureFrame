#include "platformhelper.h"

PlatformHelper::PlatformHelper(QObject *parent) : QObject(parent)
{

}

QObject *PlatformHelper::singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    QObject *object;

#ifdef Q_O_ANDROID
    object = new AndroidHelper();
#else
    object = new QObject();
#endif

    return object;
}
