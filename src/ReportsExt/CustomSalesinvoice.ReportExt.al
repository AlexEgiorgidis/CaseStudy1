namespace AlexEgiorgidis.CustomerName.SampleCore;

using Microsoft.Sales.History;

reportextension 50100 "Custom Sales invoice" extends "Standard Sales - Invoice"
{

    dataset
    {
        add(Header)
        {
            column(ShortCutDim2; "Shortcut Dimension 2 Code")
            { }
        }
    }
}
