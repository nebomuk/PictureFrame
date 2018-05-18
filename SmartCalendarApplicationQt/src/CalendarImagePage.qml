import QtQuick 2.0
import "DateUtil.js" as DateUtil
import "OptionComboBoxUtil.js" as OptionComboBoxUtil;


CalendarImagePageForm {

    // sends json to CalendarMainPage
    signal finished(var formData);

    // for the control's initial values
    property var formData

    Component.onCompleted:
    {
        populateComboBoxMonth(); // must come first


        //spinBoxAdditionalNumberOfDays.value = formData.additionalNumberOfDays
        // FIXME implementation stub
        // should set the other stuff from formData

    }

    function onDoneClicked() {
        var formData = {};
        // combo box option shows a different user string from what should be sent via json
        formData.format =  OptionComboBoxUtil.mapToOption(comboBoxoption.currentIndex);

        formData.timeScale = getTimeScaleKeyForIndex(comboBoxTimeView.currentIndex);

        var year = new Date().getFullYear();

        formData.startTimeInterval  = DateUtil.toShortISOString(new Date(year,0,0,spinBoxStartTime.value));;

        formData.endTimeInterval = DateUtil.toShortISOString(new Date(year,0,0,spinBoxEndTime.value));;

        formData.monthTimeInterval = DateUtil.toShortISOString(new Date(year,comboBoxMonth.currentIndex,0));

        formData.additionalNumberOfDays = spinBoxAdditionalNumberOfDays.value;

        formData.design = comboBoxDesign.currentText

        finished(formData)

    }

    comboBoxTimeView.onCurrentIndexChanged: {
        updateComboBoxDesign();
    }

    StringXmlResourceModel
    {
        id : calendarDayDesignModel
        attributeName : "calendarDayDesignSpinnerArray"
        onStatusChanged: {
            //  set intial model for design combo box
            if(status === StringXmlResourceModel.Ready)
            {
                comboBoxDesign.model = calendarDayDesignModel
                comboBoxDesign.currentIndex = 0
            }
        }

    }
    StringXmlResourceModel
    {
        id : calendarWeekDesignModel
        attributeName : "calendarWeekDesignSpinnerArray"

    }
    StringXmlResourceModel
    {
        id : calendarMonthDesignModel
        attributeName : "calendarMonthDesignSpinnerArray"
    }

    DatePickerDialog
    {
        initialYear: new Date().getFullYear();
        minYear : new Date().getFullYear();
        maxYear : new Date().getFullYear() + 10
        button: buttonStartDate
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
    }

    function populateComboBoxMonth()
    {
        for(var i = 0; i< 12; ++i)
        {
            comboBoxMonth.model.append({"name":formatMonth(i)})
        }
        comboBoxMonth.currentIndex = 0;
    }

    function formatMonth(month)
    {
        return new Date((new Date()).getFullYear(),month,0).toLocaleDateString(Qt.locale(), "MMMM")
    }

    function updateComboBoxDesign()
    {
        switch(comboBoxTimeView.currentIndex)
        {
        case 0:
            comboBoxDesign.model = calendarDayDesignModel;
            break;
        case 1:
            comboBoxDesign.model = calendarWeekDesignModel;
            break;
        case 2:
            comboBoxDesign.model = calendarMonthDesignModel;
            break;
        }
    }

    function getTimeScaleKeyForIndex(index)
    {
        // these json values are locale independent
        if(index === 0)
        {
            return "Tagesansicht";
        }
        else if(index === 1)
        {
            return "Wochenansicht";
        }
        else if(index === 2)
        {
            return "Monatsansicht";

        }
    }


}
