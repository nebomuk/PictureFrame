import QtQuick 2.0
import de.vitecvisual.core 1.0;


WeatherImagePageForm {

    // sends json to CalendarMainPage
    signal finished(var formData);

    buttonConfirm.onClicked:  {

        var formData = {};
        formData.timeScale = ""; // FIXME missing specification of time scale;
        formData.additionalNumberOfDays = spinBoxadditionalNumberOfDays.value;
        formData.cityName = textFieldcityName.text;
        formData.country = comboBoxcountry.currentText;
        formData.unit = comboBoxUnit.currentText; // FIXME text does not match specification
        finished(formData)
    }

}
