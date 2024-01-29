pageextension 90258 WarehouseReceiptCardPageExt extends "Warehouse Receipt"
{
    layout
    {
        addafter("No.")
        {
            field("Transportation No."; rec."Transportation No.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}