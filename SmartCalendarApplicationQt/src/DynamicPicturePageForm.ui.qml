import QtQuick 2.10
import QtQuick.Controls 2.3

ConfirmationPage {
    id: page

    property alias buttonChoosePicture: buttonChoosePicture

    Button
    {
        id : buttonChoosePicture
        text : qsTr("Choose Picture");
    }

    

    title: qsTr("Dynamic Picture")
}
