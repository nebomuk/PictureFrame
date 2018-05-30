#ifndef IIMAGECAPTURE_H
#define IIMAGECAPTURE_H

#include <QString>
#include <QtPlugin>

/**
 * @brief The IImageCapture is used as an interface for platform dependent implementations
 */

class IImageCapture : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString imageFilePath MEMBER imageFilePath  NOTIFY imageFilePathChanged)

public:

    IImageCapture(QObject* parent = nullptr);

public slots:

    virtual void captureImage();

signals:
    void imageFilePathChanged();

private:
    QString imageFilePath;
};

#endif // IIMAGECAPTURE_H
