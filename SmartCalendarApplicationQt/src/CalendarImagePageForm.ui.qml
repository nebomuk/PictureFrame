import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3


ConfirmationPage
{
    id: page    

    title: qsTr("Calendar Image")
    property alias comboBoxoption: comboBoxoption
    property alias comboBoxTimeView: comboBoxTimeView
    property alias comboBoxDesign: comboBoxDesign


    GridLayout {
        anchors.left : parent.left
        anchors.right: parent.right
        anchors.top : parent.top
        columns: 2
        rows: 5
        rowSpacing: 5
        columnSpacing: 5

        Label
        {
            text : "Appearance"
        }

        StringXmlResourceComboBox
        {
            attributeName: "timeViewSpinnerArray"
            id : comboBoxTimeView

        }

        Label {
            text: qsTr("Option")
        }

        StringXmlResourceComboBox
        {
            id : comboBoxoption
            attributeName:  "formatViewSpinnerArray"
        }

        Label {
            text: qsTr("Design")
        }

        ComboBox {
            id : comboBoxDesign
        }

    }

}

