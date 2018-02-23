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

    title: qsTr("SmartCalendar")

    Component.onCompleted:
    {
        if(Qt.platform.os !== "android" && Qt.platform.os !== "ios" && Qt.platform.os !== "tvos")
        {
            width = 480
            height = 800
        }

        if(!SmartCalendarAccess.isConnectedToWifi)
        {
            msgDialogWifi.open()
        }

        // for testing

        var controllerList = SmartCalendarAccess.getControllerInNetworkFromBroadcastBlocking(1000);


        var res = DeviceAccessor.establishConnectionBlocking(controllerList[0].hostIpAdress);
    }

    // handle android back button
    onClosing : {
        if(Qt.platform.os === "android")
        {
            if(stackView.depth <= 1)
            {
                close.accepted = true; // quit app
            }
            else
            {
                close.accepted = false;
                stackView.pop();
            }
        }
    }


    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
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


    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "MainPage.qml"

       }

    Keys.onBackPressed: {
        event.accepted = true
        stackView.pop();
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

              }


          }



    Timer {
             interval: 500; running: true; repeat: false
             onTriggered: {
                 var options = DeviceAccessor.controllerDataContainer.baseOptions;

                 var str = JSON.stringify(options);

                 console.log("connection result " + str);


             }

         }
      }
