import QtQuick 2.0
import QtQuick.Controls 2.3
import de.vitecvisual.core 1.0;
import Qt.labs.platform 1.0

import "DateUtil.js" as DateUtil
import "ListModelUtil.js" as ListModelUtil
import "SignalUtil.js" as SignalUtil


ManageTrashPlanPageForm {

    Component.onCompleted: {

        buttonDate.text =  qsTr("Date")

        var dataContainer = DeviceAccessor.controllerDataContainer;

        // trash plans already received before
        if(Object.keys(dataContainer.trashPlan).length !== 0)
        {
            addTrashEntriesToModel()
        }
        else
        {
            DeviceAccessor.queryTrashPlan();
            SignalUtil.connectOnce(dataContainer.trashPlanChanged,addTrashEntriesToModel);
        }

        buttonAddEntry.enabled = Qt.binding(function() {
          return buttonDate.text !== qsTr("Date") && textFieldTrashType.text.length > 0;
        }
        );
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
            DeviceAccessor.sendTrashTable(newTrashPlan);
            stackView.pop();
    }

    function addTrashEntriesToModel()
    {

        var dataContainer = DeviceAccessor.controllerDataContainer;
        //dataContainer.disconnect(addTrashEntriesToModel);
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


}
