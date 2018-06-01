import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

Rectangle {

    property bool is24HourFormat : is24HourFormatLocale()

    property int initialHour : 0

    property int initialMinute : 0

    readonly  property int hour : hoursTumbler.currentIndex * (is24HourFormat  ? 1 : 2)// returns hours always in 24 hour format
    readonly  property int minute : minutesTumbler.currentIndex

    onInitialHourChanged: hoursTumbler.currentIndex = initialHour

    onInitialMinuteChanged: minutesTumbler.currentIndex = initialMinute

    function is24HourFormatLocale()
    {
        var localeString = new Date(2018, 01, 01, 20, 0, 0, 0).toLocaleTimeString(Qt.locale());
       return  localeString.indexOf("20") > -1 // check if it displays 20 hours or 8 PM
    }

    function formatText(count, modelData) {
        var data = count === 12 ? modelData + 1 : modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }

    FontMetrics {
        id: fontMetrics
    }

        Row {
            id: row

            CustomTumbler {
                formatFunction: formatText
                id: hoursTumbler
                model: is24HourFormat ? 24 : 12
            }

            CustomTumbler {
                formatFunction: formatText
                id: minutesTumbler
                model: 60
            }

            CustomTumbler {
                formatFunction: formatText
                id: amPmTumbler
                visible:  !is24HourFormat
                model: ["AM", "PM"]

            }
        }

}
