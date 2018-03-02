import QtQuick 2.0

CinemaImagePageForm {

    // sends json to CalendarMainPage
    signal finished(var formData);

    // for the control's initial values
    property var formData

    Component.onCompleted:
    {
        if(Object.keys(formData).length > 0)
        {
         comboBoxgenre.initialText = formData.genre
         comboBoxdesign.initialText = formData.design
         comboBoxcountry.initialText = formData.country
        }

    }

    buttonConfirm.onClicked:  {

        var formData = {};
        // combo box option shows a different user string from what should be sent via json
        formData.option =  optionModel.get(comboBoxoption.currentIndex).text;
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
