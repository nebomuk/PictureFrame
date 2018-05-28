import QtQuick 2.4
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

GridLayout {

    // calculates the difference and wraps into 24 hour format
    function minus(val1, val2)
    {
        var res = val1-val2;
        return res < 0 ?  24+res : res;
    }

    function plusWrap(val1,val2)
    {
        var res = val1 + val2;
        return res > 23 ? 0 +res-24 : res;
    }

    function wrapTo24(val)
    {
        if(val > 24)
            return 0 + val -24;
        else if(val < 0)
            return 24 + val;
        else
            return val;
    }

    function isInInterval(start,end,val)
    {
        var isSplitInterval = start > 24 -10 && end < 0 + 10;

        if(isSplitInterval)
        {
            return val >= start-2  && val <= 24 || val >= 0 && val <= end+2;
        }
        else if(!isSplitInterval)
        {
            return val >= start+2 && val <= end-2;
        }
    }



    function applyConstraintsA()
    {
        // minimum interval length 1h
        if(minus(comboBoxAEnd.currentIndex,comboBoxAStart.currentIndex) < 1)
                {
                    comboBoxAEnd.currentIndex = plusWrap(comboBoxAEnd.currentIndex,1);
                }
        // maximum interval length 10h
        else if(minus(comboBoxAEnd.currentIndex,comboBoxAStart.currentIndex) > 10)
        {
            comboBoxAEnd.currentIndex = plusWrap(comboBoxAStart.currentIndex,10);
        }


        // check overlap
//        if(isInInterval(comboBoxAStart.currentIndex,comboBoxAEnd.currentIndex, comboBoxBStart.currentIndex))
//        {
//            // check if split interval, e.g. from 23.00 to 2.00 hours
//            var AIsSplittedInterval = comboBoxAStart.currentIndex > 24 -10 && comboBoxAEnd.currentIndex < 0 + 10;
//            if(AIsSplittedInterval)
//            {
//                comboBoxBStart.currentIndex = comboBoxAEnd.currentIndex +2;
//                comboBoxBEnd.currentIndex = comboBoxBStart.currentIndex + 2;
//            }
//            else // interval inside 0.00h - 24.00h
//            {
//                comboBoxBStart.currentIndex = plusWrap(comboBoxAEnd.currentIndex,2);
//                comboBoxBEnd.currentIndex = plusWrap(comboBoxBStart.currentIndex,2);
//            }
//        }

    }
    
    ComboBox
    {
        id: comboBoxAStart
        model : 24
        onCurrentIndexChanged: {
            applyConstraintsA();
        }
    }
    
    ComboBox
    {
        id:comboBoxAEnd
        model : 24
        onCurrentIndexChanged: {
            applyConstraintsA();
        }
    }
    
    ComboBox
    {
        id : comboBoxBStart
        model : 24
        onCurrentIndexChanged: {

        }
    }
    
    ComboBox
    {

        id : comboBoxBEnd
        model : 24
        onCurrentIndexChanged: {

        }

    }
    
    Label {
        text: comboBoxAStart.value + " - " + comboBoxAEnd.value
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    }
    Label {
        text: comboBoxBStart.value + " - " + comboBoxBEnd.value
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    }
}
