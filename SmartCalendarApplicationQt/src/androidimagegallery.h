#ifndef ANDROIDIMAGEGALLERY_H
#define ANDROIDIMAGEGALLERY_H


#include "iimagegallery.h"

#include <QtAndroidExtras>
#include <QAndroidActivityResultReceiver>

#include <QDebug>

class AndroidImageGallery : public IImageGallery, public QAndroidActivityResultReceiver
{
    Q_OBJECT

    Q_PROPERTY(QString imageFilePath MEMBER mImageFilePath NOTIFY imageFilePathChanged)

public:
    AndroidImageGallery(QObject *parent = nullptr);



    virtual void handleActivityResult(int receiverRequestCode, int resultCode, const QAndroidJniObject &data);

public slots:

    void openGallery();
signals:
    void imageFilePathChanged(QString filePath);

private:
    QString mImageFilePath;
};

#endif // ANDROIDIMAGEGALLERY_H
