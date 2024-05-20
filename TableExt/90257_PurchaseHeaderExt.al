tableextension 90257 PurchaseHeaderExtTrans extends "Purchase Header"
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
        field(90253; "Booking In Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Gate Entry Line"."Expected Delivery/Receipt Date" WHERE("Document no" = FIELD("No."), "Document Type" = CONST("Purchase Order"), Status = CONST(Released)));

        }
        field(90254; "Booking In Time"; Time)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Gate Entry Line"."Expected Delivery/Receipt Time" WHERE("Document no" = FIELD("No."), "Document Type" = CONST("Purchase Order"), Status = CONST(Released)));
        }
        field(90255; "Transportation No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(90256; "Receipt Status"; Text[50])
        {
            // Caption = 'Transportation Receipt Status';
            // OptionMembers = " ","Transportation Booked","Goods Arrived","Goods Not Shownup","GRN In Progress",Closed;
            // OptionCaption = ' ,Transportation Booked,Goods Arrived,Goods Not Shownup,GRN In Progress,Closed';
        }
    }

    var
        myInt: Integer;
}