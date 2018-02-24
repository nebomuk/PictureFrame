import QtQuick 2.4
import QtQuick.Controls 2.3

Page {

    

    id : page

    title: qsTr("Select Picture Type")

    StringXmlResourceComboBox
    {
        id : comboBoxPictureTypeSelection
        attributeName: "imageSpinnerArray"
    }

//    ComboBox
//    {
//        id : comboBox

//        width: 224
//        height: 48
//        anchors.top: parent.top
//        anchors.topMargin: 108
//        anchors.horizontalCenter: parent.horizontalCenter
//        textRole: "title"

//        // TODO this should be in the PictureTypeSelectionpage.qml component
//        Connections {

//        }


    }


}
