import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
    height: 800
    width: 480

    title: qsTr("Page 2")

    Label {
        text: qsTr("Base Options")
        anchors.verticalCenterOffset: -368
        anchors.horizontalCenterOffset: 0
        anchors.centerIn: parent
    }

    Rectangle {
        id: rectangle
        y: 154
        anchors.left: parent.left
        anchors.right: parent.right
        height: 10
        color: "#6acafa"
        anchors.rightMargin: 0
        anchors.leftMargin: 0
    }

    Row {
        id: row
        x: 121
        y: 85
        height: 50
        width: 600
        spacing: 20
        Button {
            id: button
            text: qsTr("Calendar")
        }

        Button {
            id: button1
            text: qsTr("Display")
        }

        Button {
            id: button2
            text: qsTr("Language")
        }
    }

    Column {
        id: column
        x: 114
        y: 303
        width: 200
        height: 400

        Button {
            id: button3
            width: parent.width
            text: qsTr("Master Account")
        }

        Button {
            id: button4
            width: parent.width
            text: qsTr("Define Persons")
        }

        Button {
            id: button5
            width: parent.width
            text: qsTr("Manage Birthdays")
        }

        Button {
            id: button6
            width: parent.width
            text: qsTr("Manage Trash")
        }
    }
}
