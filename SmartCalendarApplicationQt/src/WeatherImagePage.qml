import QtQuick 2.0
import de.vitecvisual.core 1.0;
import "OptionComboBoxUtil.js" as OptionComboBoxUtil;



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


    function onDoneClicked()  {

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
