#include "imagecropper.h"
#include <QImage>
#include <QUrl>
#include <QtDebug>
#include <QBuffer>
#include <QImageReader>
#include <QQmlEngine>

ImageCropper::ImageCropper(QObject *parent) : QObject(parent)
{

}

QString ImageCropper::crop(QRectF rect)
{
    if(!mImageFileUrl.isValid() && !mImageFileUrl.isLocalFile())
    {
        qDebug() << __FUNCTION__ << "failed: not a valid url " << mImageFileUrl;
        return "";
    }

    QImage image(mImageFileUrl.path());
    if(image.isNull())
    {
        qDebug() << __FUNCTION__ << "failed to load image from path" << mImageFileUrl.path();
        return "";
    }

    qDebug() << __FUNCTION__ << " original size " << image.size();
    QImage scaledImage = image.scaled(QSize(1024,600),Qt::AspectRatioMode::KeepAspectRatioByExpanding,Qt::TransformationMode::SmoothTransformation);
    qDebug() << __FUNCTION__ <<  " scaled size with KeepAspectRatioByExpanding " << scaledImage.size();
    qDebug() << __FUNCTION__ << " cut rect " << rect;
    QImage croppedImage = scaledImage.copy(rect.toRect());

    QByteArray ba;
    QBuffer buffer(&ba);
    buffer.open(QIODevice::WriteOnly);
    croppedImage.save(&buffer, "JPG");
    QString base64 = ba.toBase64();
    qDebug() << __FUNCTION__ << " first few base 64 bytes chars are " << base64.left(15);
    return base64;
}

QUrl ImageCropper::imageFileUrl() const
{
    return mImageFileUrl;
}

void ImageCropper::setImageFileUrl(const QUrl &imageFilePath)
{
    mImageFileUrl = imageFilePath;
}

