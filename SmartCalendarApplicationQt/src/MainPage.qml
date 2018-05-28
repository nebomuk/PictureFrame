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

                var fullDay = timePickerWizard.range(0,24);
                var partDay = fullDay.filter(function(item) {
                    if(firstIntervalStart.hour + 10 > 24)
                    {
                        return item <= firstIntervalStart.hour + 10 -24 || item >= firstIntervalStart.hour -10;
                    }
                    else if(firstIntervalStart.hour - 10 < 0)
                    {
                        return item <= firstIntervalStart.hour + 10 ||  item >= firstIntervalStart.hour -10 + 24;
                    }
                    else // item +-10 inside 0..24
                    {
                        return item  >= firstIntervalStart.hour-10 && item  <= firstIntervalStart.hour+10
                    }
                });



                firstIntervalEnd.tumblerModel = partDay.sort(timePickerWizard.sortNumber);
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
                    var upperHalf = timePickerWizard.range(end+2,24);
                    var lowerHalf = timePickerWizard.range(0, start -3);
                    var modelData = lowerHalf.concat(upperHalf);
                    secondIntervalStart.tumblerModel = modelData.sort(timePickerWizard.sortNumber);
                }
                else
                {
                    secondIntervalStart.tumblerModel = fullDay.filter(function(item){
                     return item <= start-2 && item >= end+2
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

            }

        }

        TimeRangePicker
        {
            id : secondIntervalEnd
            title : qsTr("Second interval end")

            onAccepted: {

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

