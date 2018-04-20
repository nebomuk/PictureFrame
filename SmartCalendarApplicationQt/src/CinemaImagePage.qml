import QtQuick 2.0
import "OptionComboBoxUtil.js" as OptionComboBoxUtil;


CinemaImagePageForm {

    // sends json to CalendarMainPage
    signal finished(var formData);

    // for the control's initial values
    property var formData

    Component.onCompleted:
    {
        var keys = Object.keys(formData);
        if(keys.length > 1) // not only contains default key
        {
         comboBoxgenre.initialText = formData.genre
         comboBoxdesign.initialText = formData.design
         comboBoxcountry.initialText = formData.country
        }

    }

    buttonConfirm.onClicked:  {

        var formData = {};
        // combo box option shows a different user string from what should be sent via json
        formData.option =  OptionComboBoxUtil.mapToOption(comboBoxoption.currentIndex);
        formData.genre = comboBoxgenre.currentText;
        formData.design = comboBoxdesign.currentText;
        formData.country = comboBoxcountry.currentText;

        finished(formData)
    }

    StringXmlResourceModel
    {
        id : optionModel // Option1,..2..3
        attributeName: "formatViewSpinnerArray"
    }

}
