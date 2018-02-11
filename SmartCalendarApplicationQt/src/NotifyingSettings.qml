pragma Singleton

import QtQuick 2.0
import Qt.labs.settings 1.0

// singleton wrapper for Settings that notifies of changes

QtObject {
    id : obj

    property string selectedDevice : qsTr("No device selected")


    property Settings settings : Settings
    {
        property alias s1 : obj.selectedDevice
    }
}



