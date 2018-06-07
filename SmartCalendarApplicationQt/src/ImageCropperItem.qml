import QtQuick 2.10
import QtQuick.Window 2.10

import QtQuick.Controls 2.3
import de.vitecvisual.core 1.0;

Item {

    property string title: qsTr("Crop Image") // for toolbar

    property string imageFilePath

    property alias image : img

    property string imageBase64String : ""

    property bool cropStarted: false

    property alias draggableRect: draggableRect

    function crop()
    {
        if(cropStarted)
        {
            console.debug("crop already started");
            return;
        }
        cropStarted = true;


        ImageCropper.imageFileUrl = imageFilePath
        var distX = Math.abs(img.paintedX - draggableRect.x);
        var distY = Math.abs(img.paintedY - draggableRect.y);

        var sourceAspectRatio = img.sourceSize.width / img.sourceSize.height;
        var targetAspectRatio = 1024.0/600.0

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
        imageBase64String = "data:image/jpg;base64," + ImageCropper.crop(cropRect);
        img.source = imageBase64String;
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




    Rectangle {

        anchors.fill: parent

        id: container
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
            source: imageFilePath
            anchors.fill: parent
        }

        // this is the cut mask rect
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
