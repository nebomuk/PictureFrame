import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import de.vitecvisual.util 1.0
import QtQuick.Controls.Material 2.3




Page {
    id: page

    padding: 20

    property alias listModel: listModel

    property alias buttonAddMorePictures: buttonAddMorePictures

    title: qsTr("Calendar Main")

    signal listIndexClicked(int index);



    ListModel {
            id: listModel
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
                        spacing: 0
                        delegate: DraggableItem {
                            id : draggableItem
                            Rectangle {
                                height: 60
                                width: listView.width
                                color: "white"

                                RowLayout {
                                    anchors.fill: parent
                                    spacing: 5
                                    Label {
                                        text: model.pictureType
                                        Layout.fillWidth: true

                                    }
                                    SpinBox {
                                        id : spinBox
                                        value : model.displayTimeInSeconds
                                        from : 5
                                        to : 100

                                        // bind two way
                                        Connections {
                                            target: spinBox
                                            onValueChanged : model.displayTimeInSeconds = spinBox.value
                                        }
                                    }
                                    Button
                                    {
                                        id : editButton
                                        text : qsTr("Edit")

                                    }

                                    RemoveButton
                                    {
                                        listModel: listView.model
                                    }
                                    Connections
                                    {
                                        target : editButton
                                        onClicked : listIndexClicked(index);
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

                                Connections
                                {
                                    target : draggableItem
                                    onMoveItemRequested: {
                                        listModel.move(from, to, 1);
                                    }

                                }
                            }


                            draggedItemParent: mainContent
                        }
                    }
                }
            }
    }

        RoundButton {
            id : buttonAddMorePictures

            //text : qsTr("Add more pictures")

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
