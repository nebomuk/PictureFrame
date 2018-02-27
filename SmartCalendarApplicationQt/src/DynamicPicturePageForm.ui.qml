import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ConfirmationPage {
    id: page

    property alias buttonChoosePicture: buttonChoosePicture
    property alias image: image

    Button
    {
        anchors.top : parent.top
        id : buttonChoosePicture
        text : qsTr("Choose Picture");
    }

//    GridLayout
//    {
//        rows : 2
//        columns: 1
//        rowSpacing: 5
//        columnSpacing: 5

//        anchors.top : parent.top
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.bottom: buttonConfirm.top


        Image {
            anchors.top : buttonChoosePicture.bottom
            anchors.bottom: buttonConfirm.top
            width : parent.width // only thing which works
            id: image
            asynchronous : true
            fillMode :  Image.PreserveAspectFit
            clip: true
        }


//    }



    

    title: qsTr("Dynamic Picture")
}
