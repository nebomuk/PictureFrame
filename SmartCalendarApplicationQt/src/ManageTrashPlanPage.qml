import QtQuick 2.0
import QtQuick.Controls 2.3
import de.vitecvisual.core 1.0;
import "DateUtil.js" as DateUtil

ManageTrashPlanPageForm {

    Component.onCompleted: {

        buttonDate.text =  DateUtil.toStringWithoutYear(new Date(1980,0,1))

        var dataContainer = DeviceAccessor.controllerDataContainer;

        // trash plans already received before
        if(Object.keys(dataContainer.trashPlan).length !== 0)
        {
            addTrashEntriesToModel()
        }
        else
        {
            DeviceAccessor.queryTrashPlan();
            dataContainer.trashPlanChanged.connect(addTrashEntriesToModel);
        }

    }

    buttonAddEntry.onClicked: addEntry(textFieldTrashType.text,buttonDate.text)

    buttonConfirm.onClicked: {
            var newTrashPlan = [];

            for(var i = 0; i < listView.model.count; i++)
            {
                var item = listView.model.get(i);
                var date =  new Date(Date.fromLocaleDateString(Qt.locale(),item.date,Locale.ShortFormat));
                newTrashPlan.push({"clientID":"", "trashType":item.trashType,"date":DateUtil.toShortISOString(date)})
            }
            DeviceAccessor.controllerDataContainer.trashPlan = newTrashPlan;
            DeviceAccessor.sendTrashTable(newTrashPlan);

    }

    function addTrashEntriesToModel()
    {

        var dataContainer = DeviceAccessor.controllerDataContainer;
        //dataContainer.disconnect(addTrashEntriesToModel);
        var trashPlan = dataContainer.trashPlan;


        for (var i = 0; i < trashPlan.length; i++){
            addEntry(trashPlan[i].trashType,DateUtil.toStringWithoutYear(new Date(trashPlan[i].date)));
        }
    }

    // date is the localized date string
    function addEntry(trashType,date)
    {
        listView.model.append({"trashType" :trashType,
                                  "date":date})
    }

    DatePickerDialog
    {
        yearVisible: false
        button: buttonDate
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
    }


}
