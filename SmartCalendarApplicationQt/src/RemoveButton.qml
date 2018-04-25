import QtQuick 2.0
import QtQuick.Controls 2.3
import de.vitecvisual.util 1.0;

// a button that shows a trash icon to remove a list entry. Requires FontAwesome to be loaded in main.cpp
Button
{
    property ListModel listModel

    id : removeEntryButton
    icon.source : "qrc:/icon/trash.svg"


    Connections
    {
        target : removeEntryButton
        onClicked : listModel.remove(index)
    }
}
