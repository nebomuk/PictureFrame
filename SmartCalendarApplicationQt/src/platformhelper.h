#ifndef PLATFORMHELPER_H
#define PLATFORMHELPER_H

#include "iimagecapture.h"

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

    Q_PROPERTY(QString captureImageFilePath READ captureImageFilePath NOTIFY captureImageFilePathChanged)

    Q_PROPERTY(QString pickerImageFilePath READ pickerImageFilePath NOTIFY pickerImageFilePathChanged)



public:
    explicit PlatformHelper(QObject *parent = nullptr);

    QString captureImageFilePath() const;
    QString pickerImageFilePath() const;

public slots:
    void captureImage();
    void openImagePicker();




signals:
    void captureImageFilePathChanged();
    void pickerImageFilePathChanged();

private:
    IImageCapture * mImageCapture;
};

#endif // PLATFORMHELPER_H
