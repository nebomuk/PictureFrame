import QtQuick 2.10
import QtQuick.Controls 2.3
import Qt.labs.settings 1.0

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Device Selection")

    property string selectedDevice

    Settings
    {
        property alias selectedDevice: page.selectedDevice
    }


    Label {
        id: label
        x: 120
        y: 161
        width: 160
        height: 39
        text: selectedDevice
        font.pointSize: 17
    }

}
