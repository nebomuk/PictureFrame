#include "platformhelper.h"

#ifdef Q_OS_ANDROID
#include "androidimagecapture.h"
#include "androidimagepicker.h"
#elif Q_OS_IOS
#endif

PlatformHelper::PlatformHelper(QObject *parent) : QObject(parent)
{
    #ifdef Q_OS_ANDROID
    mImageCapture = new AndroidImageCapture(this);
    #elif Q_OS_IOS
    mImageCapture = nullptr;
    #else
    mImageCapture = nullptr;
    #endif

    connect(mImageCapture,&IImageCapture::imageFilePathChanged,this,&PlatformHelper::captureImageFilePathChanged);
    connect(mImageCapture,&IImageCapture::imageFilePathChanged,this,&PlatformHelper::captureImageFilePathChanged);

}

QString PlatformHelper::captureImageFilePath() const
{
    return mImageCapture->imageFilePath();
}

QString PlatformHelper::pickerImageFilePath() const
{

}

void PlatformHelper::captureImage()
{
    mImageCapture->captureImage();
}

void PlatformHelper::openImagePicker()
{
}

