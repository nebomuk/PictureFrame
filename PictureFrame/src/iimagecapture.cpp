#include "iimagecapture.h"
#include <QDebug>

IImageCapture::IImageCapture(QObject *parent) : QObject(parent)
{

}

void IImageCapture::captureImage()
{
    qWarning() << __FUNCTION__ << " implementation stub";
}
