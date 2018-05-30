#ifndef __MY_CONTROLLER_H__
#define __MY_CONTROLLER_H__

#include <QObject>
#include <QAndroidActivityResultReceiver>
#include "iimagecapture.h"

class AndroidImageCapture : public IImageCapture, public QAndroidActivityResultReceiver

{
	Q_OBJECT
    Q_PROPERTY(QString imageFilePath READ imageFilePath NOTIFY imageFilePathChanged)


public:
    explicit AndroidImageCapture(QObject * parent = nullptr);

    const QString& imageFilePath() const { return this->mImageFilePath; }

    virtual void  handleActivityResult(int receiverRequestCode, int resultCode, const QAndroidJniObject & data);

public slots:
    void captureImage();

signals:
    void imageFilePathChanged();

private:
    QAndroidJniObject savedImageUri;

    void startCameraActivity();

    QString mImageFilePath;

};

#endif
