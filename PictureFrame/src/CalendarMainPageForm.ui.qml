import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import pictureframecompany.util 1.0
import QtQuick.Controls.Material 2.3




Page {
    id: page


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
                                    anchors.leftMargin: 10
                                    anchors.rightMargin: 10
                                    anchors.fill: parent
                                    spacing: 10
                                    Label {
                                        text: model.pictureType
                                        Layout.preferredWidth:  100
                                    }
                                    TextField{
                                          Layout.preferredWidth: 40

                                          Layout.alignment: Qt.AlignHCenter
                                          id : numberInput
                                          text : model.displayTimeInSeconds
                                          validator: IntValidator{bottom: 1; top: 100;}

                                          inputMethodHints: Qt.ImhPreferNumbers |
                                                            Qt.ImhDigitsOnly
                                          Connections {
                                                          target: numberInput
                                                          onActiveFocusChanged : {
                                                              if(!numberInput.activeFocus)
                                                              {
                                                                 if(numberInput.text.length == 0){
                                                                     model.displayTimeInSeconds = 5;
                                                                 }
                                                                 else
                                                                 {
                                                                     var parsedNumber = parseInt(numberInput.text,10);
                                                                     if(parsedNumber <= 5)
                                                                     {
                                                                         model.displayTimeInSeconds = 5;
                                                                     }
                                                                     else
                                                                     {
                                                                         model.displayTimeInSeconds = parsedNumber;
                                                                     }
                                                                 }

                                                              }
                                                          }
                                                      }

                                      }
                                    Button
                                    {
                                        id : editButton
                                        text : qsTr("Edit")
                                        Layout.alignment: Qt.AlignRight
                                        Connections
                                        {
                                            target : editButton
                                            onClicked : listIndexClicked(index);
                                        }
                                    }

                                    RemoveButton
                                    {
                                        listModel: listView.model
                                        Layout.alignment: Qt.AlignRight
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
