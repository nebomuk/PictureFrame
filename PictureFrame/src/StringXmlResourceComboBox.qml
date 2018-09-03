import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.XmlListModel 2.0
import "ComboBoxUtil.js" as ComboBoxUtil



// ExtendedComboBox with StringXmlResourceModel set by default, see StringXmlResourceModel for further documentation
ExtendedComboBox {

    id : comboBox

    // the xml attribute name used for the xquery
    property string attributeName

    // the text initially shown taken from the model
    property string initialText


    model: StringXmlResourceModel {
        attributeName: comboBox.attributeName

        onStatusChanged:
        {
            if(status === XmlListModel.Ready && initialText.length > 0)
            {
                ComboBoxUtil.setInitialText(comboBox,initialText);
            }
        }
    }
    Component.onCompleted: {
        if(initialText.length === 0)
        {
            currentIndex = 0
        }

    }


    onInitialTextChanged:
    {
        // model already loaded, then set directly, if initialText is set in some Component.onCompleted
        // where the model is still loading
        // the method above, onStatusChanged will be executed delayed
        if(model.status === XmlListModel.Ready )
        {
            ComboBoxUtil.setInitialText(comboBox,initialText);
        }
    }
}
