import QtQuick 2.0
import QtQuick.Controls 2.1

import de.vitecvisual.core 1.0;
import Qt.labs.platform 1.0



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

    Component.onCompleted:
    {
        if(!SmartCalendarAccess.isConnectedToWifi)
        {
            msgDialogWifi.open()
        }
    }

    MessageDialog {
        id : msgDialogWifi
        title:  qsTr("Wifi is disabled")
        text: qsTr("Please enable WiFi")

        onAccepted: {
            if(typeof PlatformHelper.showWifiSettings === "function")
            {
                PlatformHelper.showWifiSettings()
            }
        }

        Connections {

            target : SmartCalendarAccess

            onIsConnectedToWifiChanged : {
                if(!SmartCalendarAccess.isConnectedToWifi)
                {
                    msgDialogWifi.open()
                }
            }
        }
    }

    MessageDialog
    {
        id : msgDialogConnectionLost
        title : qsTr("Connection lost");
        text : qsTr("The connection to the SmartCalendar has been lost. Please turn on the SmartCalendar and make sure your phone has an active internet connection.")
        Connections
        {
            target : DeviceAccessor
            onError : {
                if(stackView.depth > 0 && stackView.currentItem.url !== "DeviceManagerPage.qml")
                {
                    stackView.pop(null);
                    selectedDevice = "";
                    msgDialogConnectionLost.open();
                }
            }

        }
    }
}

