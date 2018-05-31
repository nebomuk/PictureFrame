QT += quick core gui network concurrent svg mqtt  xmlpatterns xml core-private #required for xmlListModel?

win32|macx|linux {
QT += widgets # for native message dialog in Qt quick labs
}

CONFIG += c++11
#enable only for release, because it makes it impossible to debug
#CONFIG += qtquickcompiler

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

android {
    QT += androidextras



    HEADERS += src/androidhelper.h \
    src/androidimagegallery.h \
     src/androidimagecapture.h

# add QT+=  eventdispatcher_support_private when using custom event dispatcher
#    src/androideventdispatcher.h  \
#    src/androiddeadlockprotector.h



    SOURCES += src/androidhelper.cpp \
    src/androidimagegallery.cpp


#     src/androidimagecapture.cpp  \
#    src/androideventdispatcher.cpp

}

SOURCES += src/main.cpp \
    src/smartcalendaraccessimpl.cpp \
    src/responderclient.cpp \
    src/controllerconnectionmanagerimpl.cpp \
    src/propertyhelper.cpp \
    src/controllerdatacontainer.cpp \
    src/deviceaccessorimpl.cpp \
    src/qvariantlistconversion.cpp \
    src/mqttconnection.cpp \
    src/mqttmessageparser.cpp \
    src/blockingmqttconnection.cpp \
    src/googlecalendarauthorization.cpp \
    src/imagecropper.cpp \
    src/iimagecapture.cpp \
    src/iimagegallery.cpp \
    src/loggingfilter.cpp





HEADERS += \
    src/smartcalendaraccessimpl.h \
    src/smartcalendaraccessimpl.h \
    src/controllerconnectionconstants.h \
    src/responderclient.h \
    src/controllerconnectionmanagerimpl.h \
    src/propertyhelper.h \
    src/controllerdatacontainer.h \
    src/deviceaccessorimpl.h \
    src/qvariantlistconversion.h \
    src/mqttconnection.h \
    src/mqttmessageparser.h \
    src/blockingmqttconnection.h \
    src/googlecalendarauthorization.h \
    src/imagecropper.h \
    src/iimagecapture.h \
    src/iimagegallery.h \
    src/loggingfilter.h


# O2 OAuth2 authorization library, License: BSD,
# requires "android.app.background_running"  set to true on android in AndroidManifest.xml
# https://github.com/pipacs/o2
HEADERS +=  src/o2/o0abstractstore.h \
    src/o2/o0baseauth.h \
    src/o2/o0export.h \
    src/o2/o0globals.h \
    src/o2/o0requestparameter.h \
    src/o2/o0settingsstore.h \
    src/o2/o0simplecrypt.h \
    src/o2/o1.h \
    src/o2/o1requestor.h \
    src/o2/o1timedreply.h \
    src/o2/o2.h \
    src/o2/o2google.h \
    src/o2/o2reply.h \
    src/o2/o2replyserver.h \
    src/o2/o2requestor.h
SOURCES +=    src/o2/o0baseauth.cpp \
    src/o2/o0settingsstore.cpp \
    src/o2/o1.cpp \
    src/o2/o1requestor.cpp \
    src/o2/o1timedreply.cpp \
    src/o2/o2.cpp \
    src/o2/o2google.cpp \
    src/o2/o2reply.cpp \
    src/o2/o2replyserver.cpp \
    src/o2/o2requestor.cpp \
    src/o2/o2simplecrypt.cpp





RESOURCES +=  icon.qrc string.qrc qml.qrc \
    credentials.qrc

# in QtCreator/Projects clone Debug configuration, name it Test and add the following qmake arguments: "CONFIG+=test" including the ""
test {
    message(Test build)

    SOURCES += test/testmain.cpp \
    test/smartcalendaraccessimpltest.cpp \
    test/mqtttest.cpp\
    test/controllerconnectionmanagerimpltest.cpp


    HEADERS +=  test/smartcalendaraccessimpltest.h \
    test/mqtttest.h \
    test/controllerconnectionmanagerimpltest.h

    QT += testlib
    TARGET = UnitTests

 # test main
    SOURCES -= src/main.cpp ## add test sources above

} else {
    message(Normal build)
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =


DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/src/de/vitecvisual/java/QExtendedSharePathResolver.java

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android


