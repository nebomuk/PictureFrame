import QtQuick 2.0

FirstConfigurationPageForm {

    property string productId

    signal finished(); // confirm pressed

    buttonConfirm.onClicked: finished();

}
