pageextension 90258 WarehouseReceiptCardPageExt extends "Warehouse Receipt"
{
    layout
    {
        addafter("No.")
        {
            field("Transportation No."; rec."Transportation No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Receipt Status"; rec."Receipt Status")
            {
                ApplicationArea = all;
                Editable = false;
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