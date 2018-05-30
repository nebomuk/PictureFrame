#include "androidimagecapture.h"

#ifdef Q_OS_ANDROID
#include <QAndroidIntent>
#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>
#include <QtAndroid>
#include <QRandomGenerator>
#include <QUrl>
#endif

#include <QDebug>

const int REQUEST_CODE = 91;

AndroidImageCapture::AndroidImageCapture(QObject *parent) : IImageCapture(parent)
{

}

void AndroidImageCapture::captureImage()


{
    QtAndroid::requestPermissions(QStringList("android.permission.WRITE_EXTERNAL_STORAGE"), [this](QtAndroid::PermissionResultMap resultHash){
            if(resultHash["android.permission.WRITE_EXTERNAL_STORAGE"] == QtAndroid::PermissionResult::Granted)
            {
                qDebug("permission android.permission.WRITE_EXTERNAL_STORAGE granted");
                startCameraActivity();
            }
            else
            {
                qDebug("permission android.permission.WRITE_EXTERNAL_STORAGE denied");
           }
        });
}

void AndroidImageCapture::handleActivityResult(int receiverRequestCode, int resultCode, const QAndroidJniObject & data)
{
    Q_UNUSED(data);

	jint Activity__RESULT_OK = QAndroidJniObject::getStaticField<jint>(
				"android.app.Activity", "RESULT_OK");

    if ( receiverRequestCode == REQUEST_CODE && resultCode == Activity__RESULT_OK )
	{
        qDebug() << "savedImageUri:" << savedImageUri.toString();

        QAndroidJniObject imageFilePath = savedImageUri.callObjectMethod("getPath","()Ljava/lang/String;");
        qDebug() << __FUNCTION__ << "imageFilePath.isValid()=" << imageFilePath.isValid();

        mImageFilePath = "file:" + imageFilePath.toString();
        emit this->imageFilePathChanged();
    }
}

void AndroidImageCapture::startCameraActivity()
{
    //android.provider.MediaStore.EXTRA_OUTPUT
    QAndroidJniObject MediaStore__EXTRA_OUTPUT
            = QAndroidJniObject::getStaticObjectField(
                "android/provider/MediaStore", "EXTRA_OUTPUT", "Ljava/lang/String;");
    qDebug() << "MediaStore__EXTRA_OUTPUT.isValid()=" << MediaStore__EXTRA_OUTPUT.isValid();

    // only external storage seems to work here
    // cannot use camera intent to save to app private directory
    // TODO requires runtime permission
    // https://forum.qt.io/topic/88839/qstandardpaths-android/7

    // if not desired to create spam file in external storage, use this approach
    // https://stackoverflow.com/questions/20327213/getting-path-of-captured-image-in-android-using-camera-intent

//    QAndroidJniObject externalStorage = QAndroidJniObject::callStaticObjectMethod(
//                "android/os/Environment", "getExternalStorageDirectory", "()Ljava/io/File;");
//    qDebug() << "externalStorage.isValid()=" << externalStorage.isValid();

    QAndroidJniObject object = QAndroidJniObject::getStaticObjectField<jstring>("android.os.Environment", "DIRECTORY_DCIM");
    QAndroidJniObject pictureDirectory = QAndroidJniObject::callStaticObjectMethod("android.os.Environment", "getExternalStoragePublicDirectory", "(Ljava/lang/String;)Ljava/io/File;", object.object<jobject>());

    quint32 value = QRandomGenerator::global()->generate();
    QAndroidJniObject filename = QAndroidJniObject::fromString(QString("sca_temp%1.jpg").arg(value));

    QAndroidJniObject image=QAndroidJniObject("java/io/File","(Ljava/io/File;Ljava/lang/String;)V",
                                               pictureDirectory.object<jobject>(), filename.object<jstring>());
    qDebug() << __FUNCTION__ << "image.isValid()=" << image.isValid();

    savedImageUri = QAndroidJniObject::callStaticObjectMethod(
                "android/net/Uri", "fromFile", "(Ljava/io/File;)Landroid/net/Uri;", image.object<jobject>());
    qDebug() << "savedImageUri.isValid()=" << savedImageUri.isValid();

    QAndroidIntent  intent = QAndroidIntent("android.media.action.IMAGE_CAPTURE");

    qDebug() << __FUNCTION__ << "intent.isValid()=" << intent.handle().isValid();

    intent.handle().callObjectMethod(
                "putExtra","(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;",
                MediaStore__EXTRA_OUTPUT.object<jstring>(), savedImageUri.object<jobject>());


    qDebug() << __FUNCTION__ << "intent.isValid()=" << intent.handle().isValid();


    QtAndroid::startActivity(intent.handle(), REQUEST_CODE, this);

}
