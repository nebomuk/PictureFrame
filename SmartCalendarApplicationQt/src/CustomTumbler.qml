import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.3

// A Tumbler that draws horizontal lines above and below the curren item and uses transparency effects

Tumbler {





    // text formatting, the default method does nothing
    property var formatFunction : function(count,modelData) { return modelData;}

    anchors.horizontalCenter: parent.horizontalCenter
    id: myTumbler
    model: 12
    delegate: delegateComponent
    wrap: false

    Rectangle {
              anchors.horizontalCenter: myTumbler.horizontalCenter
              y: myTumbler.height * 0.4
              width: 40
              height: 1
              color: Material.accent
          }

          Rectangle {
              anchors.horizontalCenter: myTumbler.horizontalCenter
              y: myTumbler.height * 0.6
              width: 40
              height: 1
              color: Material.accent
          }

      Component {
          id: delegateComponent

          Label {
              text: Tumbler.tumbler.formatFunction(Tumbler.tumbler.count, modelData)
              opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
              horizontalAlignment: Text.AlignHCenter
              verticalAlignment: Text.AlignVCenter
              font.pixelSize: fontMetrics.font.pixelSize * 1.25


          }
      }

      FontMetrics {
          id: fontMetrics
      }
}

