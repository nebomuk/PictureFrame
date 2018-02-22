import QtQuick 2.7
import QtQuick.Controls 2.3


// a date picker dialog that writes the date on a button and can be opened using a button
Dialog {

    property Button button

        id: dialogDatePicker
        standardButtons: Dialog.Cancel | Dialog.Ok

        contentItem : DatePickerForm
        {
            id : datePicker
        }

        Connections
        {
            target : button
            onClicked : dialogDatePicker.open();

        }

        Connections
        {
            target : dialogDatePicker
            onAccepted : {

                button.text = (new Date(datePicker.year,datePicker.month,datePicker.day))
                .toLocaleDateString(Qt.locale(),Locale.ShortFormat)
            }
        }

}


