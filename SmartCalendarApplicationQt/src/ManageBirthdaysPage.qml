import QtQuick 2.0
import QtQuick.Controls 2.3
import de.vitecvisual.core 1.0;
import "DateUtil.js" as DateUtil



ManageBirthdaysPageForm {

    Component.onCompleted: {

        buttonBirthdate.text =  DateUtil.toStringWithoutYear(new Date(1980,0,1))

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
            addEntry(birthdayPlan[i].firstName,birthdayPlan[i].name,DateUtil.toStringWithoutYear(new Date(birthdayPlan[i].date)));
        }

        sortModel()
    }

    // birthdate is the localized birthday string
    function addEntry(firstName,lastName,birthdate)
    {
        listView.model.append({"firstName" :firstName,
                                  "lastName":lastName,
                                  // date without year is nearly impossible to properly localize automatically
                                  "birthdate":birthdate})

        sortModel()


    }

    function sortModel()
    {
        var listModel = listView.model;
        var n;
        var i;
        for (n=0; n < listModel.count; n++)
            for (i=n+1; i < listModel.count; i++)
            {
                if (compareLastAndFirstNames(listModel.get(n).lastName,listModel.get(i).lastName,
                                             listModel.get(n).firstName,listModel.get(i).firstName))
                {
                    listModel.move(i, n, 1);
                    n=0;
                }
            }
    }

    function compareLastAndFirstNames(lastName1,lastName2,firstName1,firstName2)
    {
        if(lastName1 === lastName2)
        {
            return firstName1 > firstName2;
        }
        else
        {
            return lastName1 > lastName2;
        }
    }



    DatePickerDialog
    {
        yearVisible: false
        button: buttonBirthdate
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
    }

}
