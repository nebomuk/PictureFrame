import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: page

    

    title: qsTr("News")

    property alias comboBoxoption : comboBoxoption;
    property alias comboBoxsource : comboBoxsource;
    property alias comboBoxdesign : comboBoxdesign;

    GridLayout
    {
        id : gridLayout
        y: 110
        width: 222
        height: 205
        anchors.horizontalCenter: parent.horizontalCenter
        columnSpacing: 10
        rowSpacing: 10
        rows : 3
        columns :2

        Label
        {
            text : qsTr("Option")
        }

        ComboBox
        {
            id : comboBoxoption
        }

        Label
        {
            text : qsTr("Source")
        }

        ComboBox
        {
            id : comboBoxsource

        }

        Label
        {
            text : qsTr("Design")
        }

        ComboBox
        {
            id : comboBoxdesign

        }

    }
}
