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

    property alias buttonWorkingDayStart2  : buttonWorkingDayStart2
    property alias buttonWorkingDayEnd2    : buttonWorkingDayEnd2
    property alias buttonWeekendStart2     : buttonWeekendStart2
    property alias buttonWeekendEnd2       : buttonWeekendEnd2

    property alias buttonConfirm : buttonConfirm


    property alias spinBoxfixedDisplayBrightness : spinBoxfixedDisplayBrightness
    property alias comboBoxdisplaySensibilityLevel : comboBoxdisplaySensibilityLevel

    property alias radioButtonautomatedDisplayBrightness : radioButtonautomatedDisplayBrightness
    property alias radioButtonpermanentActiveDisplay :  radioButtonpermanentActiveDisplay

    GridLayout {
        x: 51
        width: 402
        height: 507
        anchors.top: parent.top
        anchors.topMargin: 33
        columnSpacing: 10
        rowSpacing: 10
        columns: 2
        rows: 11

        Label {
            Layout.columnSpan: 2
            id: label
            text: qsTr("Display Brightness")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        ButtonGroup { id: displayBrightnessGroup }

        RadioButton {
            id: radioButtonfixedDisplayBrightness
            text: qsTr("Fixed")
            ButtonGroup.group: displayBrightnessGroup
        }

        SpinBox {
            id : spinBoxfixedDisplayBrightness
            Layout.fillWidth: true
            enabled: radioButtonfixedDisplayBrightness.checked
        }

        RadioButton {
            id : radioButtonautomatedDisplayBrightness
            Layout.columnSpan: 2
            text: qsTr("Automatic")
            ButtonGroup.group: displayBrightnessGroup
        }

        Label {
            Layout.columnSpan: 2
            id: label1
            text: qsTr("Display activation")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        ButtonGroup { id: activationGroup }


        RadioButton {

            id: radioButtondisplaySensibilityLevel
            text: qsTr("Sensibility")
            ButtonGroup.group: activationGroup
        }

        ComboBox {
            id : comboBoxdisplaySensibilityLevel
            model: [qsTr("Low"), qsTr("Average"), qsTr("High")]
            Layout.fillWidth: true
            enabled: radioButtondisplaySensibilityLevel.checked
        }

        RadioButton {
            id : radioButtonpermanentActiveDisplay
            Layout.columnSpan: 2
            text: qsTr("Permamently Activated")
            ButtonGroup.group: activationGroup
        }

        Label {
            Layout.columnSpan: 2
            id: label2
            text: qsTr("Screen activation")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        CheckBox {
            Layout.columnSpan: 2
            id: radioButtonWorkingDay
            text: qsTr("Working Day")
        }

        RowLayout {
            Layout.fillWidth: false
            enabled: radioButtonWorkingDay.checked
            Button {
                id: buttonWorkingDayStart
            }

            Button {
                id: buttonWorkingDayEnd
            }
            Button {
                id: buttonWorkingDayStart2
            }

            Button {
                id: buttonWorkingDayEnd2
            }
        }

        CheckBox {
            Layout.columnSpan: 2

            id: radioButtonWeekend
            text: qsTr("Weekend")
        }

        RowLayout {
            enabled: radioButtonWeekend.checked
            Button {
                id: buttonWeekendStart
            }

            Button {
                id: buttonWeekendEnd
            }
            Button {
                id: buttonWeekendStart2
            }

            Button {
                id: buttonWeekendEnd2
            }
        }
    }

    Button {
        id: buttonConfirm
        text: qsTr("Confirm")
        anchors.right: parent.right
        anchors.rightMargin: 80
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
    }
}
