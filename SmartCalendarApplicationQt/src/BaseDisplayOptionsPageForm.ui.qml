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

    property alias buttonConfirm : buttonConfirm


    property int fixedDisplayBrightness
    property int displaySensibilityLevel

    property bool automatedDisplayBrightness
    property bool permanentActiveDisplay

    property string firstIntervallWorkdayPowerSavingModeStartDate;
    property string firstIntervallWorkdayPowerSavingModeEndDate;
    property string secondIntervallWorkdayPowerSavingModeStartDate;
    property string secondIntervallWorkdayPowerSavingModeEndDate;
    property string firstIntervallWeekendPowerSavingModeStartDate;
    property string firstIntervallWeekendPowerSavingModeEndDate;
    property string secondIntervallWeekendPowerSavingModeStartDate;
    property string secondIntervallWeekendPowerSavingModeEndDate;


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

        ButtonGroup { id: displayBrightnessGroup }

        RadioButton {
            id: radioButtonScreenBrightnessFixed
            text: qsTr("Fixed")
            ButtonGroup.group: displayBrightnessGroup
        }

        SpinBox {
            enabled: radioButtonScreenBrightnessFixed.checked
            value: fixedDisplayBrightness
        }

        RadioButton {
            Layout.columnSpan: 2
            checked : automatedDisplayBrightness
            id: radioButtonAutomatedDisplayBrightness
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

            id: radioButtonSensibility
            text: qsTr("Sensibility")
            ButtonGroup.group: activationGroup
        }

        ComboBox {
            model: [qsTr("Low"), qsTr("Average"), qsTr("High")]
            id: comboBoxSensibility
            enabled: radioButtonSensibility.checked
        }

        RadioButton {
            Layout.columnSpan: 2
            text: qsTr("Permamently Activated")
            checked:  permanentActiveDisplay
            ButtonGroup.group: activationGroup
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

    Button {
        id: buttonConfirm
        text: qsTr("Confirm")
        anchors.right: parent.right
        anchors.rightMargin: 80
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
    }
}
