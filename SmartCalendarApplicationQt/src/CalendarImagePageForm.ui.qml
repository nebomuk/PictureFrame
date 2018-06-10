import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    padding : 20

    title: qsTr("Calendar Image")
    property alias comboBoxoption: comboBoxoption
    property alias comboBoxTimeView: comboBoxTimeView
    property alias comboBoxDesign: comboBoxDesign
    property alias comboBoxWeekType: comboBoxWeekType

    property alias spinBoxAdditionalNumberOfDays: spinBoxAdditionalNumberOfDays

    property alias spinBoxStartTime: spinBoxStartTime
    property alias spinBoxEndTime: spinBoxEndTime
    property alias buttonStartDate: buttonStartDate
    property alias comboBoxMonth: comboBoxMonth

    property bool isDayViewOption3: comboBoxTimeView.currentIndex === 0
                                    && comboBoxoption.currentIndex === 2

    property bool isWeekViewOption1: comboBoxTimeView.currentIndex === 1
                                     && comboBoxoption.currentIndex === 0
    property bool isWeekViewOption2: comboBoxTimeView.currentIndex === 1
                                     && comboBoxoption.currentIndex === 1
    property bool isWeekViewOption3: comboBoxTimeView.currentIndex === 1
                                     && comboBoxoption.currentIndex === 2

    property bool isMonthViewOption1: comboBoxTimeView.currentIndex === 2
                                      && comboBoxoption.currentIndex === 0
    property bool isMonthViewOption2: comboBoxTimeView.currentIndex === 2
                                      && comboBoxoption.currentIndex === 1

    property bool isDayOrWeek: comboBoxTimeView.currentIndex === 0
                               || comboBoxTimeView.currentIndex === 1

    GridLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        columns: 2
        rows: 6
        rowSpacing: 5
        columnSpacing: 5

        Label {
            text: "Appearance"
        }

        StringXmlResourceComboBox {
            attributeName: "timeViewSpinnerArray"
            id: comboBoxTimeView
            Layout.preferredWidth: 200
        }

        Label {
            text: qsTr("Option")
        }

        StringXmlResourceComboBox {
            id: comboBoxoption
            Layout.preferredWidth: 200
            attributeName: isDayOrWeek ? "calendarFormatViewSpinnerArrayWithThreeOptions" : "calendarFormatViewSpinnerArrayWithTwoOptions"
        }

        Label {
            text: qsTr("Start")
            id: labelStart
            visible: isDayViewOption3
        }

        RowLayout
        {
        SpinBox {
            visible: isDayViewOption3
            id: spinBoxStartTime
            up.indicator.enabled: spinBoxEndTime.value > value +4
            down.indicator.enabled: spinBoxEndTime.value - value < 12
            from: 0
            to: 24
            value: 6
            Layout.preferredWidth: 150
        }

        Label {
            text: qsTr("In 24 hours")
            visible: isDayViewOption3
        }
        }

        Label {
            text: qsTr("End")
            visible: isDayViewOption3
        }

        RowLayout
        {
        SpinBox {
            visible: isDayViewOption3
            id: spinBoxEndTime
            down.indicator.enabled: spinBoxStartTime.value  +4 < value
            up.indicator.enabled: value - spinBoxStartTime.value < 12
            from: 4
            to: 24
            value: 12
            Layout.preferredWidth: 150
        }

        Label {
            text: qsTr("In 24 hours")
            visible: isDayViewOption3
        }
        }

        Label {
            text: qsTr("Appearance")
            visible: isWeekViewOption1
        }

        ExtendedComboBox {
            visible: isWeekViewOption1
            id: comboBoxWeekType
            Layout.preferredWidth: 200
            model: [qsTr("Work Week"), qsTr("Week")]
        }

        Label {
            visible: isWeekViewOption3 || isMonthViewOption2
            text: qsTr("Time Interval")
            Layout.columnSpan: isWeekViewOption3 ? 2 : 1 // displayed as heading for week, but on the right for month
        }

        Label {
            visible: isWeekViewOption3
            text: qsTr("Start Date")
        }

        Button {
            visible: isWeekViewOption3
            id: buttonStartDate
        }

        Label {
            visible: isWeekViewOption2 || isWeekViewOption3
            text: qsTr("Additional number of days")
            Layout.preferredWidth: 100
            wrapMode: Text.WordWrap
        }

        SpinBox {
            id: spinBoxAdditionalNumberOfDays
            visible: isWeekViewOption2 || isWeekViewOption3
            from: 0
            to: 6
        }

        ExtendedComboBox {
            visible: isMonthViewOption2
            id: comboBoxMonth
            Layout.minimumWidth: 0
            Layout.preferredWidth: 200
            model: ListModel {
            }
            textRole: "name"
        }

        Label {
            text: qsTr("Design")
        }

        ComboBox {
            id: comboBoxDesign
            Layout.preferredWidth: 200
        }
    }
}
