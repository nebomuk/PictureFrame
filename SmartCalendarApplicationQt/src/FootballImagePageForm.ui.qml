import QtQuick 2.10
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Football Image")

    Column {
        spacing: 10
        Row {
            spacing: 10
            TextField {
                placeholderText: "Favorite Team"
            }

            TextField {
                placeholderText: "Top 5"
            }

            TextField {
                placeholderText: "Least 5"
            }
        }
        Column {
            spacing: 10
            Row {
                id: row2
                spacing: 10
                Label {
                    text: "Design"
                    anchors.verticalCenter: parent.verticalCenter
                }

                ComboBox {
                    model: ["Design-1-x"]
                }
            }
            Label {
                text: "Select Favorite Team"
            }
            Column {
                spacing: 10
                Row {
                    id: row
                    spacing: 10

                    Label {
                        text: "Leage"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ComboBox {
                    }
                }
                Row {
                    id: row1
                    spacing: 10
                    Label {
                        text: "Team"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ComboBox {
                    }
                }
            }
        }
    }

    Grid {
        id: grid
        x: 61
        y: 391
        width: 400
        height: 400
        rows: 4
        columns: 2

        Label {
            text: "Design"
        }

        ComboBox {
            model: ["Design-1-x"]
        }


        Label {
            text: "Select Favorite Team"
        }

        Label
        {
            text : "."
        }

        Label {
            text: "Leage"
        }



        ComboBox {
        }

        Label {
            text: "Team"
        }

        ComboBox {
        }
    }
}
