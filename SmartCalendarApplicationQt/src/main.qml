import QtQuick 2.10
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import de.vitecvisual.style 1.0


ApplicationWindow {
    id: window
    visible: true
    width: 480
    height: 640
    title: qsTr("SmartCalendar")

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        background: Rectangle {
                        anchors.fill: parent
                        color : "transparent"
                    }

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            id : titleLabel
            text: stackView.currentItem.title
            anchors.centerIn: parent
            font.pointSize: 12
            color: Style.colorHeading1

                   layer.enabled: true
                   layer.effect: DropShadow {
                       verticalOffset: 2
                       color: "#80000000"
                       radius: 2
                       samples: 3
                   }
               }
        Label {
            id : heading2Label
            text: "no device selected"
            anchors.topMargin: 20
            anchors.top: titleLabel.bottom
            anchors.horizontalCenter: titleLabel.horizontalCenter
            font.pointSize: 24
            color: Style.colorHeading1

               }
        Rectangle {
            id: rectangle
            anchors.topMargin: 20
            anchors.top: heading2Label.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 10
            color: Style.colorHeading2
            anchors.rightMargin: 0
            anchors.leftMargin: 0
        }
        }

    footer: Label {
            text : "Copyright © 2018 ViTec - Visual Solutions"
            horizontalAlignment:  Text.AlignHCenter
            bottomPadding: 10

    }


    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Device Manager")
                width: parent.width
                onClicked: {
                    stackView.push("BaseOptionsPage.ui.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Base Options")
                width: parent.width
                onClicked: {
                    stackView.push("DeviceManagerPage.ui.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "MainPage.ui.qml"
        anchors.fill: parent
    }
}
