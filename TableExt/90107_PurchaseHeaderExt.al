tableextension 90257 PurchaseHeaderExtTrans extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here
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
        field(50205; "Booking In Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Gate Entry Line"."Expected Delivery/Receipt Date" WHERE("Document no" = FIELD("No."), "Document Type" = CONST("Purchase Order"), Status = CONST(Released)));

        }
        field(50206; "Booking In Time"; Time)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Gate Entry Line"."Expected Delivery/Receipt Time" WHERE("Document no" = FIELD("No."), "Document Type" = CONST("Purchase Order"), Status = CONST(Released)));
        }
    }

    var
        myInt: Integer;
}