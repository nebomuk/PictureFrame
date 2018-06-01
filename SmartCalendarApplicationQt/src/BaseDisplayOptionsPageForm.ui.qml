import QtQuick 2.4
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    padding: 20

    title: qsTr("Display Options")

    property alias spinBoxfixedDisplayBrightness: spinBoxfixedDisplayBrightness

    property alias radioButtonautomatedDisplayBrightness: radioButtonautomatedDisplayBrightness
    property alias radioButtonpermanentActiveDisplay: radioButtonpermanentActiveDisplay

    property alias checkBoxButtonWorkingDay: checkBoxButtonWorkingDay
    property alias checkBoxButtonWeekend: checkBoxButtonWeekend

    property alias timeRangeWizard: timeRangeWizard

    property alias buttonChangeWorkingDay: buttonChangeWorkingDay
    property alias buttonChangeWeekend: buttonChangeWeekend

    property alias labelWorkingDay: labelWorkingDay

    property alias labelWeekend: labelWeekend


    ScrollView
    {
        anchors.fill: parent
        contentWidth: parent.width

        GridLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            columnSpacing: 10
            rowSpacing: 10
            columns: 2
            rows: 13

            Label {
                Layout.columnSpan: 2
                id: label
                text: qsTr("Display Brightness")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            // when auto, send 1 for auto, 0 for fixed,
            // when fixed, send 0 for auto, value for fixed
            ButtonGroup {
                id: displayBrightnessGroup
            }

            RadioButton {
                id: radioButtonfixedDisplayBrightness
                text: qsTr("Fixed")
                ButtonGroup.group: displayBrightnessGroup
            }

            SpinBox {
                id: spinBoxfixedDisplayBrightness
                enabled: radioButtonfixedDisplayBrightness.checked
                from: 10
                value: 10
                to: 100
                stepSize: 10
                Layout.preferredWidth: 150
            }

            RadioButton {
                id: radioButtonautomatedDisplayBrightness
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
            ButtonGroup {
                id: activationGroup
            }

            RadioButton {

                id: radioButtondisplaySensibilityLevel
                text: qsTr("Auto")
                Layout.columnSpan: 2
                ButtonGroup.group: activationGroup
            }

            RadioButton {
                id: radioButtonpermanentActiveDisplay
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

            Switch {
                Layout.columnSpan: 2
                id: checkBoxButtonWorkingDay
                text: qsTr("Working Day")
            }

            Button
            {
                id : buttonChangeWorkingDay
                visible: checkBoxButtonWorkingDay.checked
                text : qsTr("Change")
            }

            Label
            {
                visible: checkBoxButtonWorkingDay.checked
                id : labelWorkingDay
                text : ""
            }


            Switch {
                Layout.columnSpan: 2

                id: checkBoxButtonWeekend
                text: qsTr("Weekend")
            }

            Button
            {
                id : buttonChangeWeekend
                visible: checkBoxButtonWeekend.checked
                text : qsTr("Change")
            }

            Label
            {
                visible: checkBoxButtonWeekend.checked
                id : labelWeekend
                text : ""
            }
        }
    }

    TimeRangeWizard
    {
        id : timeRangeWizard
        anchors.centerIn: parent
    }
}
