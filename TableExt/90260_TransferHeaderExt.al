tableextension 90260 TransferHeaderExt1 extends "Transfer Header"
{
    fields
    {
        field(90254; "Transport Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(90255; "Transport Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Open,Released,"In-Progress";
            OptionCaption = ' ,Open,Released,In-Progress';
            Editable = false;
        }
    }

    var
        myInt: Integer;
        test: record 7317;
        test1: Page 5769;
}