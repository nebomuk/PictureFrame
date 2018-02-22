import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    

    title: qsTr("Define Persons")

    ListModel {
            id: myModel
            ListElement {
                text: "The Phantom Menace"
            }
            ListElement {
                text: "Attack of the Clones"
            }
            ListElement {
                text: "Revenge of the Siths"
            }
            ListElement {
                text: "A New Hope"
            }
            ListElement {
                text: "The Empire Strikes Back"
            }
            ListElement {
                text: "Return of the Jedi"
            }
            ListElement {
                text: "The Force Awakens"
            }
        }

        Item {
            id: mainContent
            anchors.fill: parent
            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                Rectangle {
                    color: "lightblue"
                    height: 50
                    Layout.fillWidth: true

                    Text {
                        anchors.centerIn: parent
                        text: "A fake toolbar"
                    }
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ListView {
                        id: listView
                        model: myModel
                        delegate: DraggableItem {
                            id : draggableItem
                            Rectangle {
                                height: textLabel.height * 2
                                width: listView.width
                                color: "white"

                                Text {
                                    id: textLabel
                                    anchors.centerIn: parent
                                    text: model.text
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
                                        myModel.move(from, to, 1);
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
