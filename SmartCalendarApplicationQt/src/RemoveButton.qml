import QtQuick 2.0
import QtQuick.Controls 2.3

// a button that shows a trash icon to remove a list entry. Requires FontAwesome to be loaded in main.cpp
Button
{
    property ListModel listModel

    id : removeEntryButton
    text : "\uf2ed"
    font.family: "FontAwesome" // loaded via QFontDatabase in main.cpp

    Connections
    {
        target : removeEntryButton
        onClicked : listModel.remove(index)
    }
}
