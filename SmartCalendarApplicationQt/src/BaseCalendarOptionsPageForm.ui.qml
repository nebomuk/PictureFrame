import QtQuick 2.4
import QtQuick.Controls 2.3

Column {
    id: column
    width: 200
    height: 800

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
}
