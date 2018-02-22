import QtQuick 2.0
import de.vitecvisual.core 1.0;

MasterAccountPageForm {

    buttonConfirm.onClicked: {
        GoogleCalendarAuthorization.startAuthorization();
    }


}
