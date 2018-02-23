import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Dialog {
    id: dialog
    title: "Title"
    standardButtons: Dialog.Ok | Dialog.Cancel

    property alias textFieldName : textFieldName

    property alias textFieldEmail: textFieldEmail

    contentWidth: view.width

    GridLayout
    {
        id : view

        width: 250
        height: 114
        rowSpacing: 10
        columnSpacing: 10
        rows : 2
        columns : 2

        Label
        {
            text : qsTr("Name")
        }

        TextField
        {
            id : textFieldName
            Layout.fillWidth: true
        }


        Label
        {
            text : qsTr("Email")
        }
        TextField
        {
            id : textFieldEmail
            Layout.fillWidth: true

        }

    }
}
