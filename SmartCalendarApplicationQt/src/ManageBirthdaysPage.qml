import QtQuick 2.0
import QtQuick.Controls 2.3


ManageBirthdaysPageForm {

    buttonBirthdate.text: new Date(1980,0,1).toLocaleDateString(Qt.locale(),Locale.ShortFormat)

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
