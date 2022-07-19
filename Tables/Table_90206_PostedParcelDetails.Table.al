table 90256 "Posted Parcel Details"
{

    fields
    {
        field(1; "Transportaion No."; Code[20])
        {
        }
        field(2; "Entry Type"; Option)
        {
            Description = 'Collection or Delivery';
            OptionCaption = ' ,Collection,Delivery';
            OptionMembers = " ",Collection,Delivery;
        }
        field(3; "Line No."; Integer)
        {
        }
        field(4; "Source Type"; Option)
        {
            OptionCaption = ' ,Customer,Supplier';
            OptionMembers = " ",Customer,Supplier;
        }
        field(5; "Source No."; Code[20])
        {
        }
        field(6; "Document Type"; Option)
        {
            OptionCaption = ',Purchase Order,Purchase Return Order,Sales Order,Sales Return Order,Transfer Order';
            OptionMembers = ,"Purchase Order","Purchase Return Order","Sales Order","Sales Return Order","Transfer Order";
        }
        field(7; "Order No."; Code[20])
        {
        }
        field(8; "Parcel UOM"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(9; "Parcel Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
        }
        field(10; "Parcel UID"; Code[20])
        {
        }
        field(11; "Parcel Type"; Option)
        {
            Description = 'Fridge or Ambient';
            OptionCaption = ' ,Fridge,Ambient';
            OptionMembers = " ",Fridge,Ambient;
        }
        field(12; "Net Weight"; Decimal)
        {
        }
        field(13; "Transportaion Line No."; Integer)
        {
        }
        field(14; "Booking Reference No"; Code[20])
        {
            Description = 'CAS-02164-V7H2Q5';
        }
    }

    keys
    {
        key(Key1; "Transportaion No.", "Transportaion Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PackageDetail: Record "Parcel Details";
        TransLine: Record "Gate Entry Line";

    //[Scope('Internal')]
    procedure UpdateWeight()
    var
        L_Totqty: Decimal;
    begin

        PackageDetail.RESET;
        PackageDetail.SETRANGE("Transportaion No.", "Transportaion No.");
        PackageDetail.SETRANGE("Transportaion Line No.", "Transportaion Line No.");
        IF PackageDetail.FINDFIRST THEN
            REPEAT
                L_Totqty += PackageDetail."Net Weight";
            UNTIL PackageDetail.NEXT = 0;
        IF TransLine.GET("Transportaion No.", "Transportaion Line No.") THEN BEGIN
            TransLine."Total Weight (Ambient)" := L_Totqty;
            TransLine.MODIFY;
        END;
    end;
}

