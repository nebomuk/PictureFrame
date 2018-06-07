import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.4

Page {
    title: qsTr("Dynamic Picture")

    property alias imageCropperItem : imageCropperItem
    property alias textField: textField
    property alias busyIndicator: busyIndicator
    property alias addButton: addButton


    ImageCropperItem
    {
        anchors.fill: parent
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

    //text : qsTr("Add more pictures")

    RoundButton{
        anchors.rightMargin:   20
        anchors.bottomMargin:  20

        id : addButton
        icon
        {
            source : "qrc:/icon/add.svg"
            color : "white"
        }

        anchors.bottom: parent.bottom
        anchors.right: parent.right
        Material.background: Material.Pink
    }

}
