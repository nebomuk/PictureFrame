import QtQuick 2.0

NewsImagePageForm {

    // when the page is completed, all contents entered by the user are send via signal and can then be converted to
    // the corresponding json object
    signal finished(var formData);


    buttonConfirm.onClicked:  {

        var formData = {};
        formData.option = comboBoxoption.currentText
        formData.source = comboBoxsource.currentText
        formData.design = comboBoxdesign.currentText
        finished(formData)
    }

}
