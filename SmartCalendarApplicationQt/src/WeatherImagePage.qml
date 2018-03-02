import QtQuick 2.0
import de.vitecvisual.core 1.0;


WeatherImagePageForm {

    // sends json to CalendarMainPage
    signal finished(var formData);

    property var formData



    Component.onCompleted:
    {
        comboBoxOption.initialText = formData.timeScale;
        comboBoxcountry.initialText = formData.country;
        comboBoxUnit.initialText = formData.unit;
        spinBoxadditionalNumberOfDays.value = formData.additionalNumberOfDays;
        textFieldcityName.text = formData.cityName;
    }


    buttonConfirm.onClicked:  {

        var formData = {};
        formData.timeScale = comboBoxOption.currentText; // uses option according to xamarin app
        formData.additionalNumberOfDays = spinBoxadditionalNumberOfDays.value;
        formData.cityName = textFieldcityName.text;
        formData.country = comboBoxcountry.currentText;
        formData.unit = comboBoxUnit.model.get(comboBoxUnit.currentIndex).unit;
        finished(formData)
    }

}
