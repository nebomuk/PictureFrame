import QtQuick 2.0
import de.vitecvisual.core 1.0;


DefinePersonsPageForm {



    onListIndexClicked: {

        var item = listModel.get(index);
        dialog.textFieldEmail.text = item.email
        dialog.textFieldName.text =  item.name
        dialog.open();
        dialog.editedItemIndex = index;

    }

    addButton.onClicked: {
        dialog.editedItemIndex = dialog.indexAddItem
        dialog.open()
    }




    NameEmailInputDialog
    {
        id : dialog

        readonly property int indexUndefined  : -1
        readonly property int indexAddItem : -2


        property int editedItemIndex

        Component.onCompleted: editedItemIndex = indexUndefined;


        onAccepted: {

            if(editedItemIndex > 0)
            {
                listModel.set(editedItemIndex,{"name":textFieldName.text, "email":textFieldEmail.text})
            }
            else if (editedItemIndex === indexAddItem)
            {
                listModel.append({"name":textFieldName.text, "email":textFieldEmail.text});
            }

            editedItemIndex = indexUndefined;

        }

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
    }


    Component.onCompleted: {
        var personList = DeviceAccessor.controllerDataContainer.personList;

        for(var i = 1; i< personList.length; i++)
        {
            listModel.append({"name":personList[i].name, "email":personList[i].eMailAdress});
        }
    }

}
