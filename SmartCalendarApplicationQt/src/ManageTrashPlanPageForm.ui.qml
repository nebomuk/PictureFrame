import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 480
    height: 800

    property alias textFieldTrashType: textFieldTrashType

    property alias buttonDate: buttonDate

    property alias listView: listView

    property alias buttonConfirm: buttonConfirm

    property alias buttonAddEntry: buttonAddEntry

    title: qsTr("Manage Trash Plan")

    GridLayout {
        id: grid
        x: 59
        y: 133
        width: 391
        height: 294
        rowSpacing: 10
        columnSpacing: 10
        rows: 4
        columns: 2

        Label {
            id: label
            text: qsTr("Trash Type")
        }

        TextField {
            id: textFieldTrashType
            placeholderText: qsTr("Type")
        }

        Label {
            id: label1
            text: qsTr("Date")
        }

        Button {
            id: buttonDate
        }
        Button {
            Layout.columnSpan: 2
            id: buttonAddEntry
            text: qsTr("Add Entry")
            enabled: textFieldTrashType.text.length > 0
        }

        FontLoader { id: fontAwesome; source: "qrc:/fa-regular-400.ttf" }

        ListView
        {
            id : listView
            height: 400

            model : ListModel
            {

            }

            delegate: RowLayout
            {

                Label {
                    Layout.fillWidth: true
                    text: trashType
                    Layout.preferredWidth: 70
                }

                Label {
                    Layout.fillWidth: true
                    text: date
                    Layout.preferredWidth : 80

                }

                Button
                {
                    id : removeEntryButton
                    text : "\uf2ed"
                    font.family: fontAwesome.name

                    Connections
                    {
                        target : removeEntryButton
                        onClicked : listView.model.remove(index)
                    }
                }

                // TODO add iconize garbage icon

            }


        }
    }

    Button {
        id: buttonConfirm
        text: qsTr("Confirm")
        anchors.right: parent.right
        anchors.rightMargin: 80
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
    }

}
