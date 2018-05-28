import QtQuick 2.0
import QtQuick.Controls 2.1


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

        function openWizard()
        {
            firstIntervalStartDialog.tumblerModel = range(0,24);
            firstIntervalStartDialog.open();

        }
        property alias firstIntervalStartDialog: firstIntervalStart



        TimeRangePicker
        {
            id : firstIntervalStart
            title : qsTr("First interval start")
            onAccepted: {


                console.log("current text: " + firstIntervalStart.hour);

                if(firstIntervalStart.hour + 10 > 24)
                {
                    firstIntervalEnd.tumblerModel = timePickerWizard.range(firstIntervalStart.hour,23)
                    .concat(timePickerWizard.range(0,firstIntervalStart.hour +10 -24));
                }
                else
                {
                    firstIntervalEnd.tumblerModel = timePickerWizard.range(firstIntervalStart.hour+1,
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

                var fullDay = timePickerWizard.range(0,24);
                if(!isSplitInterval)
                {
                    var upperHalf = timePickerWizard.range(end+2,24-1); // -1 because min interval length 1
                    var lowerHalf = timePickerWizard.range(0, start -3);
                    var modelData = upperHalf.concat(lowerHalf);
                    //secondIntervalStart.tumblerModel = modelData.sort(timePickerWizard.sortNumber);
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
                var arr = secondIntervalStart.tumblerModel.filter(function(item){
                    return item > secondIntervalStart.hour;  // FXIME does not work when wrap
                });
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

        function range(start, stop){
           if(start >= stop)
           {
               return [];
           }

          var a=[start], b=start;
          while(b<stop){b+=1;a.push(b)}
          return a;
        }

        function sortNumber(a,b) {
            return a - b;
        }


        function rangeWrap(start, stop){
          var a=[start], b=start;
          while(b<stop)
          {
              b+=1;
              b = b % 24;
              a.push(b)
          }
          return a;
        }

        // calculates the difference and wraps into 24 hour format
        function minusWrap(val1, val2)
        {
            var res = val1-val2;
            return res < 0 ?  24+res : res;
        }

        function plusWrap(val1,val2)
        {
            var res = val1 + val2;
            return res > 23 ? 0 +res-24 : res;
        }
    }
}

