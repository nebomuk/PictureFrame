import QtQuick 2.4
import QtQuick.Controls 2.3

BaseDisplayOptionsPageForm {


    Dialog {

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        id: timeDialog
        standardButtons: Dialog.Cancel | Dialog.Ok

        contentItem : TimePicker
        {

        }



    }


    Connections {

        target: buttonWorkingDayStart

        onClicked  : timeDialog.open()
    }

    Connections {

        target : buttonWorkingDayEnd

        onClicked   : timeDialog.open()
        }

    Connections {

        target : buttonWeekendStart

        onClicked     : timeDialog.open()
        }

    Connections {

        target : buttonWeekendEnd

        onClicked  : timeDialog.open()

        }

}
