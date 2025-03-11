tableextension 90263 PurchaseOrderLineExt extends "Purchase Line"
{
    fields
    {
        field(90251; "Transportation No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(90252; "Receipt Status"; Text[50])
        {
            Caption = 'Transportation Receipt Status';
            // OptionMembers = " ","Transportation Booked","Goods Arrived","Goods Not Shownup","GRN In Progress",Closed;
            // OptionCaption = ' ,Transportation Booked,Goods Arrived,Goods Not Shownup,GRN In Progress,Closed';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}