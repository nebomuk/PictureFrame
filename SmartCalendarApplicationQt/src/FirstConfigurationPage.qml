import QtQuick 2.0

FirstConfigurationPageForm {
    property int index // helper property when page is popped

    signal finished(); // confirm pressed

    buttonConfirm.onClicked: finished();

}
