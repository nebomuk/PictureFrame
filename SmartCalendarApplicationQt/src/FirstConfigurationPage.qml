import QtQuick 2.0
import Qt.labs.platform 1.0


FirstConfigurationPageForm {

    property string productId

    signal finished(); // confirm pressed

    function onDoneClicked()
    {
        msgDialogDeviceRestart.open();

    }

    MessageDialog {
          id : msgDialogDeviceRestart
          title:  qsTr("Device Restart")
          text: qsTr("The Smart Calendar will now restart itself and connect to the Wifi Network you provided.")

          buttons: MessageDialog.Ok
          onOkClicked:  finished();
    }

}
