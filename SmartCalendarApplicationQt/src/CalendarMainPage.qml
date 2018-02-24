import QtQuick 2.0

CalendarMainPageForm
{

    Component.onCompleted:
    {
        listModel.append({"pictureType":qsTr("Nothing Selected"),"duration":0})
    }

}
