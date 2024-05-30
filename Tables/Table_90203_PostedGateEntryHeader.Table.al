table 90253 "Posted Gate Entry Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No';

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    NoSeriesMgt.TestManual(WhseSetup."Transportation Nos.");
                    "No." := '';
                END;
            end;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(3; "Document Time"; Time)
        {
            Caption = 'Document Time';
        }
        field(4; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(5; "Shipping Agent Code"; Code[10])
        {
            TableRelation = "Shipping Agent";
        }
        field(7; "Transportation Organized By"; Code[20])
        {
            Editable = false;
        }
        field(8; "LR/RR No."; Code[10])
        {
        }
        field(9; "LR/RR Date"; Date)
        {
        }
        field(10; "Vehicle No."; Code[20])
        {
        }
        field(11; "Expected Delivery/Receipt Date"; Date)
        {
        }
        field(12; Status; Option)
        {
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(13; "Shipment Method Code"; Code[10])
        {
            TableRelation = "Shipment Method".Code;
        }
        field(14; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; "Shipping Agent Services Code"; Code[10])
        {
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(16; "Booking Reference No."; Code[20])
        {
        }
        field(17; "Vehicle Capacity(KG)"; Decimal)
        {
        }
        field(18; "Driver Name"; Text[50])
        {
        }
        field(19; "Driver Phone No."; Text[30])
        {
        }
        field(20; "Posting Date"; Date)
        {
        }
        field(21; "Gate Entry No."; Code[20])
        {
        }
        field(22; "Transportation No."; Code[20])
        {
        }
        field(23; "Total parcel Weight"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Parcel Details"."Net Weight" WHERE("Transportaion No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; Type; Option)
        {
            OptionCaption = ' ,Receipt,Delivery,CollectionFrom,ForCollection,Export';
            OptionMembers = " ",Receipt,Delivery,CollectionFrom,ForCollection,Export;
        }
        field(25; "Expected Delivery/Receipt Time"; Time)
        {
            Caption = 'Expected Delivery/Receipt Time';

            trigger OnValidate()
            begin
                /*TransportLine.RESET;
                TransportLine.SETRANGE(TransportLine."No.","No.");
                IF TransportLine.FINDFIRST THEN BEGIN
                 // IF NOT CONFIRM(STRSUBSTNO(Text001,FIELDCAPTION("Expected Delivery/Receipt Date")),TRUE) THEN  // NIK (CAS-06144-N0M6X7)
                 //   EXIT;
                  TransportLine.MODIFYALL(TransportLine."Expected Delivery/Receipt Date","Expected Delivery/Receipt Date");
                END;*/

            end;
        }
        field(26; "Avalaible Vehicle Capacity(KG)"; Decimal)
        {
        }
        field(27; "Slot No."; Integer)
        {
            Editable = false;
            TableRelation = "Slot Master"."Entry No";
        }
        field(28; Comments; Text[100])
        {
        }
        field(29; "Collection Date"; Date)
        {
        }
        field(30; "Collection Time"; Time)
        {
        }
        field(31; "Transport Booking Amount"; Decimal)
        {
        }
        field(34; "Carrier"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Requested Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Expected Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Expected Delivery Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Booked Pallets"; Decimal)
        {

            Editable = false;

        }
        field(39; "Lifts"; Decimal)
        {

            Editable = false;
            Caption = 'Booked Lifts';

        }
        field(40; "Loose Boxes"; Decimal)
        {

            Editable = false;
            Caption = 'Booked Loose Boxes';

        }
        field(41; "Curtain Side"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Actual Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Actual Receipt Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Receipt Status"; Option)
        {
            Caption = 'Transportation Receipt Status';
            OptionMembers = "Provisional","Transportation Booked","Goods Arrived","No Show","Fixed slot","Surprise PO","Suspend";
            OptionCaption = 'Provisional,Transportation Booked,Goods Arrived,No Show,Fixed slot,Surprise PO,Suspend';

        }
        field(47; "Received Lifts"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Received Loose Boxes"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Received Pallets"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document Date", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "Transportation Organized By" := USERID;
        "Document Date" := WORKDATE;
        "Document Time" := TIME;

        WhseSetup.GET;
        IF "No." = '' THEN BEGIN

            WhseSetup.TESTFIELD(WhseSetup."Transportation Nos.");
            NoSeriesMgt.InitSeries(WhseSetup."Transportation Nos.", xRec."No.", 0D, "No.", "No. Series");
        END;
    end;

    var
        recVendor: Record 23;
        RecCust: Record 18;
        NoSeriesMgt: Codeunit 396;
        SalesSetup: Record 311;
        WhseSetup: Record 5769;
}

