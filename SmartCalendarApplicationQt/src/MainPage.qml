import QtQuick 2.0
import QtQuick.Controls 2.1

import "ArrayUtil.js" as ArrayUtil


MainPageForm {

    id : mainPage

    buttonDeviceSelection.onClicked:  {
        stackView.push("DeviceManagerPage.qml")
    }
    buttonBaseConfiguration.onClicked: {
        stackView.push("BaseOptionsPage.qml")
    }
    buttonCalendarView.onClicked: {
        stackView.push("CalendarMainPage.qml")
    }

    buttonImagePicker.onClicked: {
        stackView.push("DynamicPicturePage.qml");
    }

    buttonTimePicker.onClicked: {
       timePickerWizard.openWizard();
    }

    TimeRangeWizard {
        anchors.centerIn: parent

        id: timePickerWizard
    }
}

