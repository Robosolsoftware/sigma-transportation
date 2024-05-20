tableextension 90251 WarehouseSetupExt extends "Warehouse Setup"
{
    fields
    {
        // Add changes to table fields here
        field(90251; "Transportation Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(90252; "Posted Transportation Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(90253; "Default Location for Transport"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
    }

    var
        myInt: Integer;
}