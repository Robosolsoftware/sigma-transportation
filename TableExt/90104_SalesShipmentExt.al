tableextension 90254 SalesSHipmentExt extends "Sales Shipment Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Booking Ref No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
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
        field(50205; "Transport Area Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Area";
        }
    }

    var
        myInt: Integer;
}