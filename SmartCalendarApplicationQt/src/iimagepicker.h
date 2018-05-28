#ifndef IIMAGEPICKER_H
#define IIMAGEPICKER_H

#include <QObject>

/**
 * @brief The IImagePicker class is used as an interface for platform dependent implementations
 */
class IImagePicker : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString imageFilePath MEMBER imageFilePath)

public:
    IImagePicker();

public slots:
    virtual void openImagePicker();

private:
    QString imageFilePath;

};


#endif // IIMAGEPICKER_H
