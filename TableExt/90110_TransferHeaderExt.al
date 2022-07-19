tableextension 90260 TransferHeaderExt extends "Transfer Header"
{
    fields
    {
        field(50000; "Transport Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Transport Status"; Option)
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