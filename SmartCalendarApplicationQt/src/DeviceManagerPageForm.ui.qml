import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import de.vitecvisual.util 1.0
import QtQuick.Controls.Material 2.3

Page {
    id: page

    padding: 20

    title: qsTr("Device Selection")

    signal availableDevicesClicked(int index)
    signal savedDevicesClicked(int index)

    signal savedDeviceRemoved(int index)

    property alias savedDevicesListView: savedDevicesListView

    property alias availableDevicesListView: availableDevicesListView

    property alias busyIndicator: busyIndicator

    property alias gridLayout: gridLayout

    property alias refreshButton: refreshButton

    BusyIndicator {
        id: busyIndicator
        visible: true
        anchors.centerIn: parent
    }

    RoundButton {
        id : refreshButton

        icon
        {
            source : "qrc:/icon/refresh.svg"
            color : "white"
        }

        visible: !busyIndicator.visible
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        Material.background: Material.Pink
    }

    GridLayout {
        visible: false
        id: gridLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        rows: 5
        columns: 1

        Label {
            id: label1
            text: qsTr("Configured Devices")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            visible : savedDevicesListView.count > 0
        }

        ListView {
            id: savedDevicesListView
            height: 200
            width: parent.width
            interactive: false

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            spacing: 0

            delegate: Rectangle {
                height: 50
                color: "white"
                width: savedDevicesListView.width

                MouseArea {
                    id: savedDevicesMouseArea
                    anchors.fill: parent
                }
                Connections {
                    target: savedDevicesMouseArea
                    onClicked: savedDevicesClicked(index)
                }

                RowLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right

                    Label {
                        Layout.leftMargin: 20
                        Layout.fillWidth: true
                        text: productName
                    }
                    Image {
                        Layout.alignment: Qt.AlignRight
                        asynchronous: true
                        source: "qrc:/icon/cloud.svg"
                    }

                    Image {
                        visible: ip != ""
                        Layout.alignment: Qt.AlignRight
                        asynchronous: true
                        source: "qrc:/icon/signal.svg"
                    }

                    Button {
                        Layout.alignment: Qt.AlignRight
                        id: removeButton
                        // @disable-check M17
                        icon.source: "qrc:/icon/trash.svg"

                        Connections {
                            target: removeButton
                            onClicked: {
                                savedDeviceRemoved(
                                            index) // removal of list and db entry done in slot
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

            model: ListModel {
            }
        }

        Label {
            id: label
            text: qsTr("Configure New Device")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            visible : availableDevicesListView.count > 0
        }

        ListView {
            id: availableDevicesListView
            height: 200
            width: parent.width
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: 0

            delegate: Rectangle {
                height: 50
                color: "white"
                width: availableDevicesListView.width

                MouseArea {
                    id: availableDevicesMouseArea
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
            model: ListModel {
            }
        }
    }
}
