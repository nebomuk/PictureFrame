import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page



    title: qsTr("Master Account")

    property alias buttonConfirm: buttonConfirm

    property alias textFieldName: textFieldName

    property alias textFieldEmail: textFieldEmail

    GridLayout {
        id: grid
        rows : 2
        columns : 2
        rowSpacing: 10
        columnSpacing: 20
        x: 33
        y: 185
        width: 412
        height: 188
        anchors.horizontalCenter: parent.horizontalCenter

        Label {
            id: label
            text: qsTr("Name")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Label {
            id: label1
            text: qsTr("Email-Address")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        TextField {
            id: textFieldName
            placeholderText: qsTr( "Enter name" )
        }

        TextField {
            id: textFieldEmail
            Layout.fillHeight: false
            Layout.fillWidth: true
            placeholderText: qsTr( "Enter email" )

            validator: RegExpValidator { regExp:/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/ }
        }
    }

    Button {
        id: buttonConfirm
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
