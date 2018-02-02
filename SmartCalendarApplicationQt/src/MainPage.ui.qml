import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
    width: 480
    height: 640

    title: qsTr("Smart Calendar")

    Column {
        id: column
        x: 80
        y: 120
        width: 303
        height: 400

        Button {
            id: button
            width: 0.8 * parent.width
            text: qsTr("Device Selection")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            id: button1
            width: 0.8 * parent.width
            text: qsTr("Calendar View")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            id: button2
            width: 0.8 * parent.width
            text: qsTr("Base Configurations")
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
