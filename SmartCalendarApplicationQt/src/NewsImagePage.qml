import QtQuick 2.0

NewsImagePageForm {

    // sends json to CalendarMainPage
    signal finished(var formData);

    buttonConfirm.onClicked:  {

        var formData = {};
        formData.option = comboBoxoption.currentText
        formData.source = comboBoxsource.currentText
        formData.design = comboBoxdesign.currentText
        finished(formData)
    }

}
