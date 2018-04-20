.pragma library


// Option combo boxes in the ui need to display a translated string
// but send the keywords "option1" .. "option3" to the smart calendar
// this is a simple mapping method
function mapToOption(index) {
    if(index === 0)
    {
        return "option1";
    }
    else if(index === 1)
    {
        return "option2";
    }
    else if(index === 2)
    {
        return "option3";
    }
    else
    {
        console.error("combo box option index must be in range 0..2, invalid index:  " + index);
        return "option1";
    }
}
