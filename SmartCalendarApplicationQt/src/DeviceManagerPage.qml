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
        availableDevicesListView.model.append({"productId":"some id device"})

        createDummyDbEntries();


        fillModel(savedDevicesListView.model)
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

        availableDevicesListView.model.clear();
        var unconfigured = getUnconfiguredAvailableDevices();
        for(var i = 0; i< unconfigured.length; ++i)
        {
            availableDevicesListView.model.append(unconfigured[i]);
        }

    }

    function getUnconfiguredAvailableDevices()
    {
        // TODO replace this line by SmartCalendarAccess
        var availableDevices =   {"productId":"some id device"};

        __db().transaction(
            function(tx) {
                __ensureTables(tx);

                return tx.executeSql("SELECT * FROM SmartCalendarDevices WHERE productId NOT IN (?)",availableDevices.productId);

            }
            );



    }

    function insertDbEntry(productName, productId, productPassword)
    {
        __db().transaction(
            function(tx) {
                __ensureTables(tx);

                tx.executeSql("INSERT INTO SmartCalendarDevices VALUES(?,?,?)",[productName,productId,productPassword]);

            }
            );
    }

    function createDummyDbEntries()
    {
        __db().transaction(
            function(tx) {
                __ensureTables(tx);

                 var rs = tx.executeSql("SELECT * FROM SmartCalendarDevices");
                if(rs.rows.length === 0)
                {
                    tx.executeSql("INSERT INTO SmartCalendarDevices VALUES(?,?,?)",["SavedSchmartCalendar","myId","pwisasdf"]);
                }
            }
            );

    }

    function fillModel(model) {
             __db().transaction(
                 function(tx) {
                     __ensureTables(tx);

                     var rs = tx.executeSql("SELECT * FROM SmartCalendarDevices");
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
        tx.executeSql('CREATE TABLE IF NOT EXISTS SmartCalendarDevices(productName TEXT, productId TEXT, productPassword TEXT)', []);
    }


}

