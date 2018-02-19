import QtQuick 2.4
import QtQuick.Controls 2.3
import QtQml 2.0
import de.vitecvisual.core 1.0;


BaseDisplayOptionsPageForm {

    id: form

    fixedDisplayBrightness : DeviceAccessor.controllerDataContainer.displayOptions.fixedDisplayBrightness;
    displaySensibilityLevel : DeviceAccessor.controllerDataContainer.displayOptions.displaySensibilityLevel;
    automatedDisplayBrightness : DeviceAccessor.controllerDataContainer.displayOptions.automatedDisplayBrightness;
    permanentActiveDisplay : DeviceAccessor.controllerDataContainer.displayOptions.permanentActiveDisplay;

    firstIntervallWorkdayPowerSavingModeStartDate : DeviceAccessor.controllerDataContainer.displayOptions.firstIntervallWorkdayPowerSavingModeStartDate;
    firstIntervallWorkdayPowerSavingModeEndDate : DeviceAccessor.controllerDataContainer.displayOptions.firstIntervallWorkdayPowerSavingModeEndDate;
    secondIntervallWorkdayPowerSavingModeStartDate : DeviceAccessor.controllerDataContainer.displayOptions.secondIntervallWorkdayPowerSavingModeStartDate;
    secondIntervallWorkdayPowerSavingModeEndDate : DeviceAccessor.controllerDataContainer.displayOptions.secondIntervallWorkdayPowerSavingModeEndDate;
    firstIntervallWeekendPowerSavingModeStartDate : DeviceAccessor.controllerDataContainer.displayOptions.firstIntervallWeekendPowerSavingModeStartDate;
    firstIntervallWeekendPowerSavingModeEndDate : DeviceAccessor.controllerDataContainer.displayOptions.firstIntervallWeekendPowerSavingModeEndDate;
    secondIntervallWeekendPowerSavingModeStartDate : DeviceAccessor.controllerDataContainer.displayOptions.secondIntervallWeekendPowerSavingModeStartDate;
    secondIntervallWeekendPowerSavingModeEndDate : DeviceAccessor.controllerDataContainer.displayOptions.secondIntervallWeekendPowerSavingModeEndDate;


    buttonWorkingDayStart.text:   new Date(firstIntervallWorkdayPowerSavingModeStartDate).toLocaleTimeString(Qt.locale(),Locale.ShortFormat);
    buttonWorkingDayEnd.text:  new Date(firstIntervallWorkdayPowerSavingModeEndDate).toLocaleTimeString(Qt.locale(),Locale.ShortFormat);
    buttonWeekendStart.text: new Date(firstIntervallWeekendPowerSavingModeStartDate).toLocaleTimeString(Qt.locale(),Locale.ShortFormat);
    buttonWeekendEnd.text:  new Date(firstIntervallWeekendPowerSavingModeEndDate).toLocaleTimeString(Qt.locale(),Locale.ShortFormat);


    Component{

        id : componentTimeDialog

        Dialog {

            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            id: timeDialog
            standardButtons: Dialog.Cancel | Dialog.Ok

            onVisibleChanged: if(!visible) destroy(1)

            contentItem : TimePicker
            {

            }
        }
    }

    function showTimeDialog(dateButton)
    {
        var timeDialogObject = componentTimeDialog.createObject(form)
        var timePicker = timeDialogObject.contentItem;


        if(dateButton.text.length > 0)
        {
            var date = Date.fromLocaleTimeString(Qt.locale(),dateButton.text,Locale.ShortFormat)
            date = new Date(date)
            timePicker.initialHour = date.getHours();
            timePicker.initialMinute = date.getMinutes();
        }

        timeDialogObject.accepted.connect(function(){
                           var timePicker = timeDialogObject.contentItem;
                           dateButton.text =
                           new Date(2000,0,1,timePicker.hour,timePicker.minute).toLocaleTimeString(Qt.locale(),Locale.ShortFormat)
                        })
        timeDialogObject.visible = true
    }


    Connections {

        target: buttonWorkingDayStart

        onClicked  : showTimeDialog(buttonWorkingDayStart)
    }


    Connections {

        target : buttonWorkingDayEnd

        onClicked   : showTimeDialog(buttonWorkingDayEnd)
        }

    Connections {

        target : buttonWeekendStart

        onClicked     : showTimeDialog(buttonWeekendStart)
        }

    Connections {

        target : buttonWeekendEnd

        onClicked  : showTimeDialog(buttonWeekendEnd)

        }

}
