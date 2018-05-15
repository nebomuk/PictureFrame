import QtQuick 2.7
import QtQuick.Controls 2.3
import "DateUtil.js" as DateUtil


// a date picker dialog that writes the date on a button and can be opened using a button
Dialog {

    property Button button
    property int initialYear : 1980
    property int minYear : 1908
    property int maxYear : 2008

    property bool yearVisible : true
    property bool dayVisible : true

        id: dialogDatePicker
        standardButtons: Dialog.Cancel | Dialog.Ok

        contentItem : DatePickerForm
        {
            id : datePicker
            initialYear : dialogDatePicker.initialYear
            minYear : dialogDatePicker.minYear
            maxYear : dialogDatePicker.maxYear
            yearVisible : dialogDatePicker.yearVisible
            dayVisible : dialogDatePicker.dayVisible
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

                var date = new Date(datePicker.year,datePicker.month,datePicker.day);
                if(!yearVisible)
                {
                    button.text = DateUtil.toStringWithoutYear(date)
                }

                button.text = date.toLocaleDateString(Qt.locale(),Locale.ShortFormat)
            }
        }

}


