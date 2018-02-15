#ifndef PLATFORMHELPER_H
#define PLATFORMHELPER_H

#include <QObject>
#include <QQmlEngine>

#ifdef Q_OS_ANDROID
#include "androidhelper.h"
#endif

/// instantiates the android (or other platform) singleton in the qml environment

class PlatformHelper : public QObject
{
    Q_OBJECT
public:
    explicit PlatformHelper(QObject *parent = nullptr);



// singleton type provider function (callback).
static QObject *platform_helper_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
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
};

#endif // PLATFORMHELPER_H
