import QtQuick 2.7
import QtQuick.Controls 2.3


// a date picker dialog that writes the date on a button and can be opened using a button
Dialog {

    property Button button
    property int initialYear : 1980
    property int minYear : 1908
    property int maxYear : 2008

        id: dialogDatePicker
        standardButtons: Dialog.Cancel | Dialog.Ok

        contentItem : DatePickerForm
        {
            id : datePicker
            initialYear : dialogDatePicker.initialYear
            minYear : dialogDatePicker.minYear
            maxYear : dialogDatePicker.maxYear
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


