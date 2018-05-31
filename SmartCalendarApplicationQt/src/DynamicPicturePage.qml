import QtQuick 2.0
import QtQuick 2.4
import QtQuick.Controls 2.4

import de.vitecvisual.core 1.0;

import de.vitecvisual.native 1.0;

DynamicPicturePageForm {

    id : page

    // TODO may use 1.0 FileDialog for ios but custom solution for android
    // https://stackoverflow.com/questions/33443114/photo-gallery-in-ios-and-android
    // requires info plist for ios
    // https://bugreports.qt.io/browse/QTBUG-59097
    // smart calendar needs the raw jpg bytes

    // sends json to CalendarMainPage
    signal finished(var formData);

    property var formData



    Component.onDestruction: {
        // must set qt.qml.binding.removal.info=false on stackView.push
        LoggingFilter.setFilterRules("qt.qml.binding.removal.info=true");
    }

    function onDoneClicked() // for toolbar done icon
    {
        if(!imageCropperItem.cropStarted)
        {
            busyIndicator.visible = true;
            imageCropperItem.crop();
            busyIndicator.visible = false;

            textField.visible = true;
        }
        else
        {
            formData.imageByteArray = imageCropperItem.imageBase64String;
            formData.imageTitle = textField.text
            finished(formData);
            stackView.pop();
        }
    }


    ImagePicker
    {
        id : imagePicker

        Component.onCompleted:
        {
            popup(page,(parent.width - width) / 2,(parent.height - height) / 2);
        }

        onFilePathChanged: {

           imageCropperItem.visible = true;
           imageCropperItem.imageFilePath = filePath;

        }

    }

    function loadImageIntoArrayBuffer() {

                // combo box option shows a different user string from what should be sent via json

        // convert file to byte array
        var request = new XMLHttpRequest()
                   request.responseType = 'arraybuffer'
                   request.onreadystatechange = function() {
                           if (request.readyState === XMLHttpRequest.DONE) {
                               if (request.status == 200 || request.status == 0) {
                                   var arrayBuffer = request.response
                                   if (arrayBuffer) {
                                       onImageLoadedIntoArrayBuffer(arrayBuffer)
                                     }
                               } else {
                                   console.warn("Couldn't load magnitude data for bars.")
                               }
                               request = null
                           }
                       };
        request.open('GET', Qt.resolvedUrl(imagePicker.filePath), true) // TODO this has been changed from url to string
        request.send(null)
    }
}


