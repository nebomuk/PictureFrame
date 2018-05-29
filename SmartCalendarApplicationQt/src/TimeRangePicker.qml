import QtQuick 2.0
import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.3



Dialog {


    standardButtons: Dialog.Cancel | Dialog.Ok

    property variant tumblerModel : 24

    property string currentText: hoursTumbler.currentItem != null ? hoursTumbler.currentItem.text : ""

    property int hour : currentText.length > 0 ? parseInt(currentText.substring(0,currentText.indexOf(":"))) : 0

    contentItem : Rectangle {

        FontMetrics {
            id: fontMetrics
        }

        Component {
            id: delegateComponent



            Label {
                text: formatText(Tumbler.tumbler.count, modelData)
                opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: fontMetrics.font.pixelSize * 1.25

                function formatText(count, modelData) {
                    var data = count === 12 ? modelData + 1 : modelData;
                    return data + ":00";
                }
            }
        }

        Tumbler {

            anchors.horizontalCenter: parent.horizontalCenter
            id: hoursTumbler
            model: tumblerModel
            delegate: delegateComponent
            wrap: false
        }


    }
}
