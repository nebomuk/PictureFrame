#ifndef IMAGECROPPER_H
#define IMAGECROPPER_H

#include <QObject>
#include <QRect>
#include <QUrl>

class ImageCropper : public QObject
{
    Q_PROPERTY(QUrl imageFileUrl READ imageFileUrl WRITE setImageFileUrl NOTIFY imageFilePathChanged)

    Q_OBJECT
public:
    explicit ImageCropper(QObject *parent = nullptr);


    QUrl imageFileUrl() const;
    void setImageFileUrl(const QUrl &imageFileUrl);

signals:
    void imageFilePathChanged();

public slots:
    // return value must be base64 for json and smartcalendar java app
    QString crop(QRectF rect);


private:
    QUrl mImageFileUrl;
};

#endif // IMAGECROPPER_H
