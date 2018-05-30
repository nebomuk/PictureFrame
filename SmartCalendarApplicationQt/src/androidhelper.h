

#ifndef ANDROIDHELPER_H
#define ANDROIDHELPER_H

#include <QObject>
#include <QQmlEngine>
#include "androidimagegallery.h"

class AndroidHelper : public QObject
{
    Q_OBJECT



public:

    enum Duration {
        SHORT = 0,
        LONG = 1
    };

    Q_ENUM(Duration)

    explicit AndroidHelper(QObject *parent = nullptr);

public slots:
    void showWifiSettings();
    void showToast(const QString &message, Duration duration = LONG);

signals:
    void imagePathRetrieved(QString imagePath);

private:


};

#endif // ANDROIDHELPER_H
