import QtQuick 2.10
import QtQuick.Controls 2.3
import Qt.labs.settings 1.0
import de.vitecvisual.model 1.0

Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Device Selection")

    property string selectedDevice

    Settings {
        property alias selectedDevice: page.selectedDevice
    }

    DeviceManagerModel
    {
        id : deviceManagerModel

//        onAvailableDevicesChanged: console.log("availableDevicesChanged " + availableDevices[0].hostName)
//        onAvailableDeviceCountChanged:  console.log("onAvailableDeviceCountChanged " + availableDeviceCount)

    }

    Column
    {
        spacing: 50

    Label {
        id: label1
        text: qsTr("Configured Devices")
    }


    Label {
        id: label
        text: qsTr("Configure New Device")
    }

    ListView {
        id: listView
        width: 110
        height: 117
        delegate:
            Frame
                {

                    Label
                    {
                        text : deviceManagerModel.availableDevices[modelData].hostName
                    }
                }

        model: deviceManagerModel.availableDeviceCount
    }


    }
}
