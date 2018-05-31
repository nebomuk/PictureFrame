import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    title: qsTr("Dynamic Picture")

    property alias imageCropperItem : imageCropperItem
    property alias textField: textField
    property alias busyIndicator: busyIndicator


    ImageCropperItem
    {
        anchors.fill: parent
        visible: false
        id : imageCropperItem
    }

    TextField
    {
        id : textField
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top : parent.top
        anchors.topMargin: 20
        maximumLength: 50
        width: parent.width * 0.8
        placeholderText: qsTr("Description")
    }

    BusyIndicator {
        id: busyIndicator
        visible: false
        anchors.centerIn: parent
    }

}
