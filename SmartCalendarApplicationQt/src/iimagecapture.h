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

    Q_PROPERTY(QString imageFilePath MEMBER imageFilePath)

public:

    IImageCapture();

public slots:

    virtual void captureImage();

private:
    QString imageFilePath;
};

#endif // IIMAGECAPTURE_H
