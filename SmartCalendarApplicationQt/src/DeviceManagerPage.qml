import QtQuick 2.0
import Qt.labs.settings 1.0


DeviceManagerPageForm {

    id : page

    onAvailableDevicesClicked:  console.log("clicked avail index : " + index);

    property string selectedDevice


    Settings {
        property alias selectedDevice: page.selectedDevice
    }


}

