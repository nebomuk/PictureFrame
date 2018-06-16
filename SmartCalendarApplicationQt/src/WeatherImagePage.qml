import QtQuick 2.0
import de.vitecvisual.core 1.0;
import "OptionComboBoxUtil.js" as OptionComboBoxUtil;
import Qt.labs.platform 1.0



WeatherImagePageForm {

    // sends json to CalendarMainPage
    signal finished(var formData);

    property var formData



    Component.onCompleted:
    {
        if(Object.keys(formData).length > 1)
        {
            //comboBoxOption.initialText = formData.timeScale; // FIXME initial item is translation mapped option
            comboBoxcountry.initialText = formData.country;
            comboBoxUnit.initialText = formData.unit;
            spinBoxadditionalNumberOfDays.value = formData.additionalNumberOfDays;
            textFieldcityName.text = formData.cityName;
        }
    }


    MessageDialog
    {
        title : qsTr("City missing");
        id : msgDialogNoCity
        text : qsTr("You must enter a valid city name.");
    }

    function onDoneClicked()  {

        if(textFieldcityName.text.length === 0)
        {
            msgDialogNoCity.open();
            return;
        }


        var formData = {};
        formData.timeScale = OptionComboBoxUtil.mapToOption(comboBoxOption.currentIndex); // uses option according to xamarin app
        formData.additionalNumberOfDays = comboBoxOption.currentIndex  > 0 ? spinBoxadditionalNumberOfDays.value : 0; // no addtional nmb of days for option1
        formData.cityName = textFieldcityName.text;
        formData.country = comboBoxcountry.currentText;
        formData.unit = comboBoxUnit.model.get(comboBoxUnit.currentIndex).unit;
        formData.design = comboBoxDesign.currentText
        finished(formData)
    }

}
