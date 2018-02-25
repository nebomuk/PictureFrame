import QtQuick 2.0
import QtQuick.Controls 2.3

// a page that provides a confirm button by default
Page {
    id: page

    property alias buttonConfirm: buttonConfirm

    ConfirmButton {
        id: buttonConfirm
    }
}
