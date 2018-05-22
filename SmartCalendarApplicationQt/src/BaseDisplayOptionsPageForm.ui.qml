import QtQuick 2.4
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    padding: 20

    title: qsTr("Display Options")


    //    property alias buttonWorkingDayStart  : buttonWorkingDayStart
    //    property alias buttonWorkingDayEnd    : buttonWorkingDayEnd
    //    property alias buttonWeekendStart     : buttonWeekendStart
    //    property alias buttonWeekendEnd       : buttonWeekendEnd

    //    property alias buttonWorkingDayStart2  : buttonWorkingDayStart2
    //    property alias buttonWorkingDayEnd2    : buttonWorkingDayEnd2
    //    property alias buttonWeekendStart2     : buttonWeekendStart2
    //    property alias buttonWeekendEnd2       : buttonWeekendEnd2
    property alias spinBoxfixedDisplayBrightness: spinBoxfixedDisplayBrightness

    property alias radioButtonautomatedDisplayBrightness: radioButtonautomatedDisplayBrightness
    property alias radioButtonpermanentActiveDisplay: radioButtonpermanentActiveDisplay

    property alias checkBoxButtonWorkingDay: checkBoxButtonWorkingDay
    property alias checkBoxButtonWeekend: checkBoxButtonWeekend

    GridLayout {
        x: 51
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

        GridLayout {
            columns: 2
            rows: 2
            //visible: checkBoxButtonWorkingDay.checked
            RangeSlider {
                id: sliderWorkingDayFirst
                snapMode: RangeSlider.SnapAlways
                stepSize: 1
                from : 0
                to : 21
                second
                {
                    value : 12

                    onValueChanged : {
                        if(second.value === first.value)
                        {
                            setValues(first.value,first.value +1)
                        }

                        if(second.value - first.value > 10)
                        {
                            first.value = second.value -10;
                        }

                        if(sliderWorkingDaySecond.first.value < second.value+2)
                        {
                            sliderWorkingDaySecond.first.increase();
                            sliderWorkingDaySecond.second.increase();
                        }
                    }
                }

                first
                {
                    onValueChanged : {
                        if(second.value === first.value)
                        {
                            first.decrease();
                        }

                        if(second.value - first.value > 10)
                        {
                            second.value = first.value + 10;
                        }
                    }
                }
            }

            RangeSlider {
                    snapMode: RangeSlider.SnapAlways
                    stepSize: 1
                id: sliderWorkingDaySecond
                from : 3
                to : 24

                second
                {
                    value : 24
                    onValueChanged : {
                        if(second.value === first.value)
                        {
                            setValues(first.value,first.value +1)
                        }

                        if(second.value - first.value > 10)
                        {
                            first.value = second.value -10;
                        }
                    }
                }

                first
                {
                    value : 12
                    onValueChanged : {
                        if(second.value === first.value)
                        {
                            first.decrease();
                        }

                        if(second.value - first.value > 10)
                        {
                            second.value = first.value + 10;
                        }

                        if(sliderWorkingDayFirst.second.value > first.value -2)
                        {
                            sliderWorkingDayFirst.second.decrease();
                            sliderWorkingDayFirst.first.decrease();
                        }
                    }
                }
            }
            Label {
                text: Math.round(sliderWorkingDayFirst.first.value) + " - " + Math.round(sliderWorkingDayFirst.second.value)
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Label {
                text: Math.round(sliderWorkingDaySecond.first.value) + " - " + Math.round(sliderWorkingDaySecond.second.value)
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
        }

        Switch {
            Layout.columnSpan: 2

            id: checkBoxButtonWeekend
            text: qsTr("Weekend")
        }

        GridLayout {
            columns: 2
            rows: 2
            //visible: checkBoxButtonWeekend.checked
            RangeSlider {
                snapMode: RangeSlider.SnapAlways
                stepSize: 1
                id: sliderWeekendFirst
                from : 0
                to : 24
            }
            RangeSlider {
                snapMode: RangeSlider.SnapAlways
                stepSize: 1
                id: sliderWeekendSecond
                from : 0
                to : 24
            }
            Label {
                text: sliderWeekendFirst.first.value + " - " + sliderWeekendFirst.second.value
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
            Label {
                text: sliderWeekendSecond.first.value + " - " + sliderWeekendSecond.second.value
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
        }
    }
}
