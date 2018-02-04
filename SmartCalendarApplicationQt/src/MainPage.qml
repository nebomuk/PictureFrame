import QtQuick 2.0

MainPageForm {
    buttonDeviceSelection.onClicked:  {
        stackView.push("DeviceManagerComponent.qml")
    }
    buttonBaseConfiguration.onClicked: {
        stackView.push("BaseOptionsPage.qml")
    }
    buttonCalendarView.onClicked: {
        stackView.push("CalendarMainComponent.qml")
    }
}

