import QtQuick 2.0
import QtQuick.Controls 2.3
import de.vitecvisual.core 1.0;



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

    function addBirthdaysToModel()
    {

        var dataContainer = DeviceAccessor.controllerDataContainer;
        //dataContainer.disconnect(addBirthdaysToModel);
        var birthdayPlan = dataContainer.birthdayPlan;


        for (var i = 0; i < birthdayPlan.length; i++){
            addEntry(birthdayPlan[i].firstName,birthdayPlan[i].name,new Date(birthdayPlan[i].date).toLocaleDateString(Qt.locale(),Locale.ShortFormat));
        }
    }

    function addEntry(firstName,lastName,birthdate)
    {
        listView.model.append({"firstName" :firstName,
                                  "lastName":lastName,
                                  // date without year is nearly impossible to properly localize automatically
                                  "birthdate":birthdate})
    }

    Dialog {

            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            id: dialogDatePicker
            standardButtons: Dialog.Cancel | Dialog.Ok

            contentItem : DatePicker
            {
                id : datePicker
//                onYearChanged:  console.log("year: " + year)
//                onMonthChanged:  console.log("month: " + month)
//                onDayChanged:  console.log("day: " + day)

            }

        }

    Connections
    {
        target : buttonBirthdate
        onClicked : dialogDatePicker.open();

    }

    Connections
    {
        target : dialogDatePicker
        onAccepted : {

            buttonBirthdate.text = (new Date(datePicker.year,datePicker.month,datePicker.day))
            .toLocaleDateString(Qt.locale(),Locale.ShortFormat)
        }
    }

}
