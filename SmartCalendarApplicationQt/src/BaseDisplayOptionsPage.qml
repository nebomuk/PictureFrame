import QtQuick 2.4
import QtQuick.Controls 2.3
import QtQml 2.0
import de.vitecvisual.core 1.0;
import "DateUtil.js" as DateUtil;


BaseDisplayOptionsPageForm {

    id: form

    Component.onCompleted: {

        var dataContainer = DeviceAccessor.controllerDataContainer;


        radioButtonautomatedDisplayBrightness.checked = dataContainer.displayOptions.automatedDisplayBrightness === 1;
        radioButtonpermanentActiveDisplay.checked = dataContainer.displayOptions.permanentActiveDisplay === 1;


        // FIXME on java app, fixedDisplayBrightness is always undefined
        //spinBoxfixedDisplayBrightness.value = dataContainer.displayOptions.fixedDisplayBrightness;

        var firstIntervallWorkdayPowerSavingModeStartDate = dataContainer.displayOptions.firstIntervallWorkdayPowerSavingModeStartDate;
        var firstIntervallWorkdayPowerSavingModeEndDate = dataContainer.displayOptions.firstIntervallWorkdayPowerSavingModeEndDate;
        var secondIntervallWorkdayPowerSavingModeStartDate = dataContainer.displayOptions.secondIntervallWorkdayPowerSavingModeStartDate;
        var secondIntervallWorkdayPowerSavingModeEndDate = dataContainer.displayOptions.secondIntervallWorkdayPowerSavingModeEndDate;
        var firstIntervallWeekendPowerSavingModeStartDate = dataContainer.displayOptions.firstIntervallWeekendPowerSavingModeStartDate;
        var firstIntervallWeekendPowerSavingModeEndDate = dataContainer.displayOptions.firstIntervallWeekendPowerSavingModeEndDate;
        var secondIntervallWeekendPowerSavingModeStartDate = dataContainer.displayOptions.secondIntervallWeekendPowerSavingModeStartDate;
        var secondIntervallWeekendPowerSavingModeEndDate = dataContainer.displayOptions.secondIntervallWeekendPowerSavingModeEndDate;



            buttonWorkingDayStart.text=   toLocaleTimeString(firstIntervallWorkdayPowerSavingModeStartDate);
            buttonWorkingDayEnd.text=  toLocaleTimeString(firstIntervallWorkdayPowerSavingModeEndDate);
            buttonWorkingDayStart2.text=   toLocaleTimeString(secondIntervallWorkdayPowerSavingModeStartDate);
            buttonWorkingDayEnd2.text=  toLocaleTimeString(secondIntervallWorkdayPowerSavingModeEndDate);

            buttonWeekendStart.text= toLocaleTimeString(firstIntervallWeekendPowerSavingModeStartDate);
            buttonWeekendEnd.text=  toLocaleTimeString(firstIntervallWeekendPowerSavingModeEndDate);
            buttonWeekendStart2.text= toLocaleTimeString(secondIntervallWeekendPowerSavingModeStartDate);
            buttonWeekendEnd2.text=  toLocaleTimeString(secondIntervallWeekendPowerSavingModeEndDate);

        //buttonDone.clicked.connect(onDoneClicked);
    }

    // input from json format:
    // 2000-12-12T12:12
    function toLocaleTimeString(dateString)
    {
        return new Date(dateString).toLocaleTimeString(Qt.locale(),Locale.ShortFormat);
    }

    function fromLocaleTimeString(timeString)
    {
        var date =  new Date(Date.fromLocaleTimeString(Qt.locale(),timeString,Locale.ShortFormat));
        // toIsoString() in qml would create 2018-02-19T12:12:00.000Z but we want the same as the input
        var res = DateUtil.toShortISOString(date);
        return res;
    }

    function onDoneClicked() {

        // checked radio button is 1, the other one is 0

        var displayOptions = DeviceAccessor.controllerDataContainer.displayOptions;

        displayOptions.fixedDisplayBrightness = !radioButtonautomatedDisplayBrightness.checked ? spinBoxfixedDisplayBrightness.value : 0;
        displayOptions.automatedDisplayBrightness = radioButtonautomatedDisplayBrightness.checked ? 1 : 0;

        displayOptions.displaySensibilityLevel = !radioButtonpermanentActiveDisplay.checked  ? 1 : 0; // ui renamed to "auto"
        displayOptions.permanentActiveDisplay = radioButtonpermanentActiveDisplay.checked ? 1 : 0;

            if(checkBoxButtonWorkingDay.checked)
            {
                displayOptions.firstIntervallWorkdayPowerSavingModeStartDate = fromLocaleTimeString(buttonWorkingDayStart.text)
                displayOptions.firstIntervallWorkdayPowerSavingModeEndDate = fromLocaleTimeString(buttonWorkingDayEnd.text)
                displayOptions.firstIntervallWeekendPowerSavingModeStartDate = fromLocaleTimeString(buttonWeekendStart.text)
                displayOptions.firstIntervallWeekendPowerSavingModeEndDate = fromLocaleTimeString(buttonWeekendEnd.text)

            }
            if(checkBoxButtonWeekend.checked)
            {
                displayOptions.secondIntervallWorkdayPowerSavingModeStartDate = fromLocaleTimeString(buttonWorkingDayStart2.text)
                displayOptions.secondIntervallWorkdayPowerSavingModeEndDate = fromLocaleTimeString(buttonWorkingDayEnd2.text)
                displayOptions.secondIntervallWeekendPowerSavingModeStartDate = fromLocaleTimeString(buttonWeekendStart2.text)
                displayOptions.secondIntervallWeekendPowerSavingModeEndDate = fromLocaleTimeString(buttonWeekendEnd2.text)
            }

        DeviceAccessor.controllerDataContainer.displayOptions = displayOptions;

        DeviceAccessor.sendSmartCalendarDeviceOptions(displayOptions);
    }

    buttonWorkingDayStart.onClicked  : showTimeDialog(buttonWorkingDayStart)
    buttonWorkingDayEnd.onClicked   : showTimeDialog(buttonWorkingDayEnd)

    buttonWeekendStart.onClicked     : showTimeDialog(buttonWeekendStart)

    buttonWeekendEnd.onClicked  : showTimeDialog(buttonWeekendEnd)

    buttonWorkingDayStart2.onClicked  : showTimeDialog(buttonWorkingDayStart2)
    buttonWorkingDayEnd2.onClicked   : showTimeDialog(buttonWorkingDayEnd2)

    buttonWeekendStart2.onClicked     : showTimeDialog(buttonWeekendStart2)

    buttonWeekendEnd2.onClicked  : showTimeDialog(buttonWeekendEnd2)


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

}
