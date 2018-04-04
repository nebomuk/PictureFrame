import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import de.vitecvisual.util 1.0



DeviceManagerPageForm {

    id : page

    Component.onCompleted:
    {
        availableDevicesListView.model.append({"hostName":"SchmartCalendar"})


        savedDevicesListView.model.append({"hostName":"SavedSchmartCalendar"})
    }

    onAvailableDevicesClicked:
    {
        var page = stackView.push("FirstConfigurationPage.qml",{"index":index})

        page.finished.connect(onFirstConfigurationPageFinished)

    }

    onSavedDevicesClicked: {
        var hostName = savedDevicesListView.model.get(index).hostName
       // NotifyingSettings.selectedDevice =hostName // fixme this line crashes
        stackView.pop();
    }

    function onFirstConfigurationPageFinished()
    {
        var page = stackView.pop();
        page.finished.disconnect(onFirstConfigurationPageFinished);
        var index = page.index;
        var deviceName = page.textFieldDeviceName.text

        var ssid = page.textFieldSsid.text

        var password = page.textFieldPassword.text


    }

    function createDummyDatabaseEntries()
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
        return openDatabaseSync("SmartCalendarDevicesModel", "1.0", "Saved Smart Calendar Devices in Network", 1000000);
    }
    function __ensureTables(tx)
    {
        tx.executeSql('CREATE TABLE IF NOT EXISTS SmartCalendarDevices(productName TEXT, productId TEXT, productPassword TEXT)', []);
    }


}

