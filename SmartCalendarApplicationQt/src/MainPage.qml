import QtQuick 2.0
import QtQuick.Controls 2.1

import de.vitecvisual.core 1.0;



MainPageForm {

    id : mainPage

    buttonDeviceSelection.onClicked:  {
        stackView.push("DeviceManagerPage.qml")
    }
    buttonBaseConfiguration.onClicked: {
        stackView.push("BaseOptionsPage.qml")
    }
    buttonCalendarView.onClicked: {
        stackView.push("CalendarMainPage.qml")
    }

    buttonImagePicker.onClicked: {

        LoggingFilter.setFilterRules("qt.qml.binding.removal.info=false");
        stackView.push("DynamicPicturePage.qml",{formData:{}});
    }
}

