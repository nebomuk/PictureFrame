import QtQuick 2.0
import QtQuick.Controls 2.1


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

}

