import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQml.Models 2.2

Rectangle {

    property int maxYear : 2008
    property int minYear : 1908
    property int initialYear : 1980
    readonly  property int year : parseInt(yearTumbler.currentItem.text) // the year 1908 ..2008
    readonly  property int month: monthTumbler.currentIndex // starts with 0 for January .. 11 for December like javascript
    readonly  property int day : daysTumbler.currentIndex + 1 // the day of the month 1..31

    readonly  property date date : new Date(year,month -1 /*zero indexed*/,day)

    property bool yearVisible
    property bool dayVisible

    onInitialYearChanged: {
                updateYearModel();
        if(maxYear < initialYear)
        {
            maxYear = initialYear;
        }
        if(minYear > initialYear)
        {
            minYear = initialYear
        }
    }
    onMaxYearChanged: updateYearModel();
    onMinYearChanged: updateYearModel();


    function formatDaysInMonth(count, modelData)
    {
        return modelData + 1
    }

    function formatYear(count, modelData) {
        var data = count === maxYear ? modelData + 1 : modelData;
        return data.toString().length < 2 ? "0" + data : data;

    }

    function daysInMonth (month, year) {
        return new Date(year, month, 0).getDate();
    }

    function formatMonth(count, modelData)
    {
        var data = count === 12 ? modelData + 1 : modelData;
        return new Date((new Date()).getFullYear(),data,0).toLocaleDateString(Qt.locale(), "MMMM")
    }

    FontMetrics {
        id: fontMetrics
    }

    Component {
        id: daysInMonthDelegateComponent

        Label {
            text: formatDaysInMonth(Tumbler.tumbler.count, modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: fontMetrics.font.pixelSize * 1.25
        }
    }

    Component {
        id: monthDelegate

        Label {
            text: formatMonth(Tumbler.tumbler.count, modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: fontMetrics.font.pixelSize * 1.25
        }
    }

    Component {
        id: yearDelegate

        Label {
            text: formatYear(Tumbler.tumbler.count, modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: fontMetrics.font.pixelSize * 1.25
        }
    }


        Row {
            id: row

            Tumbler {
                width: 120
                id: monthTumbler
                model: 12
                delegate: monthDelegate
                wrap: false
            }

            Tumbler {
                visible: dayVisible
                id: daysTumbler
                model: daysInMonth(monthTumbler.currentIndex+1,(new Date()).getFullYear()) // days are zero indexed here
                delegate: daysInMonthDelegateComponent
                wrap: false

            }

            Tumbler {
                visible : yearVisible
                id: yearTumbler
                model: yearModel
                delegate: yearDelegate
            }

            ListModel
            {
                id : yearModel

                // initial model data
                Component.onCompleted: {
                    updateYearModel();
                }
            }

        }
        function updateYearModel()
        {
            yearModel.clear();

            for (var i = initialYear; i <= maxYear; ++i) {
                yearModel.append({value: i.toString()});
            }

            for (var j = minYear; j < initialYear; ++j) {
                yearModel.append({value: j.toString()});
            }
        }

}
