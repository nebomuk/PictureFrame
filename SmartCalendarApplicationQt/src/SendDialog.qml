import QtQuick 2.0
import QtQuick.Controls 2.3
import Qt.labs.platform 1.0 as QtLabs
import de.vitecvisual.core 1.0;
import "DateUtil.js" as DateUtil
import "ListModelUtil.js" as ListModelUtil
import "SignalUtil.js" as SignalUtil
import QtQml.StateMachine 1.0 as DSM


Dialog
{
    id : sendDialog
    
    property var sendFunction
    
    standardButtons:  Dialog.Ok
    
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    
    contentWidth: busyIndicator.running ? busyIndicator.implicitWidth : 0
    contentHeight: busyIndicator.running ? busyIndicator.implicitHeight : 0

        BusyIndicator
        {
            id : busyIndicator
        }

    
    DSM.StateMachine {
        id: stateMachine
        initialState: dialogHidden
        running: true
        DSM.State {
            id: dialogHidden
            DSM.SignalTransition {
                targetState: dialogShown
                signal: sendDialog.aboutToShow
            }
            
            onEntered: {
                sendDialog.standardButton(Dialog.Ok).visible = false;
            }
        }
        DSM.State {
            id: dialogShown
            DSM.SignalTransition {
                targetState: successfull
                signal: DeviceAccessor.published
            }

            DSM.SignalTransition {
                targetState: mqttError
                signal: DeviceAccessor.error
            }
            
            onEntered: {
                busyIndicator.running = true;
                sendDialog.sendFunction();
                sendDialog.title = qsTr("Sending");
            }
        }
        DSM.State {
            id: successfull
            onEntered: {
                busyIndicator.running = false;
                sendDialog.standardButton(Dialog.Ok).visible = true;
                sendDialog.title = qsTr("Successfull");
            }
            DSM.SignalTransition
            {
                targetState: dialogHidden
                signal : sendDialog.aboutToHide
            }
        }

        // this will rarely happen, because most of the time the mqtt error will trigger another dialog first
        DSM.State {
            id: mqttError
            onEntered: {
                busyIndicator.running = false;
                sendDialog.standardButton(Dialog.Ok).visible = true;
                sendDialog.title = qsTr("Error");
            }
            DSM.SignalTransition
            {
                targetState: dialogHidden
                signal : sendDialog.aboutToHide
            }
        }
    }
    
}
