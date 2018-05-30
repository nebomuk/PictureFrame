#ifndef IIMAGEGALLERY_H
#define IIMAGEGALLERY_H

#include <QObject>

/**
 * @brief The IImagePicker class is used as an interface for platform dependent implementations
 */
class IImageGallery : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString imageFilePath MEMBER imageFilePath)

public:
    IImageGallery();

public slots:
    virtual void openGallery();

private:
    QString imageFilePath;

};


#endif // IIMAGEGALLERY_H
