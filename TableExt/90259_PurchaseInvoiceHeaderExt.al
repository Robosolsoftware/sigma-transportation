tableextension 90259 PurchaseInvoiceHeaderExt extends "Purch. Inv. Header"
{
    fields
    {
        // Add changes to table fields here
        field(90251; "Transport Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(90252; "Transport Job Status"; Option)
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