import QtQuick 2.4
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    padding: 20

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

    property alias radioButtonautomatedDisplayBrightness : radioButtonautomatedDisplayBrightness
    property alias radioButtonpermanentActiveDisplay :  radioButtonpermanentActiveDisplay

    property alias checkBoxButtonWorkingDay: checkBoxButtonWorkingDay
    property alias checkBoxButtonWeekend :  checkBoxButtonWeekend


    GridLayout {
        x: 51
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
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

        // when auto, send 1 for auto, 0 for fixed,
        // when fixed, send 0 for auto, value for fixed
        ButtonGroup { id: displayBrightnessGroup }

        RadioButton {
            id: radioButtonfixedDisplayBrightness
            text: qsTr("Fixed")
            ButtonGroup.group: displayBrightnessGroup
        }

        SpinBox {
            id : spinBoxfixedDisplayBrightness
            enabled: radioButtonfixedDisplayBrightness.checked
            from: 10
            value: 10
            to: 100
            stepSize: 10
        }

        RadioButton {
            id : radioButtonautomatedDisplayBrightness
            Layout.columnSpan: 2
            text: qsTr("Auto")
            ButtonGroup.group: displayBrightnessGroup
        }

        Label {
            Layout.columnSpan: 2
            id: label1
            text: qsTr("Display activation")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        // checked radio button is 1, the other one is 0
        ButtonGroup { id: activationGroup }


        RadioButton {

            id: radioButtondisplaySensibilityLevel
            text: qsTr("Auto")
            Layout.columnSpan: 2
            ButtonGroup.group: activationGroup
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
            id: checkBoxButtonWorkingDay
            text: qsTr("Working Day")
        }

        RowLayout {
            Layout.fillWidth: false
            visible: checkBoxButtonWorkingDay.checked
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

            id: checkBoxButtonWeekend
            text: qsTr("Weekend")
        }

        RowLayout {
            visible: checkBoxButtonWeekend.checked
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
