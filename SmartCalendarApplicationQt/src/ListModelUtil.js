.pragma library


function sortModel(listModel, compareFunctionWithTwoListItems)
{
    var n;
    var i;
    for (n=0; n < listModel.count; n++)
        for (i=n+1; i < listModel.count; i++)
        {
            if (compareFunctionWithTwoListItems(listModel.get(n),listModel.get(i)))
            {
                listModel.move(i, n, 1);
                n=0;
            }
        }
}
