import QtQuick 2.0
import QtQuick.Controls 2.3


// ComboBox with StringXmlResourceModel set by default, see StringXmlResourceModel for further documentation
ComboBox {

    id : comboBox

    property string attributeName

    model: StringXmlResourceModel {
        attributeName: comboBox.attributeName
    }
    Component.onCompleted: currentIndex = 0

}
