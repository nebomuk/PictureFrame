import QtQuick 2.4
import QtQuick.Controls 2.3


Page {
    width: 480
    height: 640

    title: qsTr("Calendar Options")


    CenterColumn {
        id: column

        anchors.topMargin: 80
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 200

        CenterButton {
            id: button3
            text: qsTr("Master Account")
        }

        CenterButton {
            id: button4
            text: qsTr("Define Persons")
        }

        CenterButton {
            id: button5
            text: qsTr("Manage Birthdays")
        }

        CenterButton {
            id: button6
            text: qsTr("Manage Trash")
        }
        CheckBox {
            checked: false
            text: qsTr("Show birthdays")
        }
        CheckBox {
            checked: false
            text: qsTr("Show public holidays")
        }
        CheckBox {
            checked: false
            text: qsTr("Show trash plan")
        }
    }

    Button {
        id: button
        x: 337
        y: 443
        text: qsTr("Confirm")
    }

}
