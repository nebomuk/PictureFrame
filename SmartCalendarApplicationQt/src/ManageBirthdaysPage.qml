import QtQuick 2.0
import QtQuick.Controls 2.3
import de.vitecvisual.core 1.0;
import "DateUtil.js" as DateUtil



ManageBirthdaysPageForm {

    Component.onCompleted: {

        buttonBirthdate.text =  new Date(1980,0,1).toLocaleDateString(Qt.locale(),Locale.ShortFormat)

        var dataContainer = DeviceAccessor.controllerDataContainer;

        // birthdays already received before
        if(Object.keys(dataContainer.birthdayPlan).length !== 0)
        {
            addBirthdaysToModel()
        }
        else
        {
            DeviceAccessor.queryBirthdayPlan();
            dataContainer.birthdayPlanChanged.connect(addBirthdaysToModel);
        }

    }

    buttonAddEntry.onClicked: addEntry(textFieldFirstName.text,textFieldLastName.text,buttonBirthdate.text)

    buttonConfirm.onClicked: {
            var newBirthdayPlan = [];

            for(var i = 0; i < listView.model.count; i++)
            {
                var item = listView.model.get(i);
                var date =  new Date(Date.fromLocaleDateString(Qt.locale(),item.birthdate,Locale.ShortFormat));
                newBirthdayPlan.push({"ID":0, clientId:"","firstName":item.firstName,"name":item.lastName,"date":DateUtil.toShortISOString(date)})
            }
            DeviceAccessor.controllerDataContainer.birthdayPlan = newBirthdayPlan;
            DeviceAccessor.sendBirthdayTable(newBirthdayPlan);

    }

    function addBirthdaysToModel()
    {

        var dataContainer = DeviceAccessor.controllerDataContainer;
        //dataContainer.disconnect(addBirthdaysToModel);
        var birthdayPlan = dataContainer.birthdayPlan;


        for (var i = 0; i < birthdayPlan.length; i++){
            addEntry(birthdayPlan[i].firstName,birthdayPlan[i].name,new Date(birthdayPlan[i].date).toLocaleDateString(Qt.locale(),Locale.ShortFormat));
        }
    }

    // birthdate is the localized birthday string
    function addEntry(firstName,lastName,birthdate)
    {
        listView.model.append({"firstName" :firstName,
                                  "lastName":lastName,
                                  // date without year is nearly impossible to properly localize automatically
                                  "birthdate":birthdate})
    }


    DatePickerDialog
    {
        yearVisible: false
        button: buttonBirthdate
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
    }

}
