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
    // pick via gallery for android see
    // https://forum.qt.io/topic/66324/qt-android-image-picker-issue-with-android-5-5-1/3
    // smart calendar needs the raw jpg bytes

    // sends json to CalendarMainPage
    signal finished(var formData);

    property url currentPictureFilePath

    onCurrentPictureFilePathChanged: {
        image.source = currentPictureFilePath;
    }

    buttonConfirm.onClicked: {

        var formData = {};
        // combo box option shows a different user string from what should be sent via json

        // TODO convert to byte array
        formData.imageByteArray = currentPictureFilePath
        finished(formData)

    }

    Component.onCompleted:
    {
//        if(Qt.platform.os === "android")
//        {
//            AndroidHelper.imagePathRetrieved.connect(function()
//            {
//                console.log("Android image path" + imagePath);
//                currentPictureFilePath = imagePath;
//            });
//        }
    }




    buttonChoosePicture.onClicked: {

//        if(Qt.platform.os === "android")
//        {
//            AndroidHelper.openImagePicker();
//        }
//        else

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


