#ifndef ANDROIDIMAGEPICKER_H
#define ANDROIDIMAGEPICKER_H


#include <QtAndroidExtras>
#include <QAndroidActivityResultReceiver>

#include <QDebug>

class AndroidImagePicker : public QObject, QAndroidActivityResultReceiver
{
    Q_OBJECT

public:
    AndroidImagePicker(QObject *parent = nullptr);

    void openImagePicker();
    virtual void handleActivityResult(int receiverRequestCode, int resultCode, const QAndroidJniObject &data);

signals:
    void imageFilePathChanged();
};

#endif // ANDROIDIMAGEPICKER_H
