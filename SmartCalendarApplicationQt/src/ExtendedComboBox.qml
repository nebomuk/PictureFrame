import QtQuick 2.0
import QtQuick.Controls 2.3
import "ComboBoxUtil.js" as ComboBoxUtil



// combo box with some extra methods
ComboBox {

    id : comboBox

    //attempts to find the text in the model and sets it as the currentItem
    property string initialText



    onInitialTextChanged:
    {
        ComboBoxUtil.setInitialText(comboBox,initialText);
    }
}
