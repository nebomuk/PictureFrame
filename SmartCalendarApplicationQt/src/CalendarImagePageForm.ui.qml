import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import de.vitecvisual.util 1.0



Page {
    id: page
    width: 480
    height: 800

    title: qsTr("Calendar Image")

    property string selectedDevice: NotifyingSettings.selectedDevice

    Column
    {
        x: 50
        y: 67
        width: 367
        height: 314
        Label {
        id: label
        font.pointSize: 20
        text: selectedDevice
        anchors.horizontalCenter: parent.horizontalCenter
        bottomPadding: 8
    }

    GridLayout
    {
        id : gridLayout
        columnSpacing: 10
        rowSpacing: 10
        rows : 3
        columns :4

        CheckBox
        {

        }

        Button
        {
            text: "Picture"

        }

        Label
        {
            text : qsTr("Picture Category")
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

        CheckBox
        {

        }

        Button
        {
            text: "Picture"

        }

        Label
        {
            text : qsTr("Picture Category")
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

        CheckBox
        {

        }

        Button
        {
            text: "Picture"

        }

        Label
        {
            text : qsTr("Picture Category")
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

        Button
        {
            Layout.columnSpan: gridLayout.columns
            id : buttonAddMorePictures
            text : qsTr("Add more pictures")

          }
    }
    }
}

