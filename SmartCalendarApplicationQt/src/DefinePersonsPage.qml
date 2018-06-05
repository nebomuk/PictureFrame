import QtQuick 2.0
import de.vitecvisual.core 1.0;
import Qt.labs.platform 1.0
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


    MessageDialog {
         id : dialogEmailExists
         buttons: MessageDialog.Ok
         title : qsTr("Error")
         text: qsTr("The Email Address of the person you entered already exists")
     }


    NameEmailInputDialog
    {
        id : dialog

        readonly property int indexUndefined  : -1
        readonly property int indexAddItem : -2


        property int editedItemIndex

        Component.onCompleted: editedItemIndex = indexUndefined;


        onAccepted: {

            if(listModelContains(textFieldEmail.text))
            {
                dialogEmailExists.open();
            }
            else
            {
                if(editedItemIndex > 0)
                {
                    listModel.set(editedItemIndex,{"name":textFieldName.text, "email":textFieldEmail.text})
                }
                else if (editedItemIndex === indexAddItem)
                {
                    listModel.append({"name":textFieldName.text, "email":textFieldEmail.text});
                }
            }

            editedItemIndex = indexUndefined;

        }

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
    }

    function listModelContains(emailAddress)
    {
      for(var i = 0; i < listModel.count; ++i)
      {
          if (listModel.get(i).email === emailAddress)
          {
              return true;
          }
      }
      return false;
    }

    GoogleCalendarAuthorization
    {
        id : googleCalendarAuthorization
    }


    Component.onCompleted: {
        var personList = DeviceAccessor.controllerDataContainer.personList;

        for(var i = 1; i< personList.length; i++)
        {
            listModel.append({"name":personList[i].name, "email":personList[i].eMailAdress});
        }

       // googleCalendarAuthorization.startAuthorization();

        var xhr = new XMLHttpRequest();
        xhr.withCredentials = true;
        xhr.onreadystatechange = function () {
          if (xhr.readyState === XMLHttpRequest.DONE) {
            console.log(xhr.responseText);
          }
        }

        xhr.open("GET", "https://www.googleapis.com/calendar/v3/users/me/calendarList");
        xhr.setRequestHeader("authorization", "Bearer " + googleCalendarAuthorization.authorizationFlow.token);

        xhr.send(null);
    }

}
