import QtQuick 2.0
import QtQuick.Controls 2.3
import pictureframecompany.core 1.0;
import Qt.labs.platform 1.0
import QtQml.StateMachine 1.0 as DSM;

import "DateUtil.js" as DateUtil
import "ListModelUtil.js" as ListModelUtil
import "SignalUtil.js" as SignalUtil


ManageTrashPlanPageForm {

    Component.onCompleted: {

        buttonDate.text =  qsTr("Date")

        buttonAddEntry.enabled = Qt.binding(function() {
          return buttonDate.text !== qsTr("Date") && textFieldTrashType.text.length > 0;
        }
        );


    }

    DSM.StateMachine
    {
        running: true

        initialState: stateQueryingTrashPlan

        DSM.State
        {
            id : stateQueryingTrashPlan

            onEntered:  DeviceAccessor.queryTrashPlan();
            DSM.SignalTransition
            {
                signal : DeviceAccessor.controllerDataContainer.trashTableReceivedChanged
                targetState: stateTrashPlanQueryFinished
            }
        }

        DSM.FinalState
        {
            id : stateTrashPlanQueryFinished
            onEntered: {
                DeviceAccessor.controllerDataContainer.trashTableReceived = false; // reset state for next time
                addTrashEntriesToModel()
            }
        }
    }

    MessageDialog {
         id : dialogExists
         buttons: MessageDialog.Ok
         title : qsTr("Error")
         text: qsTr("A trash plan entry with the same name and date already exists")
     }



    buttonAddEntry.onClicked: {

        if(!listModelContains(textFieldTrashType.text,datePickerDialog.date))
        {
            addEntry(textFieldTrashType.text,datePickerDialog.date)
            buttonDate.text = qsTr("Date");
        }
        else
        {
            dialogExists.open();
        }
    }

    function listModelContains(trashType,date)
    {
        for(var i = 0; i < listView.model.count; ++i)
        {
            var item = listView.model.get(i);
            if (item.trashType === trashType
                    && item.dateObject.getDay() === date.getDay()
                    && item.dateObject.getMonth() === date.getMonth())
            {
                return true;
            }
        }
        return false;
    }

    function onDoneClicked() {
            var newTrashPlan = [];

            for(var i = 0; i < listView.model.count; i++)
            {
                var item = listView.model.get(i);
                newTrashPlan.push({"clientID":"", "trashType":item.trashType,"date":DateUtil.toShortISOString(item.dateObject)})
            }
            DeviceAccessor.controllerDataContainer.trashPlan = newTrashPlan;
            sendDialog.sendFunction = function() { DeviceAccessor.sendTrashTable(newTrashPlan); }
            sendDialog.open();
    }

    function addTrashEntriesToModel()
    {

        var dataContainer = DeviceAccessor.controllerDataContainer;
        var trashPlan = dataContainer.trashPlan;

        listView.model.clear();

        for (var i = 0; i < trashPlan.length; i++){
            addEntry(trashPlan[i].trashType,new Date(trashPlan[i].date));
        }
    }

    // date is the localized date string
    function addEntry(trashType,date)
    {
        listView.model.append({"trashType" :trashType,
                                  "date":DateUtil.toStringWithoutYear(date),
                                  "dateObject":date}) // add dateObject separately because formatting function call not possible in quick ui form

        ListModelUtil.sortModel(listView.model,compareDate);

    }

    function compareDate(listItem1, listItem2)
    {
        return listItem1.dateObject > listItem2.dateObject
    }

    DatePickerDialog
    {
        id : datePickerDialog
        yearVisible: false
        button: buttonDate
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
    }

    SendDialog {
        id: sendDialog
        onAccepted: stackView.pop();
    }


}
