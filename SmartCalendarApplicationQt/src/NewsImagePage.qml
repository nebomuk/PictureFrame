import QtQuick 2.0

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
        comboBoxdesign.initialText = formData.design
        comboBoxsource.initialText = formData.source
        //comboBoxoption.currentIndex = optionModel.formData.option
    }

    buttonConfirm.onClicked:  {

        var formData = {};
        formData.option = optionModel.get(comboBoxoption.currentIndex).text
        formData.source = comboBoxsource.currentText
        formData.design = comboBoxdesign.currentText
        finished(formData)
    }

}
