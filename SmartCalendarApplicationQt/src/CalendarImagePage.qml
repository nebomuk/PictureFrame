import QtQuick 2.0

CalendarImagePageForm {

    // sends json to CalendarMainPage
    signal finished(var formData);


    buttonConfirm.onClicked: {

    }

    Component.onCompleted:
    {

    }

    comboBoxTimeView.onCurrentIndexChanged: {
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

}
