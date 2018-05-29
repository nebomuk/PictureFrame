import QtQuick 2.4
import de.vitecvisual.core 1.0;


BaseCalendarOptionsPageForm {

    buttonMasterAccount.onClicked: stackView.push("MasterAccountPage.qml")

    buttonDefinePersons.onClicked: stackView.push("DefinePersonsPage.qml")

    buttonManageBirthdays.onClicked: stackView.push("ManageBirthdaysPage.qml")

    buttonManageTrash.onClicked: stackView.push("ManageTrashPlanPage.qml")


    Component.onCompleted:
    {
        // FIXME undefined
        //checkBoxShowBirthdays.checked =   DeviceAccessor.controllerDataContainer.baseOptions.showBirthdays;

        // FIXME undefined

       // checkBoxShowTrashPlan.checked =   DeviceAccessor.controllerDataContainer.baseOptions.showTrashPlan

         // FIXME undefined
        //checkBoxShowNationalHolidays.checked =  DeviceAccessor.controllerDataContainer.baseOptions.showNationalHolidays

    }

    function onDoneClicked() {

        var baseOptions = DeviceAccessor.controllerDataContainer.baseOptions;

        baseOptions.showBirthdays = checkBoxShowBirthdays.checked

        baseOptions.showTrashPlan = checkBoxShowTrashPlan.checked

        baseOptions.showNationalHolidays = checkBoxShowNationalHolidays.checked

        DeviceAccessor.controllerDataContainer.baseOptions = baseOptions

        DeviceAccessor.sendCalendarBaseOptions(baseOptions);
    }
}
