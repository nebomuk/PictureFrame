import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    title: qsTr("Dynamic Picture")

    property alias imageCropperItem : imageCropperItem


    ImageCropperItem
    {
        anchors.fill: parent
        visible: false
        id : imageCropperItem
    }

}
