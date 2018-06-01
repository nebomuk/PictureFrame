import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQml.Models 2.2
import QtQuick.Controls.Material 2.3

Rectangle {

    property int maxYear : 2008
    property int minYear : 1908
    property int initialYear : 1980
    readonly  property int year : yearTumbler.currentItem !== null ? parseInt(yearTumbler.currentItem.text,10) : 0 // the year 1908 ..2008
    readonly  property int month: monthTumbler.currentIndex // starts with 0 for January .. 11 for December like javascript
    readonly  property int day : daysTumbler.currentIndex + 1 // the day of the month 1..31

    // must be var, not date for binding to work
    /*treated as readonly*/ property var date

    property bool yearVisible
    property bool dayVisible

    Component.onCompleted:
    {
        date = Qt.binding(function() {
            return new Date(year,month  /*zero indexed*/,day);
        })
    }

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
        var monthName = new Date((new Date()).getFullYear(),data,0).toLocaleDateString(Qt.locale(), "MMMM")
        return monthName === "Jänner" ? "Januar" : monthName; // January should be Januar in all german locales
    }

        Row {
            id: row


            CustomTumbler {
                width: 120
                id: monthTumbler
                model: 12
                formatFunction:  formatMonth
                wrap: false
            }

            CustomTumbler {
                visible: dayVisible
                id: daysTumbler
                model: daysInMonth(monthTumbler.currentIndex+1,(new Date()).getFullYear()) // days are zero indexed here
                formatFunction: formatDaysInMonth
                wrap: false

            }

            CustomTumbler {
                visible : yearVisible
                id: yearTumbler
                model: yearModel
                formatFunction: formatYear
                wrap : false
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
