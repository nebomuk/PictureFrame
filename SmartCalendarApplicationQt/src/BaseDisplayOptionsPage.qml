import QtQuick 2.4
import QtQuick.Controls 2.3
import QtQml 2.0

BaseDisplayOptionsPageForm {

    id: form



    Component{

        id : componentTimeDialog

        Dialog {

            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            id: timeDialog
            standardButtons: Dialog.Cancel | Dialog.Ok

            onVisibleChanged: if(!visible) destroy(1)

            contentItem : TimePicker
            {

            }
        }
    }

    function showTimeDialog(dateButton)
    {
        var timeDialogObject = componentTimeDialog.createObject(form)
        var timePicker = timeDialogObject.contentItem;

        // FIXME something undefined
//        if(dateButton.text.length > 0)
//        {
//            var date = Date.fromLocaleTimeString(Qt.locale(),dateButton.text,Locale.ShortFormat)
//            timePicker.hour = date.hours;
//            timePicker.minute = date.minutes;
//        }

        timeDialogObject.accepted.connect(function(){
                           var timePicker = timeDialogObject.contentItem;
                           dateButton.text =
                           new Date(2000,0,1,timePicker.hour,timePicker.minute).toLocaleTimeString(Qt.locale(),Locale.ShortFormat)
                        })
        timeDialogObject.visible = true
    }


    Connections {

        target: buttonWorkingDayStart

        onClicked  : showTimeDialog(buttonWorkingDayStart)
    }


    Connections {

        target : buttonWorkingDayEnd

        onClicked   : showTimeDialog(buttonWorkingDayEnd)
        }

    Connections {

        target : buttonWeekendStart

        onClicked     : showTimeDialog(buttonWeekendStart)
        }

    Connections {

        target : buttonWeekendEnd

        onClicked  : showTimeDialog(buttonWeekendEnd)

        }

}
