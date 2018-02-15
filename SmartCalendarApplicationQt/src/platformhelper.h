#ifndef PLATFORMHELPER_H
#define PLATFORMHELPER_H

#include <QObject>
#include <QQmlEngine>

#ifdef Q_OS_ANDROID
#include "androidhelper.h"
#endif

/// instantiates the android (or other platform) singleton in the qml environment
/// FIXME this only provides the object but does not provide typesafe method calls in javascript

class PlatformHelper : public QObject
{
    Q_OBJECT
public:
    explicit PlatformHelper(QObject *parent = nullptr);



// singleton type provider function (callback).
static QObject *singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine);
};

#endif // PLATFORMHELPER_H
