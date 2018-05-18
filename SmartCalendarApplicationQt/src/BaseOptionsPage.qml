import QtQuick 2.4

BaseOptionsPageForm {

    function onDoneClicked()
    {
        baseDisplayOptionsPage.onDoneClicked();
        baseCalendarOptionsPage.onDoneClicked();
        stackView.pop();
    }

}


