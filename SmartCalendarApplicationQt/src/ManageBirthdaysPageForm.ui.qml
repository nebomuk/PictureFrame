import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    padding: 20


    title: qsTr("Manage Birthdays")

    property alias textFieldFirstName: textFieldFirstName

    property alias textFieldLastName: textFieldLastName

    property alias buttonBirthdate: buttonBirthdate

    property alias listView: listView

    property alias buttonAddEntry: buttonAddEntry

    GridLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
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
            id: buttonAddEntry
            text: qsTr("Add Entry")
        }

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

                    text: firstName
                    Layout.preferredWidth: 70
                }

                Label {
                    Layout.fillWidth: true

                    text: lastName
                    Layout.preferredWidth: 70

                }

                Label {
                    Layout.fillWidth: true
                    text: birthdate
                    Layout.preferredWidth : 80

                }

                RemoveButton
                {
                    listModel: listView.model
                }

            }


        }

    }
}
