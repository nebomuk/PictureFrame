#ifndef IIMAGECAPTURE_H
#define IIMAGECAPTURE_H

#include <QString>
#include <QtPlugin>



class IImageCapture
{

public:

    IImageCapture() = delete;

    virtual void captureImage() = 0;

    virtual const QString& imageFilePath() const = 0;

protected: // <- ignored by moc and only serves as documentation aid
           // The code will work exactly the same if signals: is absent.
    virtual void imageFilePathChanged() = 0;
};

Q_DECLARE_INTERFACE(IImageCapture,"IImageCapture")

#endif // IIMAGECAPTURE_H
