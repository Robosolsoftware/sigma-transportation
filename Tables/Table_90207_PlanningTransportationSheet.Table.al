table 90257 "Planning Transportation Sheet"
{
    // DrillDownPageID = 50014;
    // LookupPageID = 50014;

    fields
    {
        field(2; "Entry Type"; Option)
        {
            Description = 'Collection or Delivery';
            OptionCaption = ' ,Collection,Delivery';
            OptionMembers = " ",Collection,Delivery;
        }
        field(3; "Line No."; Integer)
        {
        }
        field(5; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = IF ("Source Type" = FILTER(Customer)) Customer."No."
            ELSE
            IF ("Source Type" = FILTER(Supplier)) Vendor."No.";

            trigger OnValidate()
            begin
                ClearValues;
                CLEAR("Order Address/Ship To Code");
                IF "Source No." <> xRec."Source No." THEN
                    "Source Name" := '';
                IF "Source No." = '' THEN BEGIN
                    "Source Name" := '';
                    EXIT;
                END;
                CASE "Source Type" OF
                    "Source Type"::Customer:
                        BEGIN
                            G_Cust.GET("Source No.");
                            "Source Name" := G_Cust.Name;
                            Address := G_Cust.Address;
                            "Address 2" := G_Cust."Address 2";
                            City := G_Cust.City;
                            County := G_Cust.County;
                            "Post Code" := G_Cust."Post Code";
                            "Country/Region Code" := G_Cust."Country/Region Code";
                            "Opening Time" := G_Cust."Opening Time";
                            "Our Location Code" := G_Cust."Location Code";
                        END;
                    "Source Type"::Supplier:
                        BEGIN
                            G_Vend.GET("Source No.");
                            "Source Name" := G_Vend.Name;
                            Address := G_Vend.Address;
                            "Address 2" := G_Vend."Address 2";
                            City := G_Vend.City;
                            County := G_Vend.County;
                            "Post Code" := G_Vend."Post Code";
                            "Country/Region Code" := G_Vend."Country/Region Code";
                            "Our Location Code" := G_Vend."Location Code";
                        END;
                END;
            end;
        }
        field(6; "Source Name"; Text[50])
        {
            Caption = 'Source Name';
        }
        field(7; "Order Address/Ship To Code"; Code[10])
        {
            Caption = 'Order Address/Ship To Code';
            TableRelation = IF ("Source Type" = CONST(Supplier)) "Order Address".Code WHERE("Vendor No." = FIELD("Source No."))
            ELSE
            IF ("Source Type" = CONST(Customer)) "Ship-to Address".Code WHERE("Customer No." = FIELD("Source No."));

            trigger OnValidate()
            var
                OrderAddr: Record 224;
                ShipToAddr: Record 222;
            begin
                ClearValues;
                CASE "Source Type" OF
                    "Source Type"::Supplier:
                        BEGIN
                            IF "Order Address/Ship To Code" <> '' THEN BEGIN
                                OrderAddr.GET("Source No.", "Order Address/Ship To Code");
                                "Source Name" := OrderAddr.Name;
                                //"Buy-from Vendor Name 2" := OrderAddr."Name 2";
                                Address := OrderAddr.Address;
                                "Address 2" := OrderAddr."Address 2";
                                City := OrderAddr.City;
                                "Post Code" := OrderAddr."Post Code";
                                County := OrderAddr.County;
                                "Country/Region Code" := OrderAddr."Country/Region Code";
                            END;
                        END;
                    "Source Type"::Customer:
                        BEGIN
                            IF ShipToAddr.GET("Source No.", "Order Address/Ship To Code") THEN BEGIN
                                "Source Name" := ShipToAddr.Name;
                                //"Ship-to Name 2" := ShipToAddr."Name 2";
                                Address := ShipToAddr.Address;
                                "Address 2" := ShipToAddr."Address 2";
                                City := ShipToAddr.City;
                                "Post Code" := ShipToAddr."Post Code";
                                County := ShipToAddr.County;
                                "Country/Region Code" := ShipToAddr."Country/Region Code";
                                "Opening Time" := ShipToAddr."Opening Time";
                                "Our Location Code" := G_Cust."Location Code";
                            END;
                        END;
                END;
            end;
        }
        field(8; Address; Text[50])
        {
            Caption = 'Address';
            Editable = false;

            trigger OnValidate()
            var
                OrderAddr: Record 224;
            begin
            end;
        }
        field(9; "Address 2"; Text[50])
        {
            Editable = false;
        }
        field(15; "Supplier invoice No."; Code[20])
        {
            Caption = 'Supplier invoice No.';
        }
        field(16; "Expected Delivery/Receipt Date"; Date)
        {
            Caption = 'Expected Delivery/Receipt Date';
        }
        field(18; "Carrier Quantity"; Decimal)
        {
            BlankZero = true;
            Caption = 'Carrier Quantity';
        }
        field(19; "Carrier UOM"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(20; City; Text[30])
        {
            Editable = false;
        }
        field(21; County; Text[30])
        {
            Editable = false;
        }
        field(22; "Post Code"; Code[20])
        {
            Editable = false;
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
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(27; "Booking Reference No."; Code[20])
        {
        }
        field(28; "Source Type"; Option)
        {
            OptionCaption = ' ,Customer,Supplier';
            OptionMembers = " ",Customer,Supplier;

            trigger OnValidate()
            begin
                CLEAR("Source No.");
                CLEAR("Order Address/Ship To Code");
                ClearValues;
            end;
        }
        field(31; "Total Parcels"; Decimal)
        {
            BlankZero = true;
            Description = 'CAS-02164-V7H2Q5';
        }
        field(32; "Total Weight(KG)"; Decimal)
        {
            BlankZero = true;
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
        field(35; "Our Location Code"; Code[10])
        {
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Entry Type", "Source Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        G_Cust: Record 18;
        G_Vend: Record 23;
        PostCode: Record 225;
        TransH: Record "Gate Entry Header";
        Customer: Record 18;
        ShipToAddress: Record 222;
        ParcelDetails: Record "Parcel Details";

    local procedure GetHeader()
    begin
    end;

    //[Scope('Internal')]
    procedure ScheduleSelectedLines(PlanningLines: Record "Planning Transportation Sheet"; DocNo: Code[20]; Line: Integer)
    var
        TranporationLines1: Record "Gate Entry Line";
        ParcelDetails: Record "Parcel Details";
        Line1: Integer;
        ParcelDetails1: Record "Parcel Details";
    begin
        IF TransH."No." <> DocNo THEN
            TransH.GET(DocNo);
        TranporationLines1.INIT;
        TranporationLines1.VALIDATE("No.", DocNo);
        TranporationLines1.VALIDATE("Line No.", Line);
        TranporationLines1.VALIDATE("Entry Type", PlanningLines."Entry Type");
        TranporationLines1.VALIDATE("Source Type", PlanningLines."Source Type");
        TranporationLines1.VALIDATE("Source No.", PlanningLines."Source No.");
        TranporationLines1.VALIDATE("Booking Reference No.", TransH."Booking Reference No.");
        IF TransH."Expected Delivery/Receipt Date" = 0D THEN
            TranporationLines1.VALIDATE("Expected Delivery/Receipt Date", PlanningLines."Expected Delivery/Receipt Date")
        ELSE
            TranporationLines1.VALIDATE("Expected Delivery/Receipt Date", TransH."Expected Delivery/Receipt Date");
        TranporationLines1.VALIDATE("Expected Delivery/Receipt Week", PlanningLines."Expected Delivery/Receipt Week");
        TranporationLines1.VALIDATE("Carrier Quantity", PlanningLines."Carrier Quantity");
        TranporationLines1.VALIDATE("Carrier UOM", PlanningLines."Carrier UOM");
        //TranporationLines1.VALIDATE("Total Weight (Ambient)",planninglines."Total Weight (Ambient)");
        //TranporationLines1.VALIDATE("Total Weight (Fridge)",Planninglines."Total Weight (Fridge)");
        //TranporationLines1.VALIDATE("Total Parcels",PlanningLines."Total Parcels");
        //TranporationLines1.VALIDATE("Total Weight(KG)",PlanningLines."Total Weight(KG)");
        TranporationLines1.INSERT(TRUE);
        Line1 := 0;
        ParcelDetails1.RESET;
        ParcelDetails1.SETFILTER("Transportaion No.", '%1', 'Planned');
        ParcelDetails1.SETRANGE("Transportaion Line No.", PlanningLines."Line No.");
        //ParcelDetails1.SETRANGE("Line Type",1);
        IF ParcelDetails1.FINDFIRST THEN
            REPEAT
                Line1 += 10000;
                ParcelDetails.INIT;
                ParcelDetails."Transportaion No." := TranporationLines1."No.";
                ParcelDetails."Transportaion Line No." := TranporationLines1."Line No.";
                ParcelDetails."Line No." := Line1;
                ParcelDetails.INSERT(TRUE);
                ParcelDetails."Entry Type" := ParcelDetails1."Entry Type";
                ParcelDetails."Source Type" := ParcelDetails1."Source Type";
                ParcelDetails."Source No." := ParcelDetails1."Source No.";
                ParcelDetails."Document Type" := ParcelDetails1."Document Type";
                ParcelDetails."Document No." := ParcelDetails1."Document No.";
                ParcelDetails."Parcel UOM" := ParcelDetails1."Parcel UOM";
                ParcelDetails."Parcel Quantity" := ParcelDetails1."Parcel Quantity";
                ParcelDetails."Parcel UID" := ParcelDetails1."Parcel UID";
                ParcelDetails."Parcel Type" := ParcelDetails1."Parcel Type";
                ParcelDetails."Net Weight" := ParcelDetails1."Net Weight";
                ParcelDetails."Booking Reference No" := ParcelDetails1."Booking Reference No";
                ParcelDetails.MODIFY(TRUE);
                ParcelDetails1.DELETE;
            UNTIL ParcelDetails1.NEXT = 0;

        PlanningLines.DELETE(TRUE);
    end;

    local procedure ClearValues()
    begin
        CLEAR("Source Name");
        CLEAR(Address);
        CLEAR("Address 2");
        CLEAR(City);
        CLEAR("Post Code");
        CLEAR("Country/Region Code");
        CLEAR("Opening Time");
    end;
}

