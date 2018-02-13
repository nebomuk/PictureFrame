import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Manage Trash Plan")

    GridLayout {
        id: grid
        x: 59
        y: 133
        width: 391
        height: 294
        rowSpacing: 10
        columnSpacing: 10
        rows: 5
        columns: 2

        Label {
            id: label
            text: qsTr("Trash Type")
        }

        TextField {
            id: textField
            placeholderText: qsTr("Type")
        }

        Label {
            id: label1
            text: qsTr("Date")
        }

        TextField {
            id: label2
            placeholderText: qsTr("Enter date")
        }
        Button {
            Layout.columnSpan: 2
            id: buttonConfirm
            text: qsTr("Confirm")
        }

        Label {
            Layout.columnSpan: 2
            id: label3
            text: qsTr("Remove Trash Plan Entry")
        }

        TextField {
            placeholderText: qsTr("Trash Type")
        }

        TextField {
            placeholderText: qsTr("Date")
        }
    }

}
