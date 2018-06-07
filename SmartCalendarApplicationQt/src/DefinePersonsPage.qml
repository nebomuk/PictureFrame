import QtQuick 2.0
import de.vitecvisual.core 1.0;
import Qt.labs.platform 1.0
import de.vitecvisual.core 1.0;
import QtQml.StateMachine 1.0 as DSM;
import Qt.labs.platform 1.0


DefinePersonsPageForm {

    GoogleCalendarAuthorization
    {
        id : googleCalendarAuthorization
    }

    addButton.onClicked: {
        googleCalendarAuthorization.o2.link();
    }

    DSM.StateMachine
    {
        running: true
        initialState: googleCalendarAuthorization.o2.linked === true ? stateLinked : stateUnlinked

        DSM.State
        {
            id : stateLinked
            initialState: stateGetCalendarList

            DSM.State
            {
                id : stateGetCalendarList
                onEntered: {
                    console.info("O2 DSM stateLinked.onEntered calling calendarApi.getCalendarList()");
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
                    console.info("O2 DSM sub stateCalendarSuccess.onEntered filling list model");
                    var data = JSON.parse(calendarApi.request.responseText);
                    var items = data.items;
                    listModel = items;
                    console.log(data);
                }
            }


            // 1.) refresh token expired or
            // 2.) user removed google calendar access permission for SmartCalendarThync
            // 3.) no wlan, but this would trigger the mqtt back to main menu stuff
            DSM.State
            {
                id : stateCalendarError
                onEntered: {
                    console.info("O2 DSM sub stateCalendarError.onEntered calling o2.refresh()");
                    googleCalendarAuthorization.o2.refresh();
                }
                DSM.SignalTransition {
                    signal : googleCalendarAuthorization.o2.refreshFinished
                    guard : error === 0 // QNetworkReply::Error::NoError
                    targetState: stateGetCalendarList
                }
                // when there's any network error (that is a server reply error, not a network timeout)
                // the  O2 library will send the linkedChanged signal with linked === false and internally call unlink()
                DSM.SignalTransition {
                    signal : googleCalendarAuthorization.o2.linkedChanged
                    guard : googleCalendarAuthorization.o2.linked === false
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

            onEntered: {
                console.info("O2 DSM  stateUnlinked.onEntered open msg dialog");
                   msgDialogNoGoogleCalendarAccount.open();
            }

            DSM.SignalTransition
            {
                signal : googleCalendarAuthorization.o2.linkedChanged
                targetState: stateUnlinked
                guard : !googleCalendarAuthorization.o2.linked
            }

            DSM.SignalTransition
            {
                signal : googleCalendarAuthorization.o2.linkedChanged
                targetState: stateLinked
                guard : googleCalendarAuthorization.o2.linked
            }
        }
    }

    MessageDialog {
          id : msgDialogNoGoogleCalendarAccount
          buttons: MessageDialog.Ok
          title: qsTr("Google Calendar Account required")
          text: qsTr("There's no Google Account configured to display your calendars. Please press the button below to choose a Google Account to use with this app");
      }



    Component.onCompleted: {
        var personList = DeviceAccessor.controllerDataContainer.personList;

    }

    QtObject
    {
        id : calendarApi

        signal success();

        signal error();

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
