namespace AlexEgiorgidis.CustomerName.SampleCore;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;

tableextension 50100 "Cust Sales Line" extends "Sales Line"
{
    fields
    {
        field(50100; TotalInventoryFlowfield; Decimal)
        {
            Caption = 'Total Inventory- flowfield1';
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Location Code" = field("Location Code"),
                                                                  "Drop Shipment" = field("Drop Shipment"),
                                                                  "Variant Code" = field("Variant Code"),
                                                                  "Unit of Measure Code" = field("Unit of Measure Code")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }

        field(50101; InventoryPlusPO; Decimal)
        {
            Caption = 'CalculatedInventory';
            CalcFormula = sum(Item."Qty. on Purch. Order" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50102; InventoryMinusSO; Decimal)
        {
            Caption = 'CalculatedInventory';
            CalcFormula = sum(Item."Qty. on Sales Order" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50103; TotalInventoryPlusPOMinusSO; Decimal)
        {
            Caption = 'CalculatedInventory with Sorting and Filtering';
        }
    }
}
