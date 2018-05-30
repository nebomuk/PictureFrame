import QtQuick 2.0
import QtQuick.Controls 2.3
import de.vitecvisual.native 1.0;
import QtQuick.Dialogs 1.3
import de.vitecvisual.core 1.0;

// chooses a suitable image picker depending on the platform
// and



Menu {

    property string filePath : ""

        id: menu
        MenuItem {
            text: qsTr("Gallery")
            onTriggered: {
                if(Qt.platform.os === "android")
                {
                    gallery.openGallery();
                }
                fileDialog.open();
            }
        }
        MenuItem {
            text: qsTr("Camera")
            onTriggered: {
                if(Qt.platform.os === "android" || Qt.platform.os === "ios")
                {
                    capture.captureImage();
                }
                else
                {
                    console.debug("Camera not supported on non mobile platforms");
                }
            }
        }

        ImageGallery
        {
            id : gallery
            onImageFilePathChanged:  {

                console.debug("ImageGallery file: " + imageFilePath);
                menu.filePath = imageFilePath;
            }
        }

        ImageCapture
        {
            id : capture
            onImageFilePathChanged: {
                console.debug("ImageCapture file: " + imageFilePath);

                menu.filePath = imageFilePath;
            }
        }

        // 1.3 file dialog for ios
        FileDialog
        {
            id: fileDialog
            folder: shortcuts.pictures // will show native dialog on ios and desktop

            onAccepted:
            {
                console.debug("FileDialog file: " + fileDialog.fileUrls)
                menu.filePath = fileDialog.fileUrls[0].toString();
            }
        }



    }

