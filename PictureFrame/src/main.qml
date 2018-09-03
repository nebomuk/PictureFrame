import QtQuick 2.10
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import pictureframecompany.style 1.0
import Qt.labs.platform 1.0
import pictureframecompany.core 1.0;


ApplicationWindow {
    id: window
    visible: true

    title: qsTr("Picture Frame")

    property alias buttonDone: buttonDone

    Component.onCompleted:
    {
        if(Qt.platform.os !== "android" && Qt.platform.os !== "ios" && Qt.platform.os !== "tvos")
        {
            width = 480
            height = 800
        }
    }

    // handle android back button
    onClosing : {
        if(Qt.platform.os === "android")
        {
            if(stackView.depth <= 1)
            {
                close.accepted = true; // quit app
            }
            else
            {
                close.accepted = false;
                stackView.pop();
            }
        }
    }


    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            icon
            {
                source :  "qrc:/icon/arrow-left.svg"
            }
            display: stackView.depth > 1 ? AbstractButton.IconOnly : AbstractButton.TextOnly
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                }
            }
        }

        Label {
            id : titleLabel
            text: stackView.currentItem.title
            anchors.centerIn: parent
            font.pointSize: 20
        }

        // pages can control the visibility by having a property doneVisible and a method onDoneClicked
        ToolButton {
            id : buttonDone
            visible: stackView.depth > 1 && typeof stackView.currentItem.onDoneClicked === "function"
            && stackView.currentItem.doneVisible !==false
            anchors.right : parent.right
            icon
            {
                source : "qrc:/icon/done.svg"
            }

            onClicked: {
                if (typeof stackView.currentItem.onDoneClicked === "function") {
                    stackView.currentItem.onDoneClicked();
                }
            }
        }
    }

    footer: Label {
            text : "Alpha stage product"
            horizontalAlignment:  Text.AlignHCenter
            bottomPadding: 10

    }


    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "MainPage.qml"

       }

    Keys.onBackPressed: {
        event.accepted = true
        stackView.pop();
    }

    MessageDialog
    {
        text : "Loaded from Local fs"

        Component.onCompleted:
        {
            if(loadedFromLocalFs === true)
            {
                open();
            }
        }
    }
}
