import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    

    title: qsTr("Cinema")

    property alias comboBoxoption : comboBoxoption;
    property alias comboBoxgenre : comboBoxgenre;
    property alias comboBoxcountry : comboBoxcountry;
    property alias comboBoxdesign : comboBoxdesign;
    //property alias publishTimeStamp : publishStamp;

    GridLayout
    {
        x: 124
        y: 128
        columns : 2
        rows : 5
        rowSpacing: 5
        columnSpacing: 5

        Label
        {
            text : qsTr("Option")
        }

        ComboBox
        {
            id : comboBoxoption

        }

        Label
        {
            text : qsTr("Genre")
        }

        ComboBox
        {
            id : comboBoxgenre
            model : ["Genre1", "Genre2", "Genre3"]
            // TODO must be a checkable combo box
            delegate: CheckBox{

            }

        }

        Label
        {
            Layout.columnSpan: 2
            id : labelCheckedGenres

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
            text : qsTr("Design")
        }

        ComboBox
        {
            id : comboBoxdesign
        }

    }


}
