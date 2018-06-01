import QtQuick 2.0
import QtQuick.Controls 2.1

import "ArrayUtil.js" as ArrayUtil


Item
{
    id : timeRangeWizard
    
    width: firstIntervalStart.width
    height: firstIntervalStart.height
    
    function open()
    {
        firstIntervalStartDialog.tumblerModel = ArrayUtil.range(0,24);
        firstIntervalStartDialog.open();
        
    }

    signal accepted(int firstStart,int firstEnd,int secondStart,int secondEnd);

    signal rejected();

    property alias firstIntervalStartDialog: firstIntervalStart
    
    
    
    HourPicker
    {
        id : firstIntervalStart
        title : qsTr("First interval start")
        onRejected: timeRangeWizard.rejected();
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
    HourPicker
    {
        id : firstIntervalEnd
        title : qsTr("First interval end")
        onRejected: timeRangeWizard.rejected();

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
    
    HourPicker
    {
        id : secondIntervalStart
        title : qsTr("Second interval start")
        onRejected: timeRangeWizard.rejected();

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
    
    HourPicker
    {
        id : secondIntervalEnd
        title : qsTr("Second interval end")
        onRejected: timeRangeWizard.rejected();

        onAccepted: {
            // final result

            console.info("TimeRangeWizard accepted(firstStart: " + firstIntervalStart.hour + ", firstEnd: " + firstIntervalEnd.hour +
                         ", secondStart: " + secondIntervalStart.hour + ", secondEnd: " + secondIntervalEnd.hour + ")");
            timeRangeWizard.accepted(firstIntervalStart.hour,firstIntervalEnd.hour,secondIntervalStart.hour,secondIntervalEnd.hour);
            
        }
        
    }
    
    
    
}
