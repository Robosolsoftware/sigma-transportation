table 90254 "Posted Gate Entry Line"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No';
        }
        field(2; "Entry Type"; Option)
        {
            Description = 'Collection or Delivery';
            OptionCaption = ' ,Collection,Delivery';
            OptionMembers = " ",Collection,Delivery;
        }
        field(3; "Line No"; Integer)
        {
        }
        field(4; "Transportation Booked By"; Code[20])
        {
            CalcFormula = Lookup("Gate Entry Header"."Transportation Organized By" WHERE("No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(5; "Source No."; Code[20])
        {
            Caption = 'Source No.';
        }
        field(6; "Source Name"; Text[50])
        {
            Caption = 'Source Name';
            Editable = false;
        }
        field(7; "Order Address code"; Code[10])
        {
            Caption = 'Order Address code';
        }
        field(8; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(9; "Address 2"; Text[50])
        {
        }
        field(10; "Goods Checked"; Boolean)
        {
            Caption = 'Goods Checked';
        }
        field(11; "Goods Checked By"; Code[20])
        {
            Caption = 'Goods Checked By';
            Editable = false;
        }
        field(12; "Total Fridge Parcels"; Integer)
        {
        }
        field(13; "Sticker on Box"; Boolean)
        {
            Caption = 'Sticker on Box';
        }
        field(14; Scan; Boolean)
        {
            Caption = 'Scan';
        }
        field(15; "Supplier invoice No."; Code[20])
        {
            Caption = 'Supplier invoice No.';
        }
        field(16; "Expected Delivery/Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(17; "Actual Delivery/Receipt Date"; Date)
        {
        }
        field(18; "Carrier Quantity"; Decimal)
        {
            Caption = 'Carrier Quantity';
        }
        field(19; "Carrier UOM"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(20; City; Text[30])
        {
        }
        field(21; County; Text[30])
        {
        }
        field(22; "Post Code"; Code[20])
        {
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(23; "Country/Region Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(24; "Total Parcels (Ambient)"; Integer)
        {
        }
        field(25; "Total Weight (Ambient)"; Decimal)
        {
        }
        field(26; "Route Sequence No."; Integer)
        {
        }
        field(27; "Booking Reference No."; Code[20])
        {
        }
        field(28; "Source Type"; Option)
        {
            OptionCaption = ' ,Customer,Supplier';
            OptionMembers = " ",Customer,Supplier;
        }
        field(29; "Total Parcels (Fridge)"; Decimal)
        {
            Description = 'CAS-02164-V7H2Q5';
        }
        field(30; "Total Weight (Fridge)"; Decimal)
        {
            Description = 'CAS-02164-V7H2Q5';
        }
        field(31; "Total Parcels"; Decimal)
        {
            Description = 'CAS-02164-V7H2Q5';
        }
        field(32; "Total Weight"; Decimal)
        {
            Description = 'CAS-02164-V7H2Q5';
        }
        field(33; "Expected Delivery/Receipt Week"; Code[20])
        {
            Description = 'CAS-02164-V7H2Q5';
        }
        field(34; "Opening Time"; Time)
        {
            Description = 'CAS-02164-V7H2Q5';
        }
        field(35; "Ship To Code"; Code[20])
        {
            Description = 'CAS-02164-V7H2Q5';
        }
        field(42; "Document Type"; Option)
        {
            Description = 'CAS-06713-Z3X6T4';
            OptionCaption = ' ,Sales Order,Purchase Order,Transfer Order';
            OptionMembers = " ","Sales Order","Purchase Order","Transfer Order";
        }
        field(43; "Document no"; Code[20])
        {
            //Description = 'CAS-06713-Z3X6T4';
            Caption = 'PO No.';
        }
        field(44; "Total Pallet"; Decimal)
        {

        }
        field(53; "Transportation Receipt Status"; Option)
        {
            Caption = 'Transportation Receipt Status';
            OptionMembers = "Provisional","Transportation Booked","Goods Arrived","No Show","Fixed slot","Surprise PO","Suspend";
            OptionCaption = 'Provisional,Transportation Booked,Goods Arrived,No Show,Fixed slot,Surprise PO,Suspend';
        }
        field(54; "Source Document"; Option)
        {
            Caption = 'Source Document';
            OptionCaption = ' ,Sales Order,Purchase Order,Transfer Order';
            OptionMembers = " ","Sales Order","Purchase Order","Transfer Order";

        }
        field(55; "Warehouse Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Lifts"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Booked Lifts';

        }
        field(57; "Loose Boxes"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Booked Loose Boxes';
        }
        field(59; "Received Lifts"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Received Loose Boxes"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Received Pallets"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PurchHeader: Record 38;
        SalesShipHeader: Record 110;
        TransHeader: Record 5740;
        SalesHeader: Record 36;
        ReturnShipHeader: Record 6650;
        TransShptHeader: Record 5744;
        G_Cust: Record 18;
        G_Vend: Record 23;
        PostCode: Record 225;
}

