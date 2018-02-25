import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3


Page {
    id: page

    property alias butonConfirm: buttonConfirm
    

    title: qsTr("Calendar Image")

    ConfirmButton {
        id: buttonConfirm
    }
}

