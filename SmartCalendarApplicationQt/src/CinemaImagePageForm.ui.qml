import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Cinema")

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
            text : qsTr("Appearance")
        }

        ComboBox
        {

        }

        Label
        {
            text : qsTr("Genre")
        }

        ComboBox
        {
            id : comboBoxGenres
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

        }

        Label
        {
            text : qsTr("Design")
        }

        ComboBox
        {

        }

    }


}
