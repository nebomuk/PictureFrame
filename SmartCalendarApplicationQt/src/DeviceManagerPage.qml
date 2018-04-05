import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import de.vitecvisual.util 1.0


// Workflow is a bit different than from the description in Modell zur Erstkonfiguration.ppt
// devices that have been removed (via X or Trash icon) reappear in the available devices list
// instead of being moved to the banned list
DeviceManagerPageForm {

    id : page

    Component.onCompleted:
    {       
        addNonSavedDevices(availableDevicesListView.model);

      //  createDummySavedDevices();


        fillModel(savedDevicesListView.model)
    }

    // TODO remove from
    onSavedDeviceRemoved: console.log("removed index " + index);

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

        availableDevicesListView.model.clear();

        addNonSavedDevices(availableDevicesListView.model);


    }

    function addNonSavedDevices(model)
    {
        // TODO get scanned devices instead of this dummy list
        var allDevices =   [
        {"productId":"id0"},
        {"productId":"id1"},
        {"productId":"id2"},

         ];

        __db().transaction(
            function(tx) {
                __ensureTables(tx);

                var rs = tx.executeSql("SELECT productId FROM SavedDevices");
                var existingProductIds = [];
                for (var i=0; i<rs.rows.length; ++i)
                {
                    existingProductIds.push(rs.rows.item(i).productId);
                }

                allDevices.forEach(function(device)
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

            }
            );
    }

    function fillModel(model) {
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

