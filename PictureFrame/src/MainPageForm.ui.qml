import QtQuick 2.10
import QtQuick.Controls 2.3
import Qt.labs.settings 1.0

import pictureframecompany.util 1.0

Page {


    id : page

    title: qsTr("Picture Frame")

    property alias buttonDeviceSelection : deviceSelectionButton

    property alias buttonCalendarView : calendarViewButton

    property alias buttonBaseConfiguration : baseConfigurationButton

    property alias buttonDeveloperPage : developerPageButton


    property string selectedDevice // written to in DeviceManagerPage

    CenterColumn {
        id: column

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 140

        width: 303

        Label {
            id: label
            font.pointSize: 20
            text: selectedDevice
            anchors.horizontalCenter: parent.horizontalCenter
            bottomPadding: 8
        }

        CenterButton {

            id: deviceSelectionButton
            text: qsTr("Device Selection")
        }

        CenterButton {
           // enabled: label.text.length > 0
            id: calendarViewButton
            text: qsTr("Calendar View")
        }

        CenterButton {
           // enabled: label.text.length > 0
            id: baseConfigurationButton
            text: qsTr("Base Configuration")
       }

        CenterButton {
           // enabled: label.text.length > 0
            id: developerPageButton
            text: qsTr("Developer Options")
       }
    }
}
