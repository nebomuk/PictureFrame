import QtQuick 2.0
import "OptionComboBoxUtil.js" as OptionComboBoxUtil

NewsImagePageForm {

    // sends json to CalendarMainPage
    signal finished(var formData);

    property var formData


    StringXmlResourceModel
    {
        id : optionModel // Option1,..2..3
        attributeName: "formatViewSpinnerArray"
    }

    Component.onCompleted:
    {
        if(Object.keys(formData).length > 1)
        {
            comboBoxdesign.initialText = formData.design
            comboBoxsource.initialText = formData.source
            //comboBoxoption.currentIndex = optionModel.formData.option
        }
    }

    buttonConfirm.onClicked:  {

        var formData = {};
        formData.option = OptionComboBoxUtil.mapToOption(comboBoxoption.currentIndex)
        formData.source = comboBoxsource.currentText
        formData.design = comboBoxdesign.currentText
        finished(formData)
    }

}
