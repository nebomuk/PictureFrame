import QtQuick 2.0

NewsImagePageForm {

    // sends json to CalendarMainPage
    signal finished(var formData);

    StringXmlResourceModel
    {
        id : optionModel // Option1,..2..3
        attributeName: "formatViewSpinnerArray"
    }

    buttonConfirm.onClicked:  {

        var formData = {};
        formData.option = optionModel.get(comboBoxoption.currentIndex).text
        formData.source = comboBoxsource.currentText
        formData.design = comboBoxdesign.currentText
        finished(formData)
    }

}
