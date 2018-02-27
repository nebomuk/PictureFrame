

#ifndef ANDROIDHELPER_H
#define ANDROIDHELPER_H

#include <QObject>
#include <QQmlEngine>
#include "androidimagepicker.h"

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

    // singleton type provider function (callback).
    static QObject *singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine);

    // TODO implement bitmap conversion https://www.kdab.com/qt-on-android-how-to-convert-qt-images-to-android-images-and-vice-versa-2/
    // to show bitmap previes

public slots:
    void showWifiSettings();
    void showToast(const QString &message, Duration duration = LONG);
    void openImagePicker();

signals:
    void imagePathRetrieved(QString imagePath);

private:
    AndroidImagePicker * imagePicker;


};

#endif // ANDROIDHELPER_H
