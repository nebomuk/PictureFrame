#include "androidhelper.h"
#include <QAndroidIntent>

AndroidHelper::AndroidHelper(QObject *parent) : QObject(parent)
{

}

void AndroidHelper::showWifiSettings()
{
    auto serviceIntent = QAndroidIntent(QtAndroid::androidActivity().object(), "android.settings.WIFI_SETTINGS");
    QtAndroid::startActivity(serviceIntent.handle());
}




void AndroidHelper::showToast(const QString &message, Duration duration = LONG) {
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
