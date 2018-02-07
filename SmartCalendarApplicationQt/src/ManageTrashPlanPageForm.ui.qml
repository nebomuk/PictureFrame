import QtQuick 2.10
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Manage Trash Plan")

    Grid {
        id: grid
        x: 33
        y: 67
        width: 400
        height: 116
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        rows: 2
        columns: 2

        Label {
            id: label
            text: qsTr("Trash Type")
            fontSizeMode: Text.FixedSize
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignLeft
        }

        TextField {
            id: textField
            text: qsTr("Organic")
        }

        Label {
            id: label1
            text: qsTr("Date")
        }

        Label {
            id: label2
            text: qsTr("Date Picker Place Holder")
        }
    }

    Button {
        id: button
        text: qsTr("Confirm")
        anchors.top: grid.bottom
        anchors.topMargin: 22
        anchors.left: parent.left
        anchors.leftMargin: 57
    }

    Label {
        id: label3
        x: 163
        y: 367
        text: qsTr("Remove Trash Plan Entry")
    }

    ComboBox {
        id: comboBox
        x: 48
        y: 416
    }

    ComboBox {
        id: comboBox1
        x: 278
        y: 416
    }
}
