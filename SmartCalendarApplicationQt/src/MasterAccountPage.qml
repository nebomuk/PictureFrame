import QtQuick 2.0
import de.vitecvisual.core 1.0;

MasterAccountPageForm {

    function onDoneClicked() {
        GoogleCalendarAuthorization.startAuthorization();
    }

    Component.onCompleted: {
        var personList = DeviceAccessor.controllerDataContainer.personList;
        if(personList.length > 0)
        {
            textFieldEmail.text =  personList[0].eMailAdress
            textFieldName.text =  personList[0].name
        }
    }

}
