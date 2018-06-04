import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 2.3 // required for stackView attached properties
import de.vitecvisual.util 1.0
import Qt.labs.platform 1.0
import de.vitecvisual.core 1.0;
import QtQml.StateMachine 1.11 as DSM


// Workflow is a bit different than from the description in Modell zur Erstkonfiguration.ppt
// devices that have been removed (via X or Trash icon) reappear in the available devices list
// instead of being moved to the banned list
DeviceManagerPageForm {

    id : page

MessageDialog {
      id : msgDialogUdpFailed
      title:  qsTr("No SmartCalendar found")
      text: qsTr("Make sure your SmartCalendar is turned on and in the same network. Click OK to continue.")
      buttons: MessageDialog.Ok
}

// this happens when the SmartCalendar looses it's connection to the mqtt broker
MessageDialog {
      id : msgDialogConnectionFailed
      title:  qsTr("Connection failed")
      text: qsTr("Please turn on your SmartCalendar. If it is already turned on, you need to restart it.")
      buttons: MessageDialog.Ok
}

MessageDialog {
      id : msgDialogOldVersion
      title:  qsTr("Version too old")
      text: qsTr("SmartCalendar response did not contain Product Id. Please update your Smart Calendar software")
      buttons: MessageDialog.Ok
}

MessageDialog {
      id : msgDialogDeviceNotReachable
      title:  qsTr("Not Reachable")
      text: qsTr("We cannot find this SmartCalendar in the local network or in the cloud")
      buttons: MessageDialog.Ok
}

property var devicesFromUdpBroadcast


    DSM.StateMachine
    {
        id : stateMachine
        running: true
        initialState : stateFindAndConnect



        Connections
        {
            target : SmartCalendarAccess
            onControllerInNetworkReceived : devicesFromUdpBroadcast = controllers
        }

        DSM.FinalState
        {
            id: finalState
        }
        onFinished: stackView.pop();

        DSM.State
        {
            id : stateFindAndConnect
            onEntered:
            {
                busyIndicator.visible = true;
                gridLayout.visible = false;
                SmartCalendarAccess.getControllerInNetworkFromBroadcast();
            }

            onExited:
            {
                busyIndicator.visible = false;
                gridLayout.visible = true;
            }

            DSM.SignalTransition
            {
                targetState: stateControllerMaybeFound
                signal : SmartCalendarAccess.controllerInNetworkReceived
            }

            DSM.TimeoutTransition
            {
                timeout: 2000
                targetState: stateControllerMaybeFound // go to the state anyways
                onTriggered: msgDialogUdpFailed.open();
            }

        }

        DSM.State
        {
            id : stateControllerMaybeFound

            onEntered: {
                // token required here
                if(devicesFromUdpBroadcast.length > 0)
                {
                    // productId is required
                    if(devicesFromUdpBroadcast[0].productId === "")
                       {
                          msgDialogOldVersion.open();

                       }
                    else
                    {
                        updateListViews();
                    }
                }
                else // length == 0
                {
                    console.debug("SmartCalendarAccess.getControllerInNetworkFromBroadcast failed");
                    msgDialogUdpFailed.open();
                }

            }

            DSM.SignalTransition
            {
                signal : refreshButton.onClicked
                targetState: stateFindAndConnect
            }

        }
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
                 var mainPage = stackView.get(StackView.index -1);
                 mainPage.selectedDevice = savedDevicesListView.model.get(index).productName;

                 stackView.pop();
             }
        }
    }

    function onFirstConfigurationPageFinished()
    {
        var page = stackView.pop();
        page.finished.disconnect(onFirstConfigurationPageFinished);
        var productName = page.textFieldProductName.text

        var ssid = page.textFieldSsid.text

        var productPassword = page.textFieldProductPassword.text

        insertDbEntry(productName,page.productId, productPassword);
        stackView.pop();
    }

    function updateListViews()
    {
        fillAvailableDevicesModel();

        fillSavedDevicesModel()
    }

    function fillAvailableDevicesModel()
    {
        __db().transaction(
            function(tx) {
                __ensureTables(tx);

                availableDevicesListView.model.clear();

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
                        availableDevicesListView.model.append({"productId":device.productId});
                    }
                });

            }
            );
    }



    function fillSavedDevicesModel() {
             __db().transaction(
                 function(tx) {
                     __ensureTables(tx);

                     var rs = tx.executeSql("SELECT * FROM SavedDevices");
                     savedDevicesListView.model.clear();

                     if (rs.rows.length > 0) {
                         for (var i=0; i<rs.rows.length; ++i)
                         {
                             var rowItem = rs.rows.item(i);
                             var found = devicesFromUdpBroadcast.find(function(device) {
                               return device.productId === rowItem.productId;
                             });

                             // this will set wifi icon visibility
                             rowItem.ip = found !== undefined ? found.hostIpAdress : ""; // note the spelling error
                             savedDevicesListView.model.append(rowItem)
                         }

                     }
                 }
             )
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


    function __db()
    {
        return LocalStorage.openDatabaseSync("SmartCalendarDevicesModel", "1.0", "Saved Smart Calendar Devices in Network", 1000000);
    }
    function __ensureTables(tx)
    {
        //tx.executeSql("DROP TABLE SmartCalendarDevices");
        tx.executeSql('CREATE TABLE IF NOT EXISTS SavedDevices(productName TEXT, productId TEXT, productPassword TEXT)', []);
    }
}

