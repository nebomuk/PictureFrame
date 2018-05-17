import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import de.vitecvisual.util 1.0



Page {
    id: page

    property alias listModel: listModel
    property alias buttonConfirm: buttonConfirm

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

        Button
        {
            id : buttonAddMorePictures
            y: 360
            text : qsTr("Add more pictures")
            anchors.horizontalCenter: parent.horizontalCenter
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
                    listModel.append({"pictureType":pictureTypeModel.footballImage,
                                         "displayTimeInSeconds":20,
                                         "formData":{"":0,"":0}})
                }
                else
                {
                    listViewRowCount++;
                    buttonAddMorePictures.visible = false
                }

            }

        }


        ConfirmButton
        {
            id : buttonConfirm
        }


    }
