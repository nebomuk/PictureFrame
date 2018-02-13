import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Define Persons")

    GridLayout {
        id: grid
        x: 76
        y: 134
        width: 354
        height: 294
        anchors.horizontalCenter: parent.horizontalCenter
        rowSpacing: 10
        columnSpacing: 10
        rows: 5
        columns: 3

        Item
        {
            // spacing
            Layout.fillWidth: true
        }


        Label
        {
            text: qsTr("Name")
        }

        Label
        {
            text : qsTr("Email")
        }


        CheckBox{
            id : checkBox
        }

        TextField
        {
            id : textFieldName
            placeholderText: qsTr("Name")
        }

        TextField
        {
            id : textFieldEmail
            placeholderText: qsTr("Email")
        }

        CheckBox {
            id: checkBox1
        }

        TextField {
            id: textFieldName1
            placeholderText: qsTr("Name")
        }

        TextField {
            id: textFieldEmail1
            placeholderText: qsTr("Email")
        }

        CheckBox {
            id: checkBox2
        }

        TextField {
            id: textFieldName2
            placeholderText: qsTr("Name")
        }

        TextField {
            id: textFieldEmail2
            placeholderText: qsTr("Email")
        }

        CheckBox {
            id: checkBox3
        }

        TextField {
            id: textFieldName3
            placeholderText: qsTr("Name")
        }

        TextField {
            id: textFieldEmail3
            placeholderText: qsTr("Email")
        }
    }


}
