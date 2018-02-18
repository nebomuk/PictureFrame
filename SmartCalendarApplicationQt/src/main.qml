import QtQuick 2.10
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import de.vitecvisual.style 1.0
import Qt.labs.platform 1.0
import de.vitecvisual.core 1.0;


ApplicationWindow {
    id: window
    visible: true
    width: 480
    height: 800
    title: qsTr("SmartCalendar")

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

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
            font.pointSize: 20
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
        anchors.fill: parent
        initialItem: MainPage {}

       }


    MessageDialog {
          id : msgDialogWifi
          title:  qsTr("Wifi is disabled")
          text: qsTr("Please enable WiFi")

          onAccepted: {
              if(typeof PlatformHelper.showWifiSettings === "function")
              {
                  PlatformHelper.showWifiSettings()
              }
          }

          Connections {

              target : SmartCalendarAccess

              onIsConnectedToWifiChanged : {
                  if(!SmartCalendarAccess.isConnectedToWifi)
                  {
                      msgDialogWifi.open()
                  }

              }

              Component.onCompleted: {
                  if(!SmartCalendarAccess.isConnectedToWifi)
                  {
                      msgDialogWifi.open()
                  }

                  var res = DeviceAccessor.establishConnectionBlocking("192.168.2.142");

                  var personList = DeviceAccessor.controllerDataContainer.baseOptions;
                  var str = JSON.stringify(personList, null, 2);


                  console.log("connection result " + str);


              }
          }
      }
}
