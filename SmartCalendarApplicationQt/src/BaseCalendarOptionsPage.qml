import QtQuick 2.4

BaseCalendarOptionsPageForm {

    buttonMasterAccount.onClicked: stackView.push("MasterAccountPage.qml")

    buttonDefinePersons.onClicked: stackView.push("DefinePersonsPage.qml")

    buttonManageBirthdays.onClicked: stackView.push("ManageBirthdaysPage.qml")

    buttonManageTrash.onClicked: stackView.push("ManageTrashPlanPage.qml")

}
