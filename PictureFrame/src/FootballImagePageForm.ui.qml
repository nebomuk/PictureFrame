import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    property alias comboBoxTableFormat: comboBoxTableFormat
    property alias comboBoxLeague: comboBoxLeague
    property alias comboBoxTeam: comboBoxTeam
    property alias comboBoxDesign: comboBoxDesign

    title: qsTr("Football Image")

    GridLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        rows: 5
        columns: 2
        rowSpacing: 5
        columnSpacing: 5

        Label {
            text: qsTr("Table Format")
        }
        ExtendedComboBox {

            id: comboBoxTableFormat
            Layout.preferredWidth: 200
            Layout.fillWidth: false
            model: ListModel {
                ListElement {
                    text: qsTr("Favorite Team")
                    key: "Favorite Team"
                }
                ListElement {
                    text: qsTr("Top 5")
                    key: "Top 5" // fixme emulator sends "top5"
                }
                ListElement {
                    text: qsTr("Least 5")
                    key: "Least 5"
                }
            }
            textRole: "text"
        }

        Label {
            text: qsTr("Design")
        }

        StringXmlResourceComboBox {
            id: comboBoxDesign
            Layout.preferredWidth: 200
            attributeName: "footballDesignSpinnerArray"
        }

        Label {

            Layout.columnSpan: 2
            text: qsTr("Select Favorite Team")
        }

        Label {
            text: qsTr("Leage")
        }

        ExtendedComboBox {
            id: comboBoxLeague
            Layout.preferredWidth: 200
        }

        Label {
            text: qsTr("Team")
        }

        ExtendedComboBox {
            id: comboBoxTeam
            Layout.preferredWidth: 200
        }
    }
}
