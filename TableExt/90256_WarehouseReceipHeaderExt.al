tableextension 90256 WarehouseReceipHeaderExt extends "Warehouse Receipt Header"
{
    fields
    {
        field(90251; "Transportation No."; Code[20])
        {

            // FieldClass = FlowField;
            // CalcFormula = sum("Gate Entry Header"."No." where )

        }
        field(90252; "Transportation Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Open,Released,"In-Progress";
            OptionCaption = ' ,Open,Released,In-Progress';
            Editable = false;
        }
        // field(90253; "Purchase Order No."; Text[50])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(90254; "Purchase Order Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(90255; "PO Expected Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(90256; "No. of Products"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        // field(90257; "Total Order Qty"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(90258; CD; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes,No;
        }
        field(90259; "CD Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}