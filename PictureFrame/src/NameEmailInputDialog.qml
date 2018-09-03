import QtQuick 2.4
import QtQuick.Controls 2.3

// NameEmail input dialog used for DefinePersonsPage

NameEmailInputDialogForm {

    id : dialog

    Component.onCompleted:
    {
        var button = standardButton(Dialog.Ok);
        button.enabled = Qt.binding(function() {
        return textFieldName.text.length > 0 && textFieldEmail.length > 0;
        });


    }
}
