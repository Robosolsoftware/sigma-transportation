tableextension 90261 ShipToAddressExt extends "Ship-to Address"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Opening Time"; Time)
        {
            DataClassification = ToBeClassified; //Prathamesh++
        }
    }

    var
        myInt: Integer;
}