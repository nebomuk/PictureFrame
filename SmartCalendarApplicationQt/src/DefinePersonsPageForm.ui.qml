import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

Page {
    id: page

    property var listModel

    property alias addButton: addButton

    title: qsTr("Define Persons")

    signal listIndexClicked(int index)

    property alias busyIndicator: busyIndicator

    property alias mainContent : mainContent

    property alias retryButton: retryButton

    property bool retryButtonAndTextVisible : false

    BusyIndicator {
        id: busyIndicator
        visible: false
        anchors.centerIn: parent
    }

    Column {
        anchors.centerIn: parent
        visible: retryButtonAndTextVisible
        spacing: 5

        Label {
            text: qsTr("There's no connection right now. Try again later.")
        }

        Button {
            anchors.horizontalCenter : parent.horizontalCenter
            id: retryButton
            text: qsTr("Retry")
        }
    }

    Item {
        id: mainContent
        anchors.fill: parent
        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                ListView {
                    id: listView
                    model: listModel
                    delegate: DraggableItem {
                        id: draggableItem
                        Rectangle {
                            height: 60
                            width: listView.width
                            color: "white"

                            RowLayout {
                                anchors.fill: parent
                                spacing: 20

                                CheckBox {
                                    id: checkBox
                                    onCheckedChanged: modelData.checked = checkBox.checked
                                }

                                Label {
                                    id: textFieldName
                                    text: modelData.summary
                                }
                                Label {
                                    Layout.fillWidth: true
                                    id: textFieldEmail
                                    text: modelData.id
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

                            Connections {
                                target: draggableItem
                                onMoveItemRequested: {
                                    // old model must be overwritten to notify ListView to update itself
                                    listModel = array_move(listModel, from, to)
                                }

                                // @disable-check M222
                                function array_move(arr, from, to) {
                                    arr.splice(to, 0, arr.splice(from, 1)[0])
                                    return arr
                                }
                            }
                        }

                        draggedItemParent: mainContent
                    }
                }
            }
        }
    }

    // must be on top of other items
    RoundButton {
        id: addButton
        anchors.rightMargin: 20
        anchors.bottomMargin: 20

        icon {
            source: "qrc:/icon/add.svg"
            color: "white"
        }

        anchors.bottom: parent.bottom
        anchors.right: parent.right
        Material.background: Material.Pink
    }
}
