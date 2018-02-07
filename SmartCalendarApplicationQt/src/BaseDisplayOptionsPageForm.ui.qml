import QtQuick 2.4
import QtQuick.Controls 2.3

Page {
    height: 800
    width: 480

    title: qsTr("Display Options")

    Label {
        id: label
        x: 186
        y: 23
        text: qsTr("Screen Brightness")
    }

    Grid {
        columns: 2
        rows: 2
        id: grid1
        x: 40
        y: 99
        width: 400
        height: 150

        RadioButton {
            id: radioButton
            text: qsTr("Fixed")
        }

        SpinBox {
            value: 80
            id: spinBox
        }

        RadioButton {
            id: radioButton1
            text: qsTr("Automatic")
        }
    }

    Label {
        id: label1
        x: 215
        y: 262
        text: qsTr("Screen activation")
    }

    Grid {
        id: grid2
        x: 31
        y: 314
        width: 400
        height: 150
        RadioButton {
            id: radioButton2
            text: qsTr("Sensibility")
        }

        ComboBox {
            model: ["Low", "Average", "High"]
            id: comboBox
        }

        RadioButton {
            id: radioButton3
            text: qsTr("Permament activation")
        }

        rows: 2
        columns: 2
    }

    Label {
        id: label2
        x: 215
        y: 499
        text: qsTr("Screen activation")
    }

    Grid {
        id: grid3
        x: 31
        y: 551
        width: 400
        height: 150
        CheckBox {
            id: radioButton4
            text: qsTr("Working Day")
        }

        Row
        {
            Tumbler {
                id: tumblerWorkingDayStart
                model: ["Low", "Average", "High"]
            }

            Tumbler {
                id: tumblerWorkingDayEnd
                model: ["Low", "Average", "High"]
            }

        }

        CheckBox {
            id: radioButton5
            text: qsTr("Weekend")
        }

        Row
        {
            Tumbler {
                id: tumblerWeekendStart
                model: ["Low", "Average", "High"]
            }

            Tumbler {
                id: tumblerWeekendEnd
                model: ["Low", "Average", "High"]
            }

        }

        rows: 2
        columns: 2
    }
}
