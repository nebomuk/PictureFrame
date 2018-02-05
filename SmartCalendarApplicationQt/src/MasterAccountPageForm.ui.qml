import QtQuick 2.10
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Master Account")

    Text {
           id: textId
           font.pixelSize: 36
           font.letterSpacing: 0.9
           color: "red"
           text: "Hello World"
           anchors.horizontalCenter: parent.horizontalCenter

           layer.enabled: true
           layer.effect: DropShadow {
               verticalOffset: 2
               color: "#80000000"
               radius: 2
               samples: 3
           }
       }
}
