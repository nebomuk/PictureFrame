import QtQuick 2.4

PictureTypeSelectionDialogForm {

    function modelIndexForText(text)
    {
        var model = tumbler.model;
        for(var i = 0; i < model.count; i++)
        {
            if(model.get(i).text === text)
            {
                return i;
            }
        }
        return -1;
    }

    function setCurrentText(text)
    {
        tumbler.currentIndex = modelIndexForText(text);
    }

}



