pageextension 90251 PurchaseOrderCardExt extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Booking In Date"; Rec."Booking In Date")
            {
                ApplicationArea = All;
            }
            field("Booking In Time"; Rec."Booking In Time")
            {
                ApplicationArea = All;
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