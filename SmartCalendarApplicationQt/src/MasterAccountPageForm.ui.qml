import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    title: qsTr("Master Account")

    property alias textFieldName: textFieldName

    property alias textFieldEmail: textFieldEmail

    GridLayout {
        id: grid
        rows : 2
        columns : 2
        rowSpacing: 10
        columnSpacing: 20
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

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
            inputMethodHints : Qt.ImhEmailCharactersOnly

            //validator: RegExpValidator { regExp:/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/ }
        }
    }
}
