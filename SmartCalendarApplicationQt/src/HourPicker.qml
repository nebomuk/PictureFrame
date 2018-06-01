import QtQuick 2.0
import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

Dialog {


    standardButtons: Dialog.Cancel | Dialog.Ok

    property variant tumblerModel : 24

    property string currentText: hoursTumbler.currentItem !== null ? hoursTumbler.currentItem.text : ""

    property int hour : currentText.length > 0 ? parseInt(currentText.substring(0,currentText.indexOf(":")),10) : 0

    contentItem :
    Rectangle{

        CustomTumbler
         {
             id : hoursTumbler

             model:  tumblerModel
             formatFunction : function formatText(count, modelData) {
                 var data = count === 12 ? modelData + 1 : modelData;
                 return data + ":00";
             }
         }
    }



}
