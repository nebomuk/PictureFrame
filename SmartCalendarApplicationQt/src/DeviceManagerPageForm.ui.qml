import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import de.vitecvisual.model 1.0

Page {
    id: page

    

    title: qsTr("Device Selection")

    signal availableDevicesClicked(int index)
    signal savedDevicesClicked(int index)

    property alias savedDevicesListView: savedDevicesListView

    property alias availableDevicesListView: availableDevicesListView


    ColumnLayout
    {
        id: column
        anchors.top :parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 10

    Label {
        id: label1
        text: qsTr("Configured Devices")
    }

    ListView {
        id: savedDevicesListView
        height: 200

        delegate:
            Frame
            {
                RowLayout
                {
                Label
                {
                    MouseArea
                    {
                        id : savedDevicesMouseArea
                        anchors.fill: parent

                    }
                    Connections {
                       target: savedDevicesMouseArea
                       onClicked: savedDevicesClicked(index)
                     }
                    text : hostName
                }
                Text
                {

                    text : "\uf0c2"
                    font.family: "FontAwesome"
                    font.pointSize: 14
                }

                Text
                {
                    text : "\uf1eb"
                    font.family: "FontAwesome"
                    font.pointSize: 14
                }

                RemoveButton
                {
                    listModel: modelSavedDevices
                    font.pointSize: 14
                }
                }
            }

        model: ListModel
        {
            id : modelSavedDevices
        }
    }


    Label {
        id: label
        text: qsTr("Configure New Device")
    }



    ListView {
        id: availableDevicesListView
        height: 200
        delegate: Frame {

            Label {

                MouseArea
                {
                    id : availableDevicesMouseArea
                    anchors.fill: parent
                }
                Connections {
                   target: availableDevicesMouseArea
                   onClicked: availableDevicesClicked(index)
                 }
                text: hostName
            }
        }
        model: ListModel
        {

        }
    }


    }
}
