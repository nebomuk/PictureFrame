import QtQuick 2.0

import de.vitecvisual.native 1.0;
//import QtQuick.Dialogs 1.2

MainPageForm {
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

