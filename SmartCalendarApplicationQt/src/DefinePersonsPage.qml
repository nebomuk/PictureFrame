import QtQuick 2.0
import de.vitecvisual.core 1.0;
import Qt.labs.platform 1.0
import de.vitecvisual.core 1.0;


DefinePersonsPageForm {

    addButton.onClicked: {
        googleCalendarAuthorization.startAuthorization();
    }


    GoogleCalendarAuthorization
    {
        id : googleCalendarAuthorization
    }


    Component.onCompleted: {
        var personList = DeviceAccessor.controllerDataContainer.personList;

        getCalendarList(function(xhr)
        {
            var data = JSON.parse(xhr.responseText);
            var items = data.items;
            listModel = items;
            console.log(data);
        });

    }

    function getCalendarList(receivedFunction)
    {
        var xhr = new XMLHttpRequest();
        xhr.withCredentials = true;
        xhr.onreadystatechange = function () {
          if (xhr.readyState === XMLHttpRequest.DONE) {
              receivedFunction(xhr);

          }
        }

        xhr.open("GET", "https://www.googleapis.com/calendar/v3/users/me/calendarList");
        xhr.setRequestHeader("authorization", "Bearer " + googleCalendarAuthorization.authorizationFlow.token);

        xhr.send(null);
    }

}
