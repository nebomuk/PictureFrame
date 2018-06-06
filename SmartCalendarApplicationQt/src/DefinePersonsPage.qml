import QtQuick 2.0
import de.vitecvisual.core 1.0;
import Qt.labs.platform 1.0
import de.vitecvisual.core 1.0;
import QtQml.StateMachine 1.0 as DSM;


DefinePersonsPageForm {

    GoogleCalendarAuthorization
    {
        id : googleCalendarAuthorization
    }

    addButton.onClicked: {
        googleCalendarAuthorization.startAuthorization();
    }

    DSM.StateMachine
    {
        running: true
        initialState: googleCalendarAuthorization.linked ? stateLinked : stateUnlinked

        DSM.State
        {
            id : stateLinked
            initialState: stateGetCalendarList

            DSM.State
            {
                id : stateGetCalendarList
                onEntered: {
                    calendarApi.getCalendarList();
                }
                DSM.SignalTransition
                {
                    signal : calendarApi.success
                    targetState: stateCalendarSuccess
                }
                DSM.SignalTransition
                {
                    signal : calendarApi.error
                    targetState: stateCalendarError
                }
            }

            DSM.State
            {
                id : stateCalendarSuccess
                onEntered:
                {
                    var data = JSON.parse(calendarApi.request.responseText);
                    var items = data.items;
                    listModel = items;
                    console.log(data);
                }
            }

            DSM.State
            {
                id : stateCalendarError
                onEntered: {
                    // 1.) refresh token expired or
                    // 2.) user removed permission
                    googleCalendarAuthorization.o2.refresh();
                }
                DSM.SignalTransition {
                    signal : googleCalendarAuthorization.o2.refreshFinished
                    guard : error === 0 // QNetworkReply::Error::NoError
                    targetState: stateGetCalendarList
                }
                DSM.SignalTransition {
                    signal : googleCalendarAuthorization.o2.refreshFinished
                    guard : error !== 0
                    targetState: stateUnlinked
                }

            }

        }

        DSM.State
        {
            id : stateUnlinked

            onActiveChanged:
            {
                addButton.visible = active;
            }

            DSM.SignalTransition
            {
                signal : googleCalendarAuthorization.o2.linkingFailed
                targetState: stateUnlinked
            }

            DSM.SignalTransition
            {
                signal : googleCalendarAuthorization.o2.linkingSucceeded
                targetState: stateLinked
            }
        }


    }


    Component.onCompleted: {
        var personList = DeviceAccessor.controllerDataContainer.personList;

    }

    QtObject
    {
        id : calendarApi

        signal success(XMLHttpRequest xhr);

        signal error(XMLHttpRequest xhr);

        property var request

        function getCalendarList()
        {
            var xhr = new XMLHttpRequest();
            request = xhr;
            xhr.withCredentials = true;
            xhr.onreadystatechange = function () {
              if (xhr.readyState === XMLHttpRequest.DONE) {
                  console.debug("getCalendarList http status code " + xhr.status);
                  if(xhr.status === 200)
                  {
                      success(xhr);
                  }
                  else
                  {
                      error(xhr);
                  }
              }
            }

            xhr.open("GET", "https://www.googleapis.com/calendar/v3/users/me/calendarList");
            xhr.setRequestHeader("authorization", "Bearer " + googleCalendarAuthorization.o2.token);

            xhr.send(null);
        }

    }



}
