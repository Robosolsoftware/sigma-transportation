pageextension 90257 WarehouseReceiptListPageExt extends "Warehouse Receipts"
{
    layout
    {
        addafter("No.")
        {
            //     field("Transportation No."; rec."Transportation No.")
            //     {
            //         ApplicationArea = all;
            //     }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}