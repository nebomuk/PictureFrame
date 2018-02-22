import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    property alias listModel: listModel

    title: qsTr("Define Persons")

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
                                    TextField {
                                        id: textFieldName
                                        text: model.name
                                    }
                                    TextField {
                                        Layout.fillWidth: true
                                        id: textFieldEmail
                                        text: model.email
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


}
