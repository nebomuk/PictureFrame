import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ConfirmationPage {
    id: page

    title: qsTr("Cinema")

    property alias comboBoxoption: comboBoxoption
    property alias comboBoxgenre: comboBoxgenre
    property alias comboBoxcountry: comboBoxcountry
    property alias comboBoxdesign: comboBoxdesign

    //property alias publishTimeStamp : publishStamp;
    GridLayout {
        width: 287
        height: 284
        anchors.horizontalCenter: parent.horizontalCenter
        columns: 2
        rows: 5
        rowSpacing: 5
        columnSpacing: 5

        Label {
            text: qsTr("Option")
        }

        StringXmlResourceComboBox
        {
            id : comboBoxoption
            attributeName:  "cinemaViewSpinnerArray"
        }

        Label {
            text: qsTr("Genre")
        }

        ComboBox {
            id: comboBoxgenre
            model: StringXmlResourceModel {
                attributeName: "cinemaGenreSpinnerArray"
            }
            // TODO must be a checkable combo box
//            delegate: CheckBox {
//            }
            Component.onCompleted: currentIndex = 0
        }

        Label {
            Layout.columnSpan: 2
            id: labelCheckedGenres
        }

        Label {
            text: qsTr("Country")
        }


        StringXmlResourceComboBox {
            id: comboBoxcountry
                attributeName: "countrySpinnerArray"
        }

        Label {
            text: qsTr("Design")
        }

        StringXmlResourceComboBox {
            id: comboBoxdesign
                attributeName: "cinemaDesignSpinnerArray"
        }
    }
}
