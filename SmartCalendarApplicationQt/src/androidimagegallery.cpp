#include "androidimagegallery.h"
#include <QAndroidJniObject>

AndroidImageGallery::AndroidImageGallery(QObject *parent) : IImageGallery(parent)
{

}


// based on
// https://forum.qt.io/topic/66324/qt-android-image-picker-issue-with-android-5-5-1/3
void AndroidImageGallery::openGallery()
{
    QAndroidJniObject Intent__ACTION_PICK = QAndroidJniObject::getStaticObjectField("android/content/Intent", "ACTION_PICK", "Ljava/lang/String;");
    qDebug() << "AndroidImagePicker Intent__ACTION_PICK.isValid()=" << Intent__ACTION_PICK.isValid();

    QAndroidJniObject EXTERNAL_CONTENT_URI= QAndroidJniObject::getStaticObjectField("android/provider/MediaStore$Images$Media", "EXTERNAL_CONTENT_URI", "Landroid/net/Uri;");
    qDebug() << "AndroidImagePicker EXTERNAL_CONTENT_URI.isValid()=" << EXTERNAL_CONTENT_URI.isValid();

    QAndroidJniObject intent=QAndroidJniObject("android/content/Intent",
        "(Ljava/lang/String;Landroid/net/Uri;)V",
        Intent__ACTION_PICK.object<jstring>(),
        EXTERNAL_CONTENT_URI.object<jobject>()
    );

    qDebug() << "AndroidImagePicker intent.isValid()=" << intent.isValid();

    QtAndroid::startActivity(intent, 101, this);
}

// TODO Permission ?
void AndroidImageGallery::handleActivityResult(int receiverRequestCode, int resultCode, const QAndroidJniObject &data)
{
    jint RESULT_OK = QAndroidJniObject::getStaticField<jint>("android/app/Activity", "RESULT_OK");

    if( receiverRequestCode == 101 && resultCode == RESULT_OK )
    {
        QAndroidJniObject uri = data.callObjectMethod("getData", "()Landroid/net/Uri;");

        qDebug("AndroidImagePicker uri = %s", qPrintable(uri.toString()));

        QAndroidJniObject path1 = QAndroidJniObject::callStaticObjectMethod("de/vitecvisual/java/QExtendedSharePathResolver"
                                                                              , "getRealPathFromUri" // Uri upper or lower case?
                                                                              , "(Landroid/net/Uri;)Ljava/lang/String;"
                                                                              , uri.object<jobject>());
        qDebug() << "path.isValid()=" << path1.isValid();


        QString imagePath = "file://" +  path1.toString();
        qDebug() << "AndroidImagePicker path" << imagePath;

        mImageFilePath = imagePath;

        QMetaObject::invokeMethod(this, [this](){
            QTimer::singleShot(1000,this,[this](){emit this->imageFilePathChanged(this->mImageFilePath);});
        }, Qt::QueuedConnection);
    }
}
