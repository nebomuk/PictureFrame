#ifndef ANDROIDIMAGEPICKER_H
#define ANDROIDIMAGEPICKER_H


#include "iimagepicker.h"

#include <QtAndroidExtras>
#include <QAndroidActivityResultReceiver>

#include <QDebug>

class AndroidImagePicker : public IImagePicker, public QAndroidActivityResultReceiver
{
    Q_OBJECT

    Q_PROPERTY(QString imageFilePath MEMBER mImageFilePath NOTIFY imageFilePathChanged)

public:
    AndroidImagePicker(QObject *parent = nullptr);



    virtual void handleActivityResult(int receiverRequestCode, int resultCode, const QAndroidJniObject &data);

public slots:

    void openImagePicker();
signals:
    void imageFilePathChanged(QString filePath);

private:
    QString mImageFilePath;
};

#endif // ANDROIDIMAGEPICKER_H
