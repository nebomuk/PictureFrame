import QtQuick 2.0
import de.vitecvisual.core 1.0;
import "SignalUtil.js" as SignalUtil

MasterAccountPageForm {

    function onDoneClicked() {
        GoogleCalendarAuthorization.startAuthorization();

        SignalUtil.connectOnce(GoogleCalendarAuthorization.granted,onGranted);
    }

    function onGranted()
    {
        console.log("granted");
        var flow = GoogleCalendarAuthorization.authorizationFlow;
        console.log("token: " + flow.token);
    }

    function onFailed()
    {
        console.log("failed");
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
