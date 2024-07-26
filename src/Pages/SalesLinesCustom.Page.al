namespace AlexEgiorgidis.CustomerName.SampleCore;

using Microsoft.Sales.Document;

page 50100 "Sales Lines Custom"
{
    ApplicationArea = All;
    Caption = 'Sales Lines Custom';
    PageType = List;
    SourceTable = "Sales Line";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the type of document that you are about to create.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the line type.';
                }
            }
        }
    }
}
