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
             interval: 2000; running: true; repeat: false
             onTriggered: {

                 busyIndicator.visible = false;
                 gridLayout.visible = true;
             }
         }


MessageDialog {
      id : msgDialogUdpFailed
      title:  qsTr("demo functionality for Debug")
      text: qsTr("UDP Broadcast did not find smartcalendar.
                App will continue to display empty data but might randomly crash")
}

MessageDialog {
      id : msgDialogConnectionFailed
      title:  qsTr("demo functionality for Debug")
      text: qsTr("could not establish MQTT Connection.
App will continue to display empty data but might randomly crash")
}

    Component.onCompleted:
    {       

        var controllerList = SmartCalendarAccess.getControllerInNetworkFromBroadcastBlocking(1000);
        if(controllerList.length > 0)
        {
            var res = DeviceAccessor.establishConnectionBlocking(controllerList[0].hostIpAdress);
            if(!res)
            {
                msgDialogConnectionFailed.open();
            }

        }
        else
        {
            console.debug("Failed to get controller in network");
            msgDialogUdpFailed.open();
        }

                var devicesFromUdpBroadcast =   [
                {"productId":"id0"},
                {"productId":"id1"},
                {"productId":"id2"},

                 ];


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
        var productName = savedDevicesListView.model.get(index).productName
       // NotifyingSettings.selectedDevice =productName // fixme this line crashes
        stackView.pop();
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

        addSavedDevices(savedDevicesListView.model)
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

    function addSavedDevices(model) {
             __db().transaction(
                 function(tx) {
                     __ensureTables(tx);

                     var rs = tx.executeSql("SELECT * FROM SavedDevices");
                     model.clear();

                     if (rs.rows.length > 0) {
                         for (var i=0; i<rs.rows.length; ++i)
                         {
                             model.append(rs.rows.item(i))
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

