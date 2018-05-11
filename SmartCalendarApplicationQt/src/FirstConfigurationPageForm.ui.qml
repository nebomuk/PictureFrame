import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Page {
    id: page

    

    title: qsTr("Configure New Device")



    property alias textFieldProductName: textFieldProductName

    property alias textFieldSsid: textFieldSsid

    property alias textFieldPassword : textFieldWifiPassword

    property alias textFieldProductPassword: textFieldProductPassword

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
            text: qsTr("Device Name")
        }

        TextField {
            id: textFieldProductName
        }

        Label
        {
            text : qsTr("Product Password")
        }

        TextField {
            id : textFieldProductPassword
        }

        Label {
            text: qsTr("SSID (Network Name)")
        }

        TextField {
            id: textFieldSsid
        }

        Label {
            text: qsTr("Wifi Password")
        }

        TextField {
            id: textFieldWifiPassword
            echoMode: TextInput.Password

        }
    }

    Button {
        id: confirmButton
        x: 35
        y: 268
        text: qsTr("Confirm")
        enabled: textFieldWifiPassword.text.length > 0 && textFieldSsid.text.length > 0 && textFieldProductName.text.length > 0
    }
}
