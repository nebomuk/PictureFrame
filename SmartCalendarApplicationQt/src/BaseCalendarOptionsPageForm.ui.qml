import QtQuick 2.4
import QtQuick.Controls 2.3


Page {
    width: 480
    height: 640

    title: qsTr("Calendar Options")

    property alias buttonMasterAccount: buttonMasterAccount

    property alias buttonDefinePersons: buttonDefinePersons

    property alias buttonManageBirthdays: buttonManageBirthdays

    property alias buttonManageTrash: buttonManageTrash

    property alias buttonConfirm : buttonConfirm

      property alias  checkBoxShowBirthdays : checkBoxShowBirthdays
    property alias checkBoxShowNationalHolidays : checkBoxShowNationalHolidays
    property alias checkBoxShowTrashPlan : checkBoxShowTrashPlan


    CenterColumn {
        id: column

        anchors.topMargin: 80
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 200

        CenterButton {
            id: buttonMasterAccount
            text: qsTr("Master Account")
        }

        CenterButton {
            id: buttonDefinePersons
            text: qsTr("Define Persons")
        }

        CenterButton {
            id: buttonManageBirthdays
            text: qsTr("Manage Birthdays")
        }

        CenterButton {
            id: buttonManageTrash
            text: qsTr("Manage Trash")
        }
        CheckBox {
            id : checkBoxShowBirthdays
            checked: false
            text: qsTr("Show birthdays")
        }
        CheckBox {
            id : checkBoxShowNationalHolidays
            checked: false
            text: qsTr("Show national holidays")
        }
        CheckBox {
            id : checkBoxShowTrashPlan
            checked: false
            text: qsTr("Show trash plan")
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
