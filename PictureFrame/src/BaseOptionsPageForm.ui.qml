import QtQuick 2.4
import QtQuick.Controls 2.3

Page {
    

    property alias baseCalendarOptionsPage: baseCalendarOptionsPage
    property alias baseDisplayOptionsPage: baseDisplayOptionsPage


    title: qsTr("Base Options")


    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        BaseCalendarOptionsPage
        {
            id : baseCalendarOptionsPage

        }
        BaseDisplayOptionsPage
        {
            id : baseDisplayOptionsPage
        }
    }

    header: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Calendar")
        }
        TabButton {
            text: qsTr("Display")
        }
    }

}
