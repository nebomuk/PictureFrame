import QtQuick 2.0
import de.vitecvisual.util 1.0



DeviceManagerPageForm {

    id : page

    onAvailableDevicesClicked:  console.log("clicked avail index : " + index);

    onSavedDevicesClicked: {
        NotifyingSettings.selectedDevice = deviceManagerModel.savedDevices[index].hostName
        stackView.pop();
    }


}

