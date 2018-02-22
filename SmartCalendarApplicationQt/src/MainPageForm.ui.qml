import QtQuick 2.10
import QtQuick.Controls 2.3
import Qt.labs.settings 1.0

import de.vitecvisual.util 1.0

Page {


    id : page

    title: qsTr("Smart Calendar")

    property alias buttonDeviceSelection : deviceSelectionButton

    property alias buttonCalendarView : calendarViewButton

    property alias buttonBaseConfiguration : baseConfigurationButton

    property string selectedDevice : NotifyingSettings.selectedDevice

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
            id: calendarViewButton
            text: qsTr("Calendar View")
        }

        CenterButton {
            id: baseConfigurationButton
            text: qsTr("Base Configuration")
       }
    }
}
