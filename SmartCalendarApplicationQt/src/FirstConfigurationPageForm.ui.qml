import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Page {
    id: page

    

    title: qsTr("Configure New Device")



    property alias textFieldDeviceName: textFieldDeviceName

    property alias textFieldSsid: textFieldSsid

    property alias textFieldPassword : textFieldPassword

    property alias buttonConfirm: confirmButton

    GridLayout {
        id: grid
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        rowSpacing: 10
        columnSpacing: 10
        rows: 3
        columns: 2

        Label {

            id: label
            text: qsTr("Device Name")
        }

        TextField {
            id: textFieldDeviceName
        }

        Label {
            id: label1
            text: qsTr("SSID (Network Name)")
        }

        TextField {
            id: textFieldSsid
        }

        Label {
            id: label2
            text: qsTr("Password")
        }

        TextField {
            id: textFieldPassword
            echoMode: TextInput.Password

        }
    }

    Button {
        id: confirmButton
        x: 35
        y: 268
        text: qsTr("Confirm")
        enabled: textFieldPassword.text.length > 0 && textFieldSsid.text.length > 0 && textFieldDeviceName.text.length > 0
    }
}
