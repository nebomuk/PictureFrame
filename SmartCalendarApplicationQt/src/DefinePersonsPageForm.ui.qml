import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3


Page {
    id: page

    padding: 20

    property alias listModel: listModel

    property alias addButton: addButton

    title: qsTr("Define Persons")



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
                        spacing: 10
                        delegate: DraggableItem {
                            id : draggableItem
                            Rectangle {
                                height: 60
                                width: listView.width * 0.8
                                color: "white"

                                RowLayout {
                                    anchors.fill: parent
                                    spacing: 20
                                    Label {
                                        id: textFieldName
                                        text: model.name
                                    }
                                    Label {
                                        Layout.fillWidth: true
                                        id: textFieldEmail
                                        text: model.email
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

        // must be on top of other items
        RoundButton {
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
