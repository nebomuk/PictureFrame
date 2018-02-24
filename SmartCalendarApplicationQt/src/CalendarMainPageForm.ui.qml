import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import de.vitecvisual.util 1.0



Page {
    id: page

    property alias listModel: listModel

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
                                        text: model.pictureType
                                    }
                                    Label {
                                        Layout.fillWidth: true
                                        text: model.duration
                                    }
                                    Button
                                    {
                                        id : editButton
                                        text : qsTr("Edit")

                                    }

                                    RemoveButton
                                    {
                                        listModel: listModel
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

        Button
        {
            id : buttonAddMorePictures
            y: 360
            text : qsTr("Add more pictures")
            anchors.left: parent.left
            anchors.leftMargin: 52
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 72

         }

        Connections
        {
            property int listViewRowCount : 0
            target: buttonAddMorePictures
            onClicked : {

                if(listViewRowCount <4)
                {
                    listViewRowCount++;
                    listModel.append({"buttonText": "Item" + listViewRowCount})
                }
                else
                {
                    listViewRowCount++;
                    buttonAddMorePictures.visible = false
                }

            }

        }


    }
