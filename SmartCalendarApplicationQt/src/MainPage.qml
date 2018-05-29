import QtQuick 2.0
import QtQuick.Controls 2.1

import "ArrayUtil.js" as ArrayUtil


MainPageForm {

    id : mainPage

    buttonDeviceSelection.onClicked:  {
        stackView.push("DeviceManagerPage.qml")
    }
    buttonBaseConfiguration.onClicked: {
        stackView.push("BaseOptionsPage.qml")
    }
    buttonCalendarView.onClicked: {
        stackView.push("CalendarMainPage.qml")
    }

    buttonImagePicker.onClicked: {
        stackView.push("DynamicPicturePage.qml");
    }

    buttonTimePicker.onClicked: {
       timePickerWizard.openWizard();
    }

    Item
    {
        id : timePickerWizard

        anchors.centerIn: parent
        width: firstIntervalStart.width
        height: firstIntervalStart.height

        function openWizard()
        {
            firstIntervalStartDialog.tumblerModel = ArrayUtil.range(0,24);
            firstIntervalStartDialog.open();

        }
        property alias firstIntervalStartDialog: firstIntervalStart



        TimeRangePicker
        {
            id : firstIntervalStart
            title : qsTr("First interval start")
            onAccepted: {

                if(firstIntervalStart.hour + 10 > 24)
                {
                    firstIntervalEnd.tumblerModel = ArrayUtil.range(firstIntervalStart.hour,23)
                    .concat(ArrayUtil.range(0,firstIntervalStart.hour +10 -24));
                }
                else
                {
                    firstIntervalEnd.tumblerModel = ArrayUtil.range(firstIntervalStart.hour+1,
                                                                           firstIntervalStart.hour + 10);
                }

                firstIntervalEnd.open();
            }
        }
        TimeRangePicker
        {
            id : firstIntervalEnd
            title : qsTr("First interval end")

            onAccepted: {

                var start = firstIntervalStart.hour;
                var end = firstIntervalEnd.hour;
                var isSplitInterval = start > 24 -10 && end < 0 + 10;

                var fullDay = ArrayUtil.range(0,24);
                if(!isSplitInterval)
                {
                    var upperHalf = ArrayUtil.range(end+2,24-1); // -1 because min interval length 1
                    var lowerHalf = ArrayUtil.range(0, start -3);
                    var modelData = upperHalf.concat(lowerHalf);
                    //secondIntervalStart.tumblerModel = modelData.sort(ArrayUtil.sortNumber);
                    secondIntervalStart.tumblerModel = modelData;
                }
                else
                {
                    secondIntervalStart.tumblerModel = fullDay.filter(function(item){
                     return item <= start-2-1 && item >= end+2 // -1 because min interval length 1
                    }
                    );
                }


                secondIntervalStart.open();
            }

        }

        TimeRangePicker
        {
            id : secondIntervalStart
            title : qsTr("Second interval start")

            onAccepted: {

                // FIXME do not show secondIntervalEnd if only 1h possible
                var index = secondIntervalStart.tumblerModel.indexOf(secondIntervalStart.hour);

                var arr = secondIntervalStart.tumblerModel;
                if(arr.length === 0)
                {
                    arr.push(secondIntervalStart.hour +1);
                }
                else
                {
                    var last = arr[arr.length -1];
                    if(last === 23)
                    {
                        arr.push(0);
                    }
                    else
                    {
                        arr.push(last +1);
                    }
                }

                arr = arr.slice(index+1);


                secondIntervalEnd.tumblerModel = arr;

                secondIntervalEnd.open();
            }

        }

        TimeRangePicker
        {
            id : secondIntervalEnd
            title : qsTr("Second interval end")

            onAccepted: {
                // final result

            }

        }



    }
}

