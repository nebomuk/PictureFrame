import QtQuick 2.4
import de.vitecvisual.core 1.0;


BaseOptionsPageForm {

    function onDoneClicked()
    {
        var displayOptions = baseDisplayOptionsPage.getOptions();
        var baseOptions = baseCalendarOptionsPage.getOptions();

        dialog.sendFunctions = [function() {
            DeviceAccessor.controllerDataContainer.displayOptions = displayOptions;
            DeviceAccessor.sendSmartCalendarDeviceOptions(displayOptions);

        },
        function() {
            DeviceAccessor.controllerDataContainer.baseOptions = baseOptions
            DeviceAccessor.sendCalendarBaseOptions(baseOptions);
        }];
        dialog.open();
    }

    MultiSendDialog
    {
        id : dialog
        onAccepted: stackView.pop();
    }

}


