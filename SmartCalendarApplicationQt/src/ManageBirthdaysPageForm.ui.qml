import QtQuick 2.10
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Manage Birthdays")

    Grid {
        id: grid
        x: 11
        y: 71
        width: 400
        height: 178
        spacing: 10
        rows: 3
        columns: 2

        Label {
            id: label
            text: qsTr("First Name")
        }

        TextField {
            id: textFieldFirstName
            text: qsTr("Text Field")
        }

        Label {
            id: label1
            text: qsTr("Last Name")
        }

        TextField {
            id: textFieldLastName
            text: qsTr("Text Field")
        }

        Label {
            id: label2
            text: qsTr("Birthdate")
        }

        Label {
            id: datePickerBirthday
            text: "birthday picker placeholder"
            width: 60
            height: 20
        }
    }

    Button {
        id: button
        x: 35
        y: 268
        text: qsTr("Confirm")
    }

    Label {
        id: label3
        x: 85
        y: 424
        text: qsTr("Remove Birthday")
    }

    ComboBox {
        id: comboBox
        x: 56
        y: 488
    }
}
