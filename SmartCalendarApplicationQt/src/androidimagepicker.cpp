#include "androidimagepicker.h"

AndroidImagePicker::AndroidImagePicker(QObject *parent) : QObject(parent)
{

}


// based on
// https://forum.qt.io/topic/66324/qt-android-image-picker-issue-with-android-5-5-1/3
void AndroidImagePicker::openImagePicker()
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
void AndroidImagePicker::handleActivityResult(int receiverRequestCode, int resultCode, const QAndroidJniObject &data)
{
    jint RESULT_OK = QAndroidJniObject::getStaticField<jint>("android/app/Activity", "RESULT_OK");

    if( receiverRequestCode == 101 && resultCode == RESULT_OK )
    {
        QAndroidJniObject uri = data.callObjectMethod("getData", "()Landroid/net/Uri;");

        qDebug("AndroidImagePicker uri = %s", qPrintable(uri.toString()));

        QAndroidJniObject path = QAndroidJniObject::callStaticMethod<jstring>("de/vitecvisual/java/QExtendedSharePathResolver"
                                                                              , "getRealPathFromUri" // Uri upper or lower case?
                                                                              , "Landroid/net/Uri;[Landroid/content/Context;"
                                                                              , n);

//        QAndroidJniObject dadosAndroid = QAndroidJniObject::getStaticObjectField("android/provider/MediaStore$MediaColumns", "DATA", "Ljava/lang/String;");
//        QAndroidJniEnvironment env;
//        jobjectArray projecao = (jobjectArray)env->NewObjectArray(1, env->FindClass("java/lang/String"), NULL);
//        jobject projacaoDadosAndroid = env->NewStringUTF(dadosAndroid.toString().toStdString().c_str());
//        env->SetObjectArrayElement(projecao, 0, projacaoDadosAndroid);

//        QAndroidJniObject contentResolver = QtAndroid::androidActivity().callObjectMethod("getContentResolver", "()Landroid/content/ContentResolver;");
//        QAndroidJniObject nullObj;

//        QAndroidJniObject cursor = contentResolver.callObjectMethod("query", "(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;", uri.object<jobject>(), projecao, nullObj.object<jstring>(), nullObj.object<jobjectArray>(), nullObj.object<jstring>());
//        qDebug() << "AndroidImagePicker cursor.isValid()=" << cursor.isValid();

//        jint columnIndex = cursor.callMethod<jint>("getColumnIndexOrThrow","(Ljava/lang/String;)I", dadosAndroid.object<jstring>());
//        qDebug() << "AndroidImagePicker column_index=" << columnIndex;

//        cursor.callMethod<jboolean>("moveToFirst");

//        QAndroidJniObject path = cursor.callObjectMethod("getString", "(I)Ljava/lang/String;", columnIndex);
//        qDebug() << "AndroidImagePicker path.isValid()=" << path.isValid();

//        QString imagePath = "file://" +  path.toString();
//        qDebug() << "AndroidImagePicker path" << imagePath;

//        cursor.callMethod<void>("close");

//        emit imagePathRetrieved(QUrl(uri.toString()).toString());
    }
    else
        qWarning() << "AndroidImagePicker wrong path";
}
