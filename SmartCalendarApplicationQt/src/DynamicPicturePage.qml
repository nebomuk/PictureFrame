import QtQuick 2.0
import QtQuick 2.4
import QtQuick.Controls 2.3

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


    Component.onCompleted:
    {
        if(formData.imageByteArray !== undefined)
        {
            imageCropperItem.image.source = "data:image/jpg;base64," + formData.imageByteArray;
            imageCropperItem.draggableRect.visible = false; // TODO make visible again when existing picture changed
            // FIXME overrides source binding when existing picture changed
        }

    }

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
            // json can only handle base64, and the SmartCalendar java app uses Base64.decodeBase64 to decode this
            formData.imageByteArray = imageCropperItem.imageBase64String.substring("data:image/jpg;base64,".length);
            formData.imageTitle = textField.text
            finished(formData);
        }
    }

    addButton.onClicked:  imagePicker.popup(page,(parent.width - imagePicker.width) / 2,(parent.height - imagePicker.height) / 2);



    // do not move this out of this class because we need to show an empty image/last loaded image
    ImagePicker
    {
        id : imagePicker


        onFilePathChanged: {

           addButton.visible = false;
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


