#include "androidhelper.h"
#include <QAndroidIntent>
#include <QtAndroid>

AndroidHelper::AndroidHelper(QObject *parent) : QObject(parent)
{
}

void AndroidHelper::showWifiSettings()
{
    QAndroidIntent serviceIntent = QAndroidIntent(QtAndroid::androidActivity().object(), "android.settings.WIFI_SETTINGS");
    QtAndroid::startActivity(serviceIntent.handle(),42);
}




void AndroidHelper::showToast(const QString &message, Duration duration) {
    // all the magic must happen on Android UI thread
    QtAndroid::runOnAndroidThread([message, duration] {
        QAndroidJniObject javaString = QAndroidJniObject::fromString(message);
        QAndroidJniObject toast = QAndroidJniObject::callStaticObjectMethod("android/widget/Toast", "makeText",
                                                                            "(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;",
                                                                            QtAndroid::androidActivity().object(),
                                                                            javaString.object(),
                                                                            jint(duration));
        toast.callMethod<void>("show");
    });
}
