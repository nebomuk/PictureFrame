import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.XmlListModel 2.0

Dialog
{
    property alias tumbler: tumbler

    standardButtons: Dialog.Ok | Dialog.Cancel

    contentWidth: tumbler.width

    FontMetrics {
              id: fontMetrics
          }

          Tumbler {
              id : tumbler
              width: 200

              model:
                  XmlListModel {

                      source: "qrc:/Strings.xml"
                      query: "/resources/string-array[@name=\'imageSpinnerArray\']/item[position()>1]" // skip first string "No image Selected"

                      XmlRole { name: "text"; query: "string()" }
              }

              delegate: Label {
                  text: modelData
                  opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
                  horizontalAlignment: Text.AlignHCenter
                  verticalAlignment: Text.AlignVCenter
                  font.pixelSize: fontMetrics.font.pixelSize * 1.25
              }
          }

}

