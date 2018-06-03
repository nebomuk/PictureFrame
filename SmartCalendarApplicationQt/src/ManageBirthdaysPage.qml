import QtQuick 2.0
import QtQuick.Controls 2.3
import Qt.labs.platform 1.0 as QtLabs
import de.vitecvisual.core 1.0;
import "DateUtil.js" as DateUtil
import "ListModelUtil.js" as ListModelUtil
import "SignalUtil.js" as SignalUtil
import QtQml.StateMachine 1.0 as DSM


ManageBirthdaysPageForm {

    Component.onCompleted: {

        buttonBirthdate.text = qsTr("Birthdate");

        var dataContainer = DeviceAccessor.controllerDataContainer;

        // birthdays already received before
        if(Object.keys(dataContainer.birthdayPlan).length !== 0)
        {
            addBirthdaysToModel()
        }
        else
        {
            DeviceAccessor.queryBirthdayPlan();
            SignalUtil.connectOnce(dataContainer.birthdayPlanChanged,addBirthdaysToModel);
        }

        buttonAddEntry.enabled = Qt.binding(function() {
          return buttonBirthdate.text !== qsTr("Birthdate") && textFieldLastName.text.length > 0 && textFieldFirstName.text.length > 0;
        }
        );
    }

    QtLabs.MessageDialog {
         id : dialogPersonExists
         buttons: QtLabs.MessageDialog.Ok
         title : qsTr("Error")
         text: qsTr("A person with the same name and birthdate already exists")
     }

    buttonAddEntry.onClicked: {

        if(!listModelContains(textFieldFirstName.text,textFieldLastName.text,datePickerDialog.date))
        {
            addEntry(textFieldFirstName.text,textFieldLastName.text,datePickerDialog.date)
            buttonBirthdate.text = qsTr("Birthdate");
        }
        else
        {
            dialogPersonExists.open();
        }
    }

    function listModelContains(firstName,lastName,date)
    {
        for(var i = 0; i < listView.model.count; ++i)
        {
            var item = listView.model.get(i);
            if (item.firstName === firstName
                    && item.lastName === lastName
                    && item.dateObject.getDay() === date.getDay()
                    && item.dateObject.getMonth() === date.getMonth())
            {
                return true;
            }
        }
        return false;
    }

    function onDoneClicked() {
            var newBirthdayPlan = [];

            for(var i = 0; i < listView.model.count; i++)
            {
                var item = listView.model.get(i);
                newBirthdayPlan.push({"ID":0, clientId:"","firstName":item.firstName,"name":item.lastName,"date":DateUtil.toShortISOString(item.dateObject)})
            }
            DeviceAccessor.controllerDataContainer.birthdayPlan = newBirthdayPlan;

            sendDialog.sendFunction = function() { DeviceAccessor.sendBirthdayTable(newBirthdayPlan); }
            sendDialog.open();
    }

    function addBirthdaysToModel()
    {

        var dataContainer = DeviceAccessor.controllerDataContainer;
        //dataContainer.disconnect(addBirthdaysToModel);
        var birthdayPlan = dataContainer.birthdayPlan;
        listView.model.clear();

        for (var i = 0; i < birthdayPlan.length; i++){
            addEntry(birthdayPlan[i].firstName,birthdayPlan[i].name,new Date(birthdayPlan[i].date));
        }
    }

    // birthdate is the localized birthday string
    function addEntry(firstName,lastName,dateObject)
    {
        listView.model.append({"firstName" :firstName,
                                  "lastName":lastName,
                                  // date without year is nearly impossible to properly localize automatically
                                  "birthdate":DateUtil.toStringWithoutYear(dateObject),
                                  "dateObject": dateObject})

        ListModelUtil.sortModel(listView.model,compareLastAndFirstNames)
    }



    function compareLastAndFirstNames(listItem1, listItem2)
    {

        var lastName1 = listItem1.lastName;
        var lastName2 = listItem2.lastName;
        var firstName1 = listItem1.firstName;
        var firstName2 = listItem2.firstName;

        if(lastName1 === lastName2)
        {
            return firstName1 > firstName2;
        }
        else
        {
            return lastName1 > lastName2;
        }
    }

    Dialog
    {
        id : sendDialog

        property var sendFunction : function() { }

        standardButtons:  Dialog.Ok

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        BusyIndicator
        {
            id : busyIndicator
        }

        DSM.StateMachine {
                      id: stateMachine
                      initialState: dialogHidden
                      running: true
                      DSM.State {
                          id: dialogHidden
                          DSM.SignalTransition {
                              targetState: dialogShown
                              signal: sendDialog.aboutToShow
                          }

                          onEntered: {
                              sendDialog.standardButton(Dialog.Ok).visible = false;
                          }
                      }
                      DSM.State {
                          id: dialogShown
                          DSM.SignalTransition {
                              targetState: successfull
                              signal: DeviceAccessor.published
                          }
//                          DSM.TimeoutTransition
//                          {
//                              targetState: successfull
//                              timeout: 2000

//                          }

                          onEntered: {
                              busyIndicator.visible = true;
                              sendDialog.sendFunction();
                              sendDialog.title = qsTr("Sending");
                          }
                      }
                      DSM.State {
                          id: successfull
                          onEntered: {
                              busyIndicator.visible = false;
                               sendDialog.standardButton(Dialog.Ok).visible = true;
                              sendDialog.title = qsTr("Successfull");
                          }
                          DSM.SignalTransition
                          {
                              targetState: dialogHidden
                              signal : sendDialog.aboutToHide
                          }
                      }
                  }

    }



    DatePickerDialog
    {
        id : datePickerDialog
        yearVisible: false
        button: buttonBirthdate
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
    }

}
