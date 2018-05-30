#include "iimagegallery.h"
#include <QtDebug>


IImageGallery::IImageGallery(QObject *parent) : QObject(parent)
{

}

void IImageGallery::openGallery()
{
    qWarning() << __FUNCTION__ << " implementation stub";
}
