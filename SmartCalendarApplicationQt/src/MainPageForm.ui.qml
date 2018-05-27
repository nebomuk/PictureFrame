import QtQuick 2.10
import QtQuick.Controls 2.3
import Qt.labs.settings 1.0

import de.vitecvisual.util 1.0

Page {


    id : page

    title: qsTr("Smart Calendar Thync")

    property alias buttonDeviceSelection : deviceSelectionButton

    property alias buttonCalendarView : calendarViewButton

    property alias buttonBaseConfiguration : baseConfigurationButton

    property string selectedDevice // written to in DeviceManagerPage

    property alias buttonImagePicker: buttonImagePicker

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
            //enabled: label.text.length > 0
            id: calendarViewButton
            text: qsTr("Calendar View")
        }

        CenterButton {
            //enabled: label.text.length > 0
            id: baseConfigurationButton
            text: qsTr("Base Configuration")
       }

        Button
        {
            id : buttonImagePicker
            text : "image picker test"
        }
    }
}
