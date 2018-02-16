import QtQuick 2.4
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page
    height: 800
    width: 480

    title: qsTr("Display Options")

    property alias buttonWorkingDayStart  : buttonWorkingDayStart

    property alias buttonWorkingDayEnd    : buttonWorkingDayEnd

    property alias buttonWeekendStart     : buttonWeekendStart

    property alias buttonWeekendEnd       : buttonWeekendEnd


    GridLayout {
        x: 51
        width: 402
        height: 507
        anchors.top: parent.top
        anchors.topMargin: 33
        columnSpacing: 10
        rowSpacing: 10
        columns: 2
        rows: 9

        Label {
            Layout.columnSpan: 2
            id: label
            text: qsTr("Display Brightness")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        RadioButton {
            id: radioButtonScreenBrightnessFixed
            text: qsTr("Fixed")
        }

        SpinBox {
            enabled: radioButtonScreenBrightnessFixed.checked
            value: 80
            id: spinBox
        }

        RadioButton {
            Layout.columnSpan: 2
            id: radioButtonScreenBrightnessAutomatic
            text: qsTr("Automatic")
        }

        Label {
            Layout.columnSpan: 2
            id: label1
            text: qsTr("Display activation")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        RadioButton {
            id: radioButtonSensibility
            text: qsTr("Sensibility")
        }

        ComboBox {
            model: [qsTr("Low"), qsTr("Average"), qsTr("High")]
            id: comboBoxSensibility
            enabled: radioButtonSensibility.checked
        }

        RadioButton {
            Layout.columnSpan: 2
            id: radioButtonPermanentlyActivated
            text: qsTr("Permamently Activated")
        }

        Label {
            Layout.columnSpan: 2
            id: label2
            text: qsTr("Screen activation")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        CheckBox {
            id: radioButton4
            text: qsTr("Working Day")
        }

        RowLayout {
            Button {
                id: buttonWorkingDayStart
            }

            Button {
                id: buttonWorkingDayEnd
            }
        }

        CheckBox {
            id: radioButton5
            text: qsTr("Weekend")
        }

        RowLayout {
            Button {
                id: buttonWeekendStart
            }

            Button {
                id: buttonWeekendEnd
            }
        }
    }
}
