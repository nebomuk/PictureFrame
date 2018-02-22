import QtQuick 2.4
import QtQuick.Controls 2.3

Page {
    


    title: qsTr("Base Options")


    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        BaseCalendarOptionsPage
        {

        }
        BaseDisplayOptionsPage
        {

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
