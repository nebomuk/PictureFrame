import QtQuick 2.0
import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.3

import de.vitecvisual.native 1.0;

DynamicPicturePageForm {
    // TODO may use 1.0 FileDialog for ios but custom solution for android
    // https://stackoverflow.com/questions/33443114/photo-gallery-in-ios-and-android
    // requires info plist for ios
    // https://bugreports.qt.io/browse/QTBUG-59097
    // smart calendar needs the raw jpg bytes

    // sends json to CalendarMainPage
    signal finished(var formData);

    property var formData

    property url currentPictureFilePath

    onCurrentPictureFilePathChanged: {
        image.source = currentPictureFilePath;
    }

    function onDoneClicked() {

        var formData = {};
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
        request.open('GET', currentPictureFilePath, true)
        request.send(null)
    }

    function onImageLoadedIntoArrayBuffer(arrayBuffer)
    {
        formData.imageByteArray = currentPictureFilePath
        finished(formData)
    }

    Component.onCompleted:
    {
        if(Qt.platform.os === "android")
        {
            AndroidHelper.imagePathRetrieved.connect(function(imagePath)
            {
                console.log("Android image url" + imagePath);
                currentPictureFilePath = imagePath;
            });
        }

        buttonDone.clicked.connect(onDoneClicked);
    }




    buttonChoosePicture.onClicked: {

        if(Qt.platform.os === "android")
        {
            AndroidHelper.openImagePicker();
        }
        else
            fileDialog.open();

    }

    FileDialog // 1.3 file dialog for ios
    {
        id: fileDialog
        folder: shortcuts.pictures // will show native dialog

        onAccepted:
        {
            console.log("You chose: " + fileDialog.fileUrls)
            currentPictureFilePath = fileDialog.fileUrls[0];
        }
    }

}


