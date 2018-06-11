import QtQuick 2.0

import QtQuick 2.0
import QtQuick.Controls 2.3
import de.vitecvisual.core 1.0;
import QtQml.StateMachine 1.0 as DSM

// the dialog that is shown when the done button on the CalendarMainPage is clicked and multiple mqtt packets
// are sent to the SmartCalendar
Dialog
{
    id : dialog

    property /*js array*/ var sendFunctions

    property /*js array*/ var sendArguments

    standardButtons:  Dialog.Ok

    modal : true

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
                signal: dialog.aboutToShow
            }

            onEntered: {
                dialog.standardButton(Dialog.Ok).visible = false;
            }
        }
        DSM.State {
            id: dialogShown
            initialState: sending
            property int functionIndex : 0

            onEntered:
            {
                if(sendFunctions.length !== sendArguments.length)
                {
                    console.error("MultiSendDialog.qml sendFunctions.length != sendArguments.length but must be same size");
                }

                functionIndex = 0;
            }

            DSM.State {
                id : sending

                function callNextSendFunction()
                {
                    dialog.sendFunctions[dialogShown.functionIndex](sendArguments[dialogShown.functionIndex]);
                    dialog.title = qsTr("Sending " + dialogShown.functionIndex);
                    dialogShown.functionIndex++;
                }

                onEntered: {
                    busyIndicator.running = true;
                    callNextSendFunction();
                }

                onExited: {

                }

                DSM.SignalTransition {
                    targetState: mqttError
                    signal: DeviceAccessor.error
                }

                // more to send
                DSM.SignalTransition {
                    signal: DeviceAccessor.published
                    onTriggered: {
                        sending.callNextSendFunction();
                    }

                    guard: dialogShown.functionIndex < sendFunctions.length
                }

                // all send functions called
                DSM.SignalTransition {
                    targetState: successfull
                    signal: DeviceAccessor.published
                    guard: dialogShown.functionIndex >= sendFunctions.length

                }

                // this can happen when the user presses back, but should not be possible
                DSM.SignalTransition
                {
                    targetState: dialogHidden
                    signal : dialog.aboutToHide
                }
            }
        }
        DSM.State {
            id: successfull
            onEntered: {
                busyIndicator.running = false;
                dialog.standardButton(Dialog.Ok).visible = true;
                dialog.title = qsTr("Successfull");
            }
            DSM.SignalTransition
            {
                targetState: dialogHidden
                signal : dialog.aboutToHide
            }
        }

        // this will rarely happen, because most of the time the mqtt error will trigger another dialog first
        DSM.State {
            id: mqttError
            onEntered: {
                busyIndicator.running = false;
                dialog.standardButton(Dialog.Ok).visible = true;
                dialog.title = qsTr("Error");
            }
            DSM.SignalTransition
            {
                targetState: dialogHidden
                signal : dialog.aboutToHide
            }
        }
    }

}
