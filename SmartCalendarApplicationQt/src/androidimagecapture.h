#ifndef __MY_CONTROLLER_H__
#define __MY_CONTROLLER_H__

#include <QObject>
#include <QAndroidActivityResultReceiver>
#include "iimagecapture.h"

class AndroidImageCapture : public QObject, QAndroidActivityResultReceiver, public IImageCapture

{
	Q_OBJECT
    Q_PROPERTY(QString imageFilePath READ imageFilePath NOTIFY imageFilePathChanged)


public:
    explicit AndroidImageCapture(QObject * parent);

    const QString& imageFilePath() const { return this->mImageFilePath; }

public:
    Q_INVOKABLE void captureImage();

signals:
    void imageFilePathChanged();

private:
    QAndroidJniObject savedImageUri;
	void handleActivityResult(int receiverRequestCode, int resultCode, const QAndroidJniObject & data);

    void startCameraActivity();

    QString mImageFilePath;

};

#endif
