import QtQuick 2.4
import QtQuick.Controls 2.3

Page {

    

    id : page

    title: qsTr("Select Picture Type")

    ComboBox
    {
        id : comboBox

        width: 224
        height: 48
        anchors.top: parent.top
        anchors.topMargin: 108
        anchors.horizontalCenter: parent.horizontalCenter
        textRole: "title"

        // TODO this should be in the PictureTypeSelectionpage.qml component
        Connections {
            target: comboBox
            onCurrentIndexChanged : {
                stackView.push(comboBox.model.get(comboBox.currentIndex).opensPage)
            }
        }


        model: ListModel
        {
                 ListElement { title : "No category selected"
                     opensPage : ""
                 }
                 ListElement { title : "Calendar image"
                    opensPage : "CalendarImagePage.qml"
                 }
                 ListElement { title : "Weather image"
                    opensPage : "WeatherImagePage.qml"
                 }
                 ListElement { title : "News image"
                    opensPage : "NewsImagePage.qml"
                 }
                 ListElement { title : "Football image"
                    opensPage : "FootballImagePage.qml"
                 }
                 ListElement { title : "Cinema image"
                    opensPage : "CinemaImagePage.qml"
                 }
                 ListElement { title : "Own image"
                    opensPage : ""
                 }

        }


    }


}
