import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ConfirmationPage
{
    id: page

    

    title: qsTr("Weather")

    property alias spinBoxadditionalNumberOfDays : spinBoxadditionalNumberOfDays;
   // property alias displayTimeInSeconds : displayTimeInSeconds;
    //property alias timeScale : timeScale;
    property alias comboBoxUnit : comboBoxUnit;
    property alias comboBoxDesign : comboBoxDesign;
    property alias textFieldcityName : textFieldcityName;
    property alias comboBoxcountry : comboBoxcountry;
    property alias comboBoxOption: comboBoxOption

    GridLayout
    {
        width: 455
        height: 379
        anchors.horizontalCenter: parent.horizontalCenter
        columns : 2
        rows : 8
        rowSpacing: 5
        columnSpacing: 5

        Label
        {
            text : qsTr("Option")
        }

        StringXmlResourceComboBox
        {
            attributeName: "formatViewSpinnerArray"
            id : comboBoxOption
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

        StringXmlResourceComboBox
        {
            id : comboBoxcountry
            attributeName: "countrySpinnerArray"
        }

        Label
        {
            Layout.columnSpan: 2
            text : qsTr("Given Period")
        }

        Label
        {
            text : qsTr("Additional Number of Days")
        }

        SpinBox
        {
            from : 1
            to : 7
            id : spinBoxadditionalNumberOfDays
        }

        Label
        {
            text : qsTr("Unit")
        }

        ComboBox
        {
            id : comboBoxUnit
            model : ListModel
                    {
                        ListElement
                        {
                            name : qsTr("Metric")
                            unit : "Metric"
                        }
                        ListElement
                        {
                            name : qsTr("Imperial")
                            unit : "Imperial"
                        }
                    }
            textRole : "name"
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
