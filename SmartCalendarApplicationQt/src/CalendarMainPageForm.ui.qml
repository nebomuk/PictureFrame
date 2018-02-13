import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import de.vitecvisual.util 1.0



Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Calendar Main")

    property string selectedDevice: NotifyingSettings.selectedDevice
    property int listViewRowCount : 1

    ColumnLayout
    {
        x: 50
        y: 67
        width: 367
        height: 314

        spacing: 10
        Label
        {
            id: label
            font.pointSize: 20
            text: selectedDevice
        }

        ListView
        {
            // TODO change model to support removal of individual rows
            model : listViewRowCount

            height:  300
            delegate: RowLayout
                        {
                            spacing : 10

                        Button
                        {
                            text: qsTr("Image")

                        }

                        Label
                        {
                            text : qsTr("No Image Selected")
                        }

                        Column
                        {
                            Label
                            {
                                text : qsTr("Duration in s")
                            }

                            TextField
                            {
                                placeholderText: qsTr("s")
                            }
                        }

                    }


    }
        Button
        {
            id : buttonAddMorePictures
            text : qsTr("Add more pictures")

         }

        Connections
        {
            target: buttonAddMorePictures
            onClicked : {
                if(listViewRowCount <4)
                {
                    listViewRowCount++;
                }
                else
                {
                    listViewRowCount++;
                    buttonAddMorePictures.visible = false
                }

            }

        }

    }
}
