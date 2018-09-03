import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.XmlListModel 2.0

Dialog
{
    property alias tumbler: tumbler

    standardButtons: Dialog.Ok | Dialog.Cancel

    contentWidth: tumbler.width

          CustomTumbler {
              id : tumbler
              width: 200

              model:
                  XmlListModel {

                      source: "qrc:/Strings.xml"
                      query: "/resources/string-array[@name=\'imageSpinnerArray\']/item[position()>1]" // skip first string "No image Selected"

                      XmlRole { name: "text"; query: "string()" }
              }


          }

}

