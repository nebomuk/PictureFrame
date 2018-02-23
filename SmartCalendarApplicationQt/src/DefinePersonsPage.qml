import QtQuick 2.0
import de.vitecvisual.core 1.0;


DefinePersonsPageForm {



    onListIndexClicked: {

        console.log("index: " + index);
        var item = listModel.get(index);
        dialog.textFieldEmail.text = item.email
        dialog.textFieldName.text =  item.name
        dialog.open();
        dialog.indexOfItemCurrentlyEdited = index;

    }


    NameEmailInputDialog
    {
        id : dialog

        property int indexOfItemCurrentlyEdited : -1


        onAccepted: {
            if(indexOfItemCurrentlyEdited === -1)
            {
                return;
            }
            listModel.set(indexOfItemCurrentlyEdited,{"name":textFieldName.text, "email":textFieldEmail.text})

            indexOfItemCurrentlyEdited = -1;
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
