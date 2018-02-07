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
            id: textField
            text: qsTr("Text Field")
        }

        TextField {
            id: textField1
            text: qsTr("Text Field")
        }
    }



    Button {
        id: button
        text: qsTr("Confirm")
        anchors.right: parent.right
        anchors.rightMargin: 80
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
    }


}
