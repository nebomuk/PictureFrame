import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Weather")

    GridLayout
    {
        x: 124
        y: 128
        columns : 2
        rows : 8
        rowSpacing: 5
        columnSpacing: 5

        Label
        {
            text : qsTr("Appearance")
        }

        ComboBox
        {
            id : comboBoxAppearance
        }

        Label
        {
            Layout.columnSpan: 2
            text : qsTr("Location")
        }

        Label
        {
            text : qsTr("City")
        }

        TextField
        {
            placeholderText: qsTr("City name")
        }

        Label
        {
            text : qsTr("Country")
        }

        ComboBox
        {

        }

        Label
        {
            Layout.columnSpan: 2
            text : qsTr("Given Period")
        }

        Label
        {
            text : qsTr("Further Days")
        }

        TextField
        {

        }

        Label
        {
            text : qsTr("Unit")
        }

        ComboBox
        {
            id : comboBoxUnit
        }

        Label
        {
            text : qsTr("Design")
        }

        ComboBox
        {
            id : comboBoxDesign
        }



    }
}
