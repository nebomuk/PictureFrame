import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    

    title: qsTr("Football Image")

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
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
    }

    GridLayout {
        id: grid
        y: 172
        width: 250
        height: 219
        anchors.horizontalCenter: parent.horizontalCenter
        rows: 4
        columns: 2
        rowSpacing: 5
        columnSpacing: 5

        Label {
            text: "Design"
        }

        StringXmlResourceComboBox {
            attributeName: "footballDesignSpinnerArray"
        }

        Label {

            Layout.columnSpan: 2
            text: "Select Favorite Team"
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
