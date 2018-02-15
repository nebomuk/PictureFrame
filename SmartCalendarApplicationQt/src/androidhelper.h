#ifndef ANDROIDHELPER_H
#define ANDROIDHELPER_H

#include <QObject>

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

    // TODO implement bitmap conversion https://www.kdab.com/qt-on-android-how-to-convert-qt-images-to-android-images-and-vice-versa-2/
    // to show bitmap previes

public slots:
    void showWifiSettings();
    void showToast(const QString &message, Duration duration = LONG);



};

#endif // ANDROIDHELPER_H
