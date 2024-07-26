namespace AlexEgiorgidis.CustomerName.SampleCore;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Availability;

pageextension 50100 "Custom Sales Order Line" extends "Sales Order Subform"
{

    layout
    {
        addafter(quantity)
        {
            field(TotalInventoryFlowfield; Rec.TotalInventoryFlowfield)
            {
                ApplicationArea = all;
                Caption = 'TotalInventoryFlowfield';
            }

            field(TotalInventory; TotalInventoryLocal)
            {
                ApplicationArea = all;
                Caption = 'Total Inventory';
                Editable = false;
            }
            field(InventoryAndPendingMinusPromised; (Item.Inventory + Item."Qty. on Purch. Order") - Item."Qty. on Sales Order")
            {
                ApplicationArea = all;
                Caption = 'Inventory with PO minus SO';
                Editable = false;
            }
            field(TotalInventory2; CalcInventory)
            {
                ApplicationArea = all;
                Caption = 'Inventory with PO minus SO-2';
                Editable = false;
            }
            field(TotalInventoryPlusPOMinusSO; Rec.TotalInventoryPlusPOMinusSO)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Item Availability"; SalesInfoPaneMgt.CalcAvailability(Rec))
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Availability - COPYBASIC';
                DecimalPlaces = 0 : 5;
                DrillDown = true;
                ToolTip = 'Specifies how may units of the item on the sales line are available, in inventory or incoming before the shipment date.';

                trigger OnDrillDown()
                begin
                    ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByEvent());
                    CurrPage.Update(true);
                end;
            }
            field("Available Inventory"; SalesInfoPaneMgt.CalcAvailableInventory(Rec))
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Available Inventory - COPYBASIC';
                DecimalPlaces = 0 : 5;
                ToolTip = 'Specifies the quantity of the item that is currently in inventory and not reserved for other demand.';
            }
        }
    }

    trigger OnOpenPage()
    begin
        repeat
            if (Rec.Type = Rec.Type::Item) and (Rec."Document Type" = Rec."Document Type"::Order) then begin
                Item.Get(Rec."No.");
                Item.Calcfields(Inventory, "Qty. on Purch. Order", "Qty. on Sales Order");
                Rec.TotalInventoryPlusPOMinusSO := (Item.Inventory + Item."Qty. on Purch. Order") - Item."Qty. on Sales Order";
                Rec.Modify(false);
            end;
        until Rec.Next() = 0;
    end;



    trigger OnAfterGetRecord()
    begin
        if (Rec.Type = Rec.Type::Item) and (Rec."Document Type" = Rec."Document Type"::Order) then begin
            Item.Get(Rec."No.");
            Item.Calcfields(Inventory, "Qty. on Purch. Order", "Qty. on Sales Order");
            CustomCalculateInventory();
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if (Rec.Type = Rec.Type::Item) and (Rec."Document Type" = Rec."Document Type"::Order) then begin
            Item.Get(Rec."No.");
            Item.Calcfields(Inventory, "Qty. on Purch. Order", "Qty. on Sales Order");
            CustomCalculateInventory();
        end;
    end;

    local procedure CustomCalculateInventory()
    begin
        TotalInventoryLocal := 0;
        CalcInventory := 0;
        TotalInventoryLocal := item.Inventory;
        CalcInventory := (Item.Inventory + Item."Qty. on Purch. Order") - Item."Qty. on Sales Order";
    end;

    var
        Item: record Item;
        TotalInventoryLocal, CalcInventory : decimal;

    protected var
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";


}
