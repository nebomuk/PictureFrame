import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    

    title: qsTr("Weather")

    property alias additionalNumberOfDays : additionalNumberOfDays;
   // property alias displayTimeInSeconds : displayTimeInSeconds;
    //property alias timeScale : timeScale;
    property alias comboBoxUnit : comboBoxUnit;
    property alias comboBoxDesign : comboBoxDesign;
    property alias textFieldcityName : textFieldcityName;
    property alias comboBoxcountry : comboBoxcountry;
  //  property alias index : index;

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
            id : textFieldcityName
            placeholderText: qsTr("City name")
        }

        Label
        {
            text : qsTr("Country")
        }

        ComboBox
        {
            id : comboBoxcountry
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
            id : additionalNumberOfDays
        }

        Label
        {
            text : qsTr("Unit")
        }

        ComboBox
        {
            id : comboBoxUnit
            model : ["SI","Imperial"]
        }

        Label
        {
            text : qsTr("Design")
        }

        StringXmlResourceComboBox
        {
            id : comboBoxDesign
            attributeName: "weatherDesignSpinnerArray"
        }



    }
}
