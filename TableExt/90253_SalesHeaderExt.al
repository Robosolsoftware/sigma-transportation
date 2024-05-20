tableextension 90253 SalesHeaderExtTrans extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(90251; "Booking Ref No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(90252; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(90253; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
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
        field(90256; "Transport Area Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Area";
        }
        field(90257; "Loading Date"; Date)//Pranali08012022_US7084
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}