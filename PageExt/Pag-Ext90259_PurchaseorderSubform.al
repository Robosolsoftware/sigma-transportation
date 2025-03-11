pageextension 90259 PurchaseOrderSubformEXT extends "Purchase Order Subform"
{
    layout
    {
        addafter(Description)
        {
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