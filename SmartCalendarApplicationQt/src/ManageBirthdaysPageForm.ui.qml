import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Manage Birthdays")

    property alias buttonBirthdate: buttonBirthdate

    GridLayout {
        id: grid
        x: 60
        y: 67
        width: 391
        height: 692
        rowSpacing: 10
        columnSpacing: 10
        rows: 4
        columns: 3

        Label {
            id: label
            text: qsTr("First Name")
        }

        TextField {
            id: textFieldFirstName
            placeholderText: qsTr("Enter First Name")
            validator: RegExpValidator {
                regExp: /^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$/
            }
        }

        Item {
            // spacer item
            Layout.fillWidth: true
        }

        Label {
            id: label1
            text: qsTr("Last Name")
        }

        TextField {
            id: textFieldLastName
            placeholderText: qsTr("Enter Last Name")
            validator: RegExpValidator {
                regExp: /^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$/
            }
        }

        Item {
            // spacer item
            Layout.fillWidth: true
        }

        Label {
            id: label2
            text: qsTr("Birthdate")
        }

        Button {
            id: buttonBirthdate
        }

        Item {
            // spacer item
            Layout.fillWidth: true
        }

        Button {

            Layout.rowSpan: 2
            Layout.columnSpan: 3
            id: buttonConfirm
            text: qsTr("Add Entry")
            enabled: textFieldFirstName.text.length > 0
                     && textFieldLastName.text.length > 0
        }

        Label {
            Layout.columnSpan: 3
            id: label3
            text: qsTr("Remove Birthday")
        }

        ListView
        {
            height: 400

            model : 1

            delegate: RowLayout
            {
                TextField {
                    placeholderText: qsTr("First Name")
                }

                TextField {
                    placeholderText: qsTr("Last Name")
                }

                TextField {
                    placeholderText: qsTr("Birthdate")
                }

                // TODO add iconize garbage icon

            }


        }

    }
}
