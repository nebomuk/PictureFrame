import QtQuick 2.0
import Qt.labs.platform 1.0
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

    property alias msgDialogWifi : msgDialogWifi

    MessageDialog {
          id : msgDialogWifi
          title:  qsTr("Wifi is disabled")
          text: qsTr("Please enable WiFi")
      }

    Component.onCompleted: {
        msgDialogWifi.open()
    }
}

