import QtQuick 2.0
import QtQuick.Controls 2.3

// a simple button that places itself in the lower right corner
Button {
    id: buttonConfirm
    text: qsTr("Confirm")
    anchors.right: parent.right
    anchors.rightMargin: 40
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 40
}
