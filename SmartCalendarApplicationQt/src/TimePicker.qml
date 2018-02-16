import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

Rectangle {

    property bool is24HourFormat : is24HourFormatLocale()

    property int hour : hoursTumbler.currentIndex * (is24HourFormat  ? 1 : 2)// returns hours always in 24 hour format
    property int minute : minutesTumbler.currentIndex

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

    Component {
        id: delegateComponent

        Label {
            text: formatText(Tumbler.tumbler.count, modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: fontMetrics.font.pixelSize * 1.25
        }
    }

        Row {
            id: row

            Tumbler {
                id: hoursTumbler
                model: is24HourFormat ? 24 : 12
                delegate: delegateComponent
            }

            Tumbler {
                id: minutesTumbler
                model: 60
                delegate: delegateComponent
            }

            Tumbler {
                id: amPmTumbler
                visible:  !is24HourFormat
                model: ["AM", "PM"]
                delegate: delegateComponent
            }
        }

}
