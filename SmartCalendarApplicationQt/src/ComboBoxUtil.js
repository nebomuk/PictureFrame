.pragma library


// attempts to find the given text in the comboBox and sets it as the current text
function setInitialText(comboBox,text)
{
    var index = comboBox.find(text,Qt.MatchFixedString);
    if(index > -1)
    {
        comboBox.currentIndex = index;
    }
    else
    {
        console.warn("Could not set currentText because it does not exist in the model: " + text);
    }
}
