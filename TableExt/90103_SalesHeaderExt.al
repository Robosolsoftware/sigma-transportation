tableextension 90253 SalesHeaderExtTrans extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50207; "Booking Ref No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50208; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50209; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50202; "Transport Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50203; "Transport Status"; Option)
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
        field(50206; "Loading Date"; Date)//Pranali08012022_US7084
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}