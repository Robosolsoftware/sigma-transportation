tableextension 90262 TransferLineExt1 extends "Transfer Line"
{
    fields
    {
        // Add changes to table fields here
        field(50014; Pallet; Decimal)
        {
            DataClassification = ToBeClassified; //Prathamesh++
        }
    }

    var
        myInt: Integer;
}