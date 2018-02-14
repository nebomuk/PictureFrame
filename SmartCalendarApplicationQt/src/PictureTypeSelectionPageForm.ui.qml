import QtQuick 2.4
import QtQuick.Controls 2.2

Page {
    width: 480
    height: 800

    id : page

    title: qsTr("Select Picture Type")

    ComboBox
    {
        anchors.top: parent.top
        anchors.topMargin: 108
        anchors.horizontalCenter: parent.horizontalCenter
        model: ["No category selected",
      "Calendar image",
      "Weather image",
      "News image",
      "Football image",
      "Cinema image",
      "Own image"]
    }


}
