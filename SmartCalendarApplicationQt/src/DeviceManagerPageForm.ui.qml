import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import de.vitecvisual.model 1.0

Page {
    id: page

    

    title: qsTr("Device Selection")

    signal availableDevicesClicked(int index)
    signal savedDevicesClicked(int index)

    property alias deviceManagerModel: deviceManagerModel

    DeviceManagerModel
    {
        id : deviceManagerModel

//        onAvailableDevicesChanged: console.log("availableDevicesChanged " + availableDevices[0].hostName)
//        onAvailableDeviceCountChanged:  console.log("onAvailableDeviceCountChanged " + availableDeviceCount)

    }

    ColumnLayout
    {
        id: column
        y: 99
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

    Label {
        id: label1
        text: qsTr("Configured Devices")
    }

    ListView {
        id: savedDevicesListView
        height: 200
        delegate:
            Frame
            {
                Label
                {
                    MouseArea
                    {
                        id : savedDevicesMouseArea
                        anchors.fill: parent

                    }
                    Connections {
                       target: savedDevicesMouseArea
                       onClicked: savedDevicesClicked(index)
                     }
                    text : deviceManagerModel.savedDevices[modelData].hostName
                }
            }

        model: deviceManagerModel.savedDeviceCount
    }


    Label {
        id: label
        text: qsTr("Configure New Device")
    }



    ListView {
        id: availableDevicesListView
        height: 200
        delegate: Frame {

            Label {

                MouseArea
                {
                    id : availableDevicesMouseArea
                    anchors.fill: parent
                }
                Connections {
                   target: availableDevicesMouseArea
                   onClicked: availableDevicesClicked(index)
                 }
                text: deviceManagerModel.availableDevices[modelData].hostName
            }
        }
        model: deviceManagerModel.availableDeviceCount
    }


    }
}
