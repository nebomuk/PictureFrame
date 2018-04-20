import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Page {
    id: page

    

    title: qsTr("Device Selection")

    signal availableDevicesClicked(int index)
    signal savedDevicesClicked(int index)

    signal savedDeviceRemoved(int index)

    property alias savedDevicesListView: savedDevicesListView

    property alias availableDevicesListView: availableDevicesListView

    property alias busyIndicator: busyIndicator

    property alias gridLayout: gridLayout

    BusyIndicator
    {
        id : busyIndicator
        visible: true
        anchors.centerIn: parent

    }

    GridLayout
    {
        visible: false;
        id: gridLayout
        anchors.top :parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        rows : 5
        columns : 1

    Label {
        id: label1
        text: qsTr("Configured Devices")
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    }

    ListView {
        id: savedDevicesListView
        height: 200
        anchors.left: parent.left
        anchors.right: parent.right
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        spacing: 0

        delegate:
            Rectangle {
                height: 50
                color: "white"
                width: savedDevicesListView.width

                MouseArea
                {
                    id : savedDevicesMouseArea
                    anchors.fill: parent

                }
                Connections {
                   target: savedDevicesMouseArea
                   onClicked: savedDevicesClicked(index)
                 }

                RowLayout
                {
                    anchors.left: parent.left
                    anchors.right: parent.right

                Label
                {
                    Layout.leftMargin: 20
                    Layout.fillWidth: true
                    text : productName
                }
                Text
                {
                    Layout.alignment: Qt.AlignRight
                    text : "\uf0c2"
                    font.family: "FontAwesome"
                    font.pointSize: 14
                }

                Text
                {
                    Layout.alignment: Qt.AlignRight

                    text : "\uf1eb"
                    font.family: "FontAwesome"
                    font.pointSize: 14
                }

                Button
                {
                    Layout.alignment: Qt.AlignRight

                    id : removeButton
                    text : "\uf2ed"
                    font.family: "FontAwesome" // loaded via QFontDatabase in main.cpp
                    font.pointSize: 14

                    Connections
                    {
                        target : removeButton
                        onClicked : {
                                  savedDeviceRemoved(index); // removal of list and db entry done in slot
                        }
                    }
                }
                }

                // Bottom line border
                Rectangle {
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                    height: 1
                    color: "lightgrey"
                }
            }

        model: ListModel
        {
        }
    }



    Label {
        id: label
        text: qsTr("Configure New Device")
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    }



    ListView {
        id: availableDevicesListView
        height: 200
        anchors.left: parent.left
        anchors.right: parent.right
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        spacing: 0


        delegate: Rectangle {
            height: 50
            color: "white"
            width: availableDevicesListView.width

            MouseArea
            {
                id : availableDevicesMouseArea
                anchors.fill: parent
            }
            Connections {
               target: availableDevicesMouseArea
               onClicked: availableDevicesClicked(index)
             }

            Label {

                anchors.leftMargin: 20
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Product ID: ") + productId
            }

            // Bottom line border
            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                height: 1
                color: "lightgrey"
            }
        }
        model: ListModel
        {

        }
    }


    }
}
