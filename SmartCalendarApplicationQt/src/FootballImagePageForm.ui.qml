import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ConfirmationPage {
    id: page

    property alias comboBoxTableFormat: comboBoxTableFormat
    property alias comboBoxLeague: comboBoxLeague
    property alias comboBoxTeam: comboBoxTeam
    property alias comboBoxDesign: comboBoxDesign


    title: qsTr("Football Image")



    GridLayout {
        id: grid
        y: 172
        width: 326
        height: 219
        anchors.horizontalCenter: parent.horizontalCenter
        rows: 5
        columns: 2
        rowSpacing: 5
        columnSpacing: 5


        Label {
            text: qsTr("Table Format")
        }
        ComboBox
        {

            id : comboBoxTableFormat
            model : ListModel
            {
                ListElement
                {
                    text: qsTr("Favorite Team")
                    key : "Favorite Team"
                }
                ListElement
                {
                    text : qsTr("Top 5")
                    key : "Top 5"
                }
                ListElement
                {
                    text : qsTr("Least 5");
                    key : "Least 5"
                }
            }
            textRole : "text"
        }


        Label {
            text: qsTr("Design")
        }

        StringXmlResourceComboBox {
            id : comboBoxDesign
            attributeName: "footballDesignSpinnerArray"
        }

        Label {

            Layout.columnSpan: 2
            text: qsTr("Select Favorite Team")
        }

        Label {
            text: qsTr("Leage")
        }

        ComboBox {
            id : comboBoxLeague
        }

        Label {
            text: qsTr("Team")
        }

        ComboBox {
            id : comboBoxTeam
        }
    }

}
