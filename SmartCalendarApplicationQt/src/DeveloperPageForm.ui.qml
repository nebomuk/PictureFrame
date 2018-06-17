import QtQuick 2.5
import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {

    property alias buttonRedirectLog: buttonRedirectLog

    property alias buttonLogView: buttonLogView

    GridLayout {
        columns: 1
        rows: 1

        Button
        {
            id : buttonRedirectLog
            text : "redirect log output to log view"
        }
        Button
        {
            enabled: false
            id : buttonLogView
            text : "show log"
        }

        TextField {
            id : textFieldProductPassword
            echoMode: TextInput.Password
            passwordCharacter: "*" // default character too large on some devices
        }

        PasswordStrengthMeter {
            password:  textFieldProductPassword.text
        }


        CheckBox
        {

        }


    }



}
