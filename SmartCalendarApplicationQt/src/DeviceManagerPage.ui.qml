import QtQuick 2.10
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Page 1")

    Label {
        id: label
        x: 239
        y: 40
        width: 143
        height: 17
        text: qsTr("Device Selection")
    }

    Rectangle {
        id: rectangle
        y: 76
        anchors.left: parent.left
        anchors.right: parent.right
        height: 10
        color: "#6acafa"
        anchors.rightMargin: 0
        anchors.leftMargin: 0
    }

    Button {
        id: button
        x: 168
        y: 109
        width: 297
        height: 48
        text: qsTr("Search/Display Available Devices")
    }
}
