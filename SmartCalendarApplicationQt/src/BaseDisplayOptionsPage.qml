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

        intervals.firstIntervallWorkdayPowerSavingModeStartDate = dataContainer.displayOptions.firstIntervallWorkdayPowerSavingModeStartDate;
        intervals.firstIntervallWorkdayPowerSavingModeEndDate = dataContainer.displayOptions.firstIntervallWorkdayPowerSavingModeEndDate;
        intervals.secondIntervallWorkdayPowerSavingModeStartDate = dataContainer.displayOptions.secondIntervallWorkdayPowerSavingModeStartDate;
        intervals.secondIntervallWorkdayPowerSavingModeEndDate = dataContainer.displayOptions.secondIntervallWorkdayPowerSavingModeEndDate;
        intervals.firstIntervallWeekendPowerSavingModeStartDate = dataContainer.displayOptions.firstIntervallWeekendPowerSavingModeStartDate;
        intervals.firstIntervallWeekendPowerSavingModeEndDate = dataContainer.displayOptions.firstIntervallWeekendPowerSavingModeEndDate;
        intervals.secondIntervallWeekendPowerSavingModeStartDate = dataContainer.displayOptions.secondIntervallWeekendPowerSavingModeStartDate;
        intervals.secondIntervallWeekendPowerSavingModeEndDate = dataContainer.displayOptions.secondIntervallWeekendPowerSavingModeEndDate;



        labelWorkingDay.text = createTimeLabelText(toLocaleTimeString(intervals.firstIntervallWorkdayPowerSavingModeStartDate),
            toLocaleTimeString(intervals.firstIntervallWorkdayPowerSavingModeEndDate),
            toLocaleTimeString(intervals.secondIntervallWorkdayPowerSavingModeStartDate),
            toLocaleTimeString(intervals.secondIntervallWorkdayPowerSavingModeEndDate));

        labelWeekend.text = createTimeLabelText(
             toLocaleTimeString(intervals.firstIntervallWeekendPowerSavingModeStartDate),
            toLocaleTimeString(intervals.firstIntervallWeekendPowerSavingModeEndDate),
            toLocaleTimeString(intervals.secondIntervallWeekendPowerSavingModeStartDate),
             toLocaleTimeString(intervals.secondIntervallWeekendPowerSavingModeEndDate));
    }

    QtObject
    {
        // stores ISO date strings temporarily while the user changes settings
        id : intervals
        property var firstIntervallWorkdayPowerSavingModeStartDate
        property var firstIntervallWorkdayPowerSavingModeEndDate
        property var secondIntervallWorkdayPowerSavingModeStartDate
        property var secondIntervallWorkdayPowerSavingModeEndDate
        property var firstIntervallWeekendPowerSavingModeStartDate
        property var firstIntervallWeekendPowerSavingModeEndDate
        property var secondIntervallWeekendPowerSavingModeStartDate
        property var secondIntervallWeekendPowerSavingModeEndDate
    }



    property bool timeRangeWizardIsEditingWorkingDay : false; // else weekend

    buttonChangeWorkingDay.onClicked: {
        timeRangeWizard.open();
        timeRangeWizardIsEditingWorkingDay = true;
    }

    function createTimeLabelText(firstStart,firstEnd,secondStart,secondEnd)
    {
        return firstStart + " - " + firstEnd + " " + qsTr("and") + " " +  secondStart + " - " + secondEnd;
    }

    timeRangeWizard.onAccepted: {

        var time = createTimeLabelText(hourToLocaleTimeString(firstStart),hourToLocaleTimeString(firstEnd),
                                       hourToLocaleTimeString(secondStart),hourToLocaleTimeString(secondEnd));
        if(timeRangeWizardIsEditingWorkingDay)
        {
            labelWorkingDay.text =time
            intervals.firstIntervallWorkdayPowerSavingModeStartDate      = DateUtil.toShortISOString( new Date(1,1,1,firstStart)  )
            intervals.firstIntervallWorkdayPowerSavingModeEndDate       =  DateUtil.toShortISOString( new Date(1,1,1,firstEnd)    )
            intervals.secondIntervallWorkdayPowerSavingModeStartDate    =  DateUtil.toShortISOString( new Date(1,1,1,secondStart) )
            intervals.secondIntervallWorkdayPowerSavingModeEndDate       = DateUtil.toShortISOString( new Date(1,1,1,secondEnd)   )
        }
        else
        {
            labelWeekend.text = time;
            intervals.firstIntervallWeekendPowerSavingModeStartDate    =  DateUtil.toShortISOString(new Date(1,1,1,firstStart)   )
            intervals.firstIntervallWeekendPowerSavingModeEndDate       = DateUtil.toShortISOString(new Date(1,1,1,firstEnd)     )
            intervals.secondIntervallWeekendPowerSavingModeStartDate    = DateUtil.toShortISOString(new Date(1,1,1,secondStart)  )
            intervals.secondIntervallWeekendPowerSavingModeEndDate      = DateUtil.toShortISOString(new Date(1,1,1,secondEnd)    )
        }
    }

    buttonChangeWeekend.onClicked: {
        timeRangeWizard.open();
        timeRangeWizardIsEditingWorkingDay = false;
    }

    function hourToLocaleTimeString(hour)
    {
        return new Date(1,1,1,hour).toLocaleTimeString(Qt.locale(),Locale.ShortFormat)
    }

    // input from json format:
    // 2000-12-12T12:12
    function toLocaleTimeString(dateString)
    {
        return new Date(dateString).toLocaleTimeString(Qt.locale(),Locale.ShortFormat);
    }

    function onDoneClicked() {

        // checked radio button is 1, the other one is 0

        var displayOptions = DeviceAccessor.controllerDataContainer.displayOptions;

        displayOptions.fixedDisplayBrightness = !radioButtonautomatedDisplayBrightness.checked ? spinBoxfixedDisplayBrightness.value : 0;
        displayOptions.automatedDisplayBrightness = radioButtonautomatedDisplayBrightness.checked ? 1 : 0;

        displayOptions.displaySensibilityLevel = !radioButtonpermanentActiveDisplay.checked  ? 1 : 0; // ui renamed to "auto"
        displayOptions.permanentActiveDisplay = radioButtonpermanentActiveDisplay.checked ? 1 : 0;

        if(checkBoxButtonWeekend.checked)
            {
                displayOptions.secondIntervallWeekendPowerSavingModeStartDate = intervals.secondIntervallWeekendPowerSavingModeStartDate
                displayOptions.secondIntervallWeekendPowerSavingModeEndDate = intervals.secondIntervallWeekendPowerSavingModeEndDate
                displayOptions.firstIntervallWeekendPowerSavingModeStartDate = intervals.firstIntervallWeekendPowerSavingModeStartDate
                displayOptions.firstIntervallWeekendPowerSavingModeEndDate = intervals.firstIntervallWeekendPowerSavingModeEndDate
            }
        if(checkBoxButtonWorkingDay.checked)
            {
                displayOptions.secondIntervallWorkdayPowerSavingModeStartDate = intervals.secondIntervallWorkdayPowerSavingModeStartDate
                displayOptions.secondIntervallWorkdayPowerSavingModeEndDate = intervals.secondIntervallWorkdayPowerSavingModeEndDate
                displayOptions.firstIntervallWorkdayPowerSavingModeStartDate = intervals.firstIntervallWorkdayPowerSavingModeStartDate
                displayOptions.firstIntervallWorkdayPowerSavingModeEndDate = intervals.firstIntervallWorkdayPowerSavingModeEndDate
            }

        DeviceAccessor.controllerDataContainer.displayOptions = displayOptions;

        DeviceAccessor.sendSmartCalendarDeviceOptions(displayOptions);
    }
}
