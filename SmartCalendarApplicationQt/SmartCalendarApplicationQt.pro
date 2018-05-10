QT += quick core gui network concurrent svg networkauth mqtt #xmlpatterns xml // required for xmlListModel?

win32|macx|linux {
QT += widgets # for native message dialog in Qt quick labs
}

CONFIG += c++11
CONFIG += qtquickcompiler

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
    HEADERS += src/androidhelper.h src/androidimagepicker.h
    SOURCES += src/androidhelper.cpp src/androidimagepicker.cpp
    QT += androidextras
}

SOURCES += src/main.cpp \
    src/smartcalendaraccessimpl.cpp \
    src/responderclient.cpp \
    src/controllerconnectionmanagerimpl.cpp \
    src/propertyhelper.cpp \
    src/controllerdatacontainer.cpp \
    src/deviceaccessorimpl.cpp \
    src/qvariantlistconversion.cpp \
    src/platformhelper.cpp \
    src/mqttconnection.cpp \
    src/mqttmessageparser.cpp \
    src/blockingmqttconnection.cpp \
    src/googlecalendarauthorization.cpp


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
    src/platformhelper.h \
    src/mqttconnection.h \
    src/mqttmessageparser.h \
    src/blockingmqttconnection.h \
    src/googlecalendarauthorization.h


RESOURCES += qml.qrc \
    icon.qrc

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

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    src/DateUtil.js \
    src/ComboBoxUtil.js \
    src/OptionComboBoxUtil.js \
    src/BaseOptionsPageForm.ui.qml \
    src/NameEmailInputDialogForm.ui.qml \
    src/DynamicPicturePageForm.ui.qml \
    src/PictureTypeSelectionDialogForm.ui.qml \
    src/NewsImagePageForm.ui.qml \
    src/MainPageForm.ui.qml \
    src/FirstConfigurationPageForm.ui.qml \
    src/MasterAccountPageForm.ui.qml \
    src/CinemaImagePageForm.ui.qml \
    src/FootballImagePageForm.ui.qml \
    src/BaseCalendarOptionsPageForm.ui.qml \
    src/ManageTrashPlanPageForm.ui.qml \
    src/WeatherImagePageForm.ui.qml \
    src/ManageBirthdaysPageForm.ui.qml \
    src/DefinePersonsPageForm.ui.qml \
    src/CalendarImagePageForm.ui.qml \
    src/BaseDisplayOptionsPageForm.ui.qml \
    src/DeviceManagerPageForm.ui.qml \
    src/CalendarMainPageForm.ui.qml \
    src/BaseOptionsPage.qml \
    src/CenterColumn.qml \
    src/CenterButton.qml \
    src/NameEmailInputDialog.qml \
    src/Object.qml \
    src/FirstConfigurationPage.qml \
    src/Style.qml \
    src/ConfirmButton.qml \
    src/NotifyingSettings.qml \
    src/ExtendedComboBox.qml \
    src/MainPage.qml \
    src/RemoveButton.qml \
    src/PictureTypeSelectionDialog.qml \
    src/MasterAccountPage.qml \
    src/StringXmlResourceModel.qml \
    src/ConfirmationPage.qml \
    src/NewsImagePage.qml \
    src/DatePickerDialog.qml \
    src/DefinePersonsPage.qml \
    src/CinemaImagePage.qml \
    src/WeatherImagePage.qml \
    src/BaseCalendarOptionsPage.qml \
    src/StringXmlResourceComboBox.qml \
    src/TimePicker.qml \
    src/ManageTrashPlanPage.qml \
    src/ManageBirthdaysPage.qml \
    src/main.qml \
    src/DynamicPicturePage.qml \
    src/CalendarImagePage.qml \
    src/DatePickerForm.qml \
    src/FootballImagePage.qml \
    src/DraggableItem.qml \
    src/BaseDisplayOptionsPage.qml \
    src/DeviceManagerPage.qml \
    src/CalendarMainPage.qml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android


