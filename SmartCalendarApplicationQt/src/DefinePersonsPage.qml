import QtQuick 2.0
import de.vitecvisual.core 1.0;


DefinePersonsPageForm {

    Component.onCompleted: {
        var personList = DeviceAccessor.controllerDataContainer.personList;

        for(var i = 1; i< personList.length; i++)
        {
            listModel.append({"name":personList[i].name, "email":personList[i].eMailAdress});
        }
    }

}
