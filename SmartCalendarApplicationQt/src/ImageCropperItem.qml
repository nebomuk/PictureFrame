import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Dialogs 1.0
import QtMultimedia 5.8

import QtQuick.Controls 2.4
import de.vitecvisual.core 1.0;

Page {
    visible: true
    height: 480
    width:  800
    title: qsTr("Dynamic Picture")

    Button
    {
        z : 1
        text : "Choose picture"
       // onClicked: fileDialog.open();
       onClicked: AndroidImageCapture.captureImage();
    }

    Button
    {
        anchors.right: parent.right;
        z : 1
        text : "crop"
        onClicked: {
            ImageCropper.imageFileUrl = currentPictureFilePath
            var distX = Math.abs(img.paintedX - draggableRect.x);
            var distY = Math.abs(img.paintedY - draggableRect.y);

            if(sourceAspectRatio < targetAspectRatio)
            {
                var posX = scaleToWidth(distX);
                var posY = scaleToWidth(distY);
            }
            else
            {
                var posX = scaleToHeight(distX);
                var posY = scaleToHeight(distY);
            }

            var cropRect = Qt.rect(posX,posY,1024,600);
            img.source = "data:image/jpg;base64," + ImageCropper.crop(cropRect);
            draggableRect.visible = false;
        }


        function scaleToWidth(value)
        {
            return value * 1024.0 /img.paintedWidth;
        }

        function scaleToHeight(value)
        {
            return value * 600.0 /img.paintedHeight;
        }

        property real sourceAspectRatio : img.sourceSize.width / img.sourceSize.height;
        property real targetAspectRatio : 1024.0/600.0
    }




    property string currentPictureFilePath :  AndroidImageCapture.imageFilePath
    //property string currentPictureFilePath : "file:///home/taiko/Desktop/fettsack.jpg"

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

    Rectangle {

        anchors.fill: parent

        id: container
        border.color: "black"
        color: "transparent"

        property real inverseTargetAspectRatio: 600.0/1024.0
        property real paintedAspectRatio: img.paintedHeight/img.paintedWidth

        Image
        {
            property real distancePaintedXToX: (width - paintedWidth)/2.0
            property real distancePaintedYToY: (height - paintedHeight)/2.0
            property real paintedX : x + distancePaintedXToX
            property real paintedY: y  + distancePaintedYToY
            fillMode: Image.PreserveAspectFit
            id : img
            source: currentPictureFilePath
            anchors.fill: parent
        }
        Rectangle {
            anchors.fill: img
            color : "transparent"
            border.color: "blue"
        }

        // rect for panorama photos
        Rectangle {
            id: draggableRect
            width: {

                if(container.inverseTargetAspectRatio > container.paintedAspectRatio)
                {
                    return height/container.inverseTargetAspectRatio;
                }
                else
                {
                    return img.paintedWidth;
                }

            }
            height: {

                if(container.inverseTargetAspectRatio > container.paintedAspectRatio)
                {
                     return    img.paintedHeight;
                }
                else
                {
                    return container.inverseTargetAspectRatio*width;
                }
            }
            border.color: "red"
            border.width: 2
            color: "transparent"
            anchors.verticalCenter: container.inverseTargetAspectRatio > container.paintedAspectRatio ? parent.verticalCenter : undefined
            anchors.horizontalCenter: container.inverseTargetAspectRatio > container.paintedAspectRatio ?  undefined : parent.horizontalCenter
        }


        MouseArea {

            anchors.fill: parent
            drag.target: draggableRect
            drag.axis: container.inverseTargetAspectRatio > container.paintedAspectRatio ? Drag.XAxis : Drag.YAxis
            drag.minimumX: img.paintedX
            drag.maximumX: img.paintedX + img.paintedWidth -  draggableRect.width
            drag.minimumY: img.paintedY
            drag.maximumY: img.paintedY + img.paintedHeight -  draggableRect.height
        }
    }
}
