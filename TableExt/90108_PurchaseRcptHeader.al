tableextension 90258 PostedPurchaseReceiptExt extends "Purch. Rcpt. Header"
{
    fields
    {
        // Add changes to table fields here
        field(50202; "Transport Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50203; "Transport Job Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Open,Released,"In-Progress";
            OptionCaption = ' ,Open,Released,In-Progress';
            Editable = false;
        }
    }

    var
        myInt: Integer;
}