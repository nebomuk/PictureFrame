import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

// a page that provides a confirm button by default
Page {
    id: page

    property alias buttonConfirm: buttonConfirm

    // to get the model index in CalendarMainPage when the page is popped
    property int index

    default property alias innerObject : innercolumn.data

    padding: 20

    Item
    {
        id : innercolumn
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: buttonConfirm.top
    }


    ConfirmButton {
        id: buttonConfirm
    }

}
