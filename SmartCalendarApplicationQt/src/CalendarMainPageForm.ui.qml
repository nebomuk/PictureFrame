import QtQuick 2.10
import QtQuick.Controls 2.3
import de.vitecvisual.util 1.0



Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Calendar Main")

    property string selectedDevice: NotifyingSettings.selectedDevice

    Label {
        id: label
        font.pointSize: 20
        text: selectedDevice
        anchors.horizontalCenter: parent.horizontalCenter
        bottomPadding: 8
    }
}
