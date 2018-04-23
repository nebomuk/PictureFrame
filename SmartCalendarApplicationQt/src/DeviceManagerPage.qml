import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import de.vitecvisual.util 1.0
import Qt.labs.platform 1.0
import de.vitecvisual.core 1.0;


// Workflow is a bit different than from the description in Modell zur Erstkonfiguration.ppt
// devices that have been removed (via X or Trash icon) reappear in the available devices list
// instead of being moved to the banned list
DeviceManagerPageForm {

    id : page

    Timer {
        id : timer
             interval: 2000; running: false; repeat: false
             onTriggered: {

                 busyIndicator.visible = false;
                 gridLayout.visible = true;
             }
         }

MessageDialog {
      id : msgDialogUdpFailed
      title:  qsTr("No SmartCalendar found")
      text: qsTr("Make sure your SmartCalendar is turned on and in the same network. Click OK to continue.")
      buttons: MessageDialog.Ok | MessageDialog.Cancel

      onOkClicked: findAndConnect();
      onCancelClicked: stackView.pop();
}

MessageDialog {
      id : msgDialogConnectionFailed
      title:  qsTr("Connection failed")
      text: qsTr("Please restart the SmartCalendar and press OK")
      buttons: MessageDialog.Ok | MessageDialog.Cancel
      onOkClicked: findAndConnect();
      onCancelClicked: stackView.pop();

}

MessageDialog {
      id : msgDialogOldVersion
      title:  qsTr("Version too old")
      text: qsTr("SmartCalendar response did not contain Product Id. Please update your Smart Calendar software")
      buttons: MessageDialog.Ok | MessageDialog.Cancel
      onOkClicked: findAndConnect();
      onCancelClicked: stackView.pop();

}

MessageDialog {
      id : msgDialogDeviceNotReachable
      title:  qsTr("Not Reachable")
      text: qsTr("We cannot find this SmartCalendar in the local network or in the cloud")
      buttons: MessageDialog.Ok
}

    Component.onCompleted:
    {       
        findAndConnect()
    }

    function findAndConnect()
    {
        busyIndicator.visible = true;
        gridLayout.visible = false;
        timer.restart();


        var devicesFromUdpBroadcast = SmartCalendarAccess.getControllerInNetworkFromBroadcastBlocking(1000);
        // token required here
        if(devicesFromUdpBroadcast.length > 0)
        {
            // productId is required
            if(devicesFromUdpBroadcast[0].productId === "")
               {
                       msgDialogOldVersion.open();

               }
        }
        else // length == 0
        {
            console.debug("SmartCalendarAccess.getControllerInNetworkFromBroadcastBlocking failed");
            msgDialogUdpFailed.open();
        }

        updateListViews(devicesFromUdpBroadcast);
    }

    // TODO remove from
    onSavedDeviceRemoved: {
        deleteDbEntry(savedDevicesListView.model.get(index).productId)
    }


    onAvailableDevicesClicked:
    {
        var item = availableDevicesListView.model.get(index);
        var page = stackView.push("FirstConfigurationPage.qml",{"productId" : item.productId});

        page.finished.connect(onFirstConfigurationPageFinished)

    }

    onSavedDevicesClicked: {
        var ip = savedDevicesListView.model.get(index).ip

        if(ip === "" || ip === undefined)
        {
            msgDialogDeviceNotReachable.open();
        }
        else
        {

             var res = DeviceAccessor.establishConnectionBlocking(ip);
             if(!res)
             {
                 msgDialogConnectionFailed.open();
             }
             else
             {
                 NotifyingSettings.selectedDevice = ""
                 stackView.pop();
                 // TODO connection succesfull message/toast
             }
        }


    }

    function onFirstConfigurationPageFinished()
    {
        var page = stackView.pop();
        page.finished.disconnect(onFirstConfigurationPageFinished);
        var deviceName = page.textFieldDeviceName.text

        var ssid = page.textFieldSsid.text

        var password = page.textFieldPassword.text

        insertDbEntry(deviceName,page.productId, password);
    }

    function updateListViews(devicesFromUdpBroadcast)
    {
        availableDevicesListView.model.clear();

        addNonSavedDevices(devicesFromUdpBroadcast,availableDevicesListView.model);

        savedDevicesListView.model.clear();

        addSavedDevices(savedDevicesListView.model, devicesFromUdpBroadcast)
    }

    function addNonSavedDevices(devicesFromUdpBroadcast, model)
    {

        __db().transaction(
            function(tx) {
                __ensureTables(tx);

                var rs = tx.executeSql("SELECT productId FROM SavedDevices");
                var existingProductIds = [];
                for (var i=0; i<rs.rows.length; ++i)
                {
                    existingProductIds.push(rs.rows.item(i).productId);
                }

                devicesFromUdpBroadcast.forEach(function(device)
                {
                    if(existingProductIds.indexOf(device.productId) === -1) // not included
                    {
                        model.append({"productId":device.productId});
                    }
                });

            }
            );
    }

    function insertDbEntry(productName, productId, productPassword)
    {
        __db().transaction(
            function(tx) {
                __ensureTables(tx);

                tx.executeSql("INSERT INTO SavedDevices VALUES(?,?,?)",[productName,productId,productPassword]);
                updateListViews();
            }
            );
    }

    function deleteDbEntry(productId)
    {
        __db().transaction(
            function(tx) {
                __ensureTables(tx);

                tx.executeSql("DELETE FROM SavedDevices WHERE productId=?",productId);
                updateListViews();

            }
            );
    }

    function addSavedDevices(model,devicesFromUdpBroadcast) {
             __db().transaction(
                 function(tx) {
                     __ensureTables(tx);

                     var rs = tx.executeSql("SELECT * FROM SavedDevices");
                     model.clear();

                     if (rs.rows.length > 0) {
                         for (var i=0; i<rs.rows.length; ++i)
                         {
                             var rowItem = rs.rows.item(i);
                             var found = devicesFromUdpBroadcast.find(function(device) {
                               return device.productId === rowItem.productId;
                             });

                             // this will set wifi icon visibility
                             rowItem.ip = found !== undefined ? found.hostIpAdress : ""; // note the spelling error
                             model.append(rowItem)
                         }

                     }
                 }
             )
         }


    function __db()
    {
        return LocalStorage.openDatabaseSync("SmartCalendarDevicesModel", "1.0", "Saved Smart Calendar Devices in Network", 1000000);
    }
    function __ensureTables(tx)
    {
        //tx.executeSql("DROP TABLE SmartCalendarDevices");
        tx.executeSql('CREATE TABLE IF NOT EXISTS SavedDevices(productName TEXT, productId TEXT, productPassword TEXT)', []);
    }

    function createDummySavedDevices()
    {
        __db().transaction(
            function(tx) {
                __ensureTables(tx);

                 var rs = tx.executeSql("SELECT * FROM SavedDevices");
                if(rs.rows.length === 0)
                {
                    tx.executeSql("INSERT INTO SavedDevices VALUES(?,?,?)",["SavedSchmartCalendar","myId","pwisasdf"]);
                }
            }
            );

    }


}

