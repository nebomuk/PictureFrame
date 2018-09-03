import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    title: qsTr("Weather Image")

    property alias spinBoxadditionalNumberOfDays: spinBoxadditionalNumberOfDays
    // property alias displayTimeInSeconds : displayTimeInSeconds;
    //property alias timeScale : timeScale;
    property alias comboBoxUnit: comboBoxUnit
    property alias comboBoxDesign: comboBoxDesign
    property alias textFieldcityName: textFieldcityName
    property alias comboBoxcountry: comboBoxcountry
    property alias comboBoxOption: comboBoxOption

    GridLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        columns: 2
        rows: 8
        rowSpacing: 5
        columnSpacing: 5

        Label {
            text: qsTr("Option")
        }

        StringXmlResourceComboBox {
            attributeName: "weatherViewSpinnerArray"
            id: comboBoxOption
            Layout.fillWidth: false
            Layout.preferredWidth: 220
        }

        Label {
            Layout.columnSpan: 2
            text: qsTr("Location")
        }

        Label {
            text: qsTr("City")
        }

        TextField {
            id: textFieldcityName
            Layout.preferredWidth: 220
            placeholderText: qsTr("City name")
        }

        Label {
            text: qsTr("Country")
        }

        StringXmlResourceComboBox {
            id: comboBoxcountry
            Layout.preferredWidth: 220
            attributeName: "countrySpinnerArray"
        }

        Label {
            Layout.columnSpan: 2
            text: qsTr("Given Period")
        }

        Label {
            visible: comboBoxOption.currentIndex == 1
            text: qsTr("Additional Number of Days")
            Layout.preferredWidth: 120
            Layout.maximumWidth: 120
            wrapMode: Text.WordWrap
        }

        SpinBox {
            visible: comboBoxOption.currentIndex == 1
            from: 1
            to: 5
            id: spinBoxadditionalNumberOfDays
        }

        Label {
            text: qsTr("Unit")
            // create some layout space so that when additional number of days appears, items are not suddently pushed to the right
            Layout.preferredWidth: 120
        }

        ExtendedComboBox {
            id: comboBoxUnit
            Layout.preferredWidth: 220
            model: ListModel {
                ListElement {
                    name: qsTr("Metric")
                    unit: "Metric"
                }
                ListElement {
                    name: qsTr("Imperial")
                    unit: "imperial"
                }
            }
            textRole: "name"
        }

        Label {
            text: qsTr("Design")
        }

        StringXmlResourceComboBox {
            id: comboBoxDesign
            Layout.preferredWidth: 220
            attributeName: "weatherDesignSpinnerArray"
        }
    }
}
