import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
    width: 480
    height: 640

    title: qsTr("Smart Calendar")

    property alias buttonDeviceSelection : deviceSelectionButton

    property alias buttonCalendarView : calendarViewButton

    property alias buttonBaseConfiguration : baseConfigurationButton

    Column {
        id: column
        x: 80
        y: 120
        width: 303
        height: 800

        Label {
            id: label
            font.pointSize: 20
            text: qsTr("No Device Selected")
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
