import QtQuick 2.10
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Master Account")

    Grid {
        id: grid
        rows : 2
        columns : 2
        rowSpacing: 10
        columnSpacing: 20
        x: 93
        y: 185
        width: 276
        height: 188

        Label {
            id: label
            text: qsTr("Name")
        }

        Label {
            id: label1
            text: qsTr("Email-Address")
        }

        TextField {
            id: textFieldName
            placeholderText: qsTr( "Enter name" )
        }

        TextField {
            id: textFieldEmail
            placeholderText: qsTr( "Enter email" )

            validator: RegExpValidator { regExp:/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/ }
        }
    }

    Connections
    {
        target: confirmButton

    }

    Button {
        id: confirmButton
        x: 313
        y: 442
        text: qsTr("Confirm")
        anchors.right: parent.right
        anchors.rightMargin: 87
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 310
        enabled: textFieldName.text.length > 0 && textFieldEmail.length > 0
    }


}
