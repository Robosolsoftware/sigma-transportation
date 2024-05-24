table 90252 "Gate Entry Line"
{
    DrillDownPageID = "Transportation SubForm";
    LookupPageID = "Transportation SubForm";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No';
        }
        field(2; "Entry Type"; Option)
        {
            Description = 'Collection or Delivery';
            OptionCaption = ' ,Receipt,Delivery,CollectionFrom,ForCollection,Export';
            OptionMembers = " ",Receipt,Delivery,CollectionFrom,ForCollection,Export;

            // trigger OnValidate()
            // begin
            //     IF "Expected Delivery/Receipt Date" = 0D THEN BEGIN
            //         GetHeader;
            //         "Expected Delivery/Receipt Date" := TransH."Expected Delivery/Receipt Date";
            //     END;
            //     IF "Booking Reference No." = '' THEN BEGIN
            //         GetHeader;
            //         "Booking Reference No." := TransH."Booking Reference No.";
            //     END;
            // end;
        }
        field(3; "Line No."; Integer)
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
            Caption = 'Vendor No.';
            TableRelation = IF ("Source Type" = FILTER(Customer)) Customer."No."
            ELSE
            IF ("Source Type" = FILTER(Supplier)) Vendor."No."
            ELSE
            IF ("Source Type" = CONST("Outbound Transfer")) "Transfer Header"."No.";

            trigger OnValidate()
            begin
                // Manish ++
                ParcelDetails.RESET;
                ParcelDetails.SETRANGE("Transportaion No.", "No.");
                ParcelDetails.SETRANGE("Transportaion Line No.", "Line No.");
                IF NOT ParcelDetails.ISEMPTY THEN
                    ERROR('You can not change the Source No if Parcel details already exist');

                // Manish --

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
                            // "Opening Time" := G_Cust."Opening Time";

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
                        END;
                END;
            end;
        }
        field(6; "Source Name"; Text[50])
        {
            Caption = 'Vendor  Name';
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
        field(12; "Total Fridge Parcels"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Parcel Details"."Parcel Quantity" WHERE("Transportaion No." = FIELD("No."),
                                                                        "Transportaion Line No." = FIELD("Line No."),
                                                                        "Parcel Type" = FILTER(Fridge)));
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
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
            Caption = 'Expected Delivery/Receipt Date';
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
        field(24; "Total Parcels (Ambient)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Parcel Details"."Parcel Quantity" WHERE("Transportaion No." = FIELD("No."),
                                                                        "Transportaion Line No." = FIELD("Line No."),
                                                                        "Parcel Type" = FILTER(Ambient)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Total Weight (Ambient)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Parcel Details"."Net Weight" WHERE("Transportaion No." = FIELD("No."),
                                                                   "Transportaion Line No." = FIELD("Line No."),
                                                                   "Parcel Type" = FILTER(Ambient)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Route Sequence No."; Integer)
        {
            BlankZero = true;

            // trigger OnValidate()
            // begin
            //     IF "Expected Delivery/Receipt Date" = 0D THEN BEGIN
            //         GetHeader;
            //         "Expected Delivery/Receipt Date" := TransH."Expected Delivery/Receipt Date";
            //     END;
            //     IF "Booking Reference No." = '' THEN BEGIN
            //         GetHeader;
            //         "Booking Reference No." := TransH."Booking Reference No.";
            //     END;
            // end;
        }
        field(27; "Booking Reference No."; Code[20])
        {
        }
        field(28; "Source Type"; Option)
        {
            OptionCaption = ' ,Customer,Supplier,Export,Outbound Transfer';
            OptionMembers = " ",Customer,Supplier,Export,"Outbound Transfer";
        }
        field(29; "Total Parcels (Fridge)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Parcel Details"."Parcel Quantity" WHERE("Transportaion No." = FIELD("No."),
                                                                        "Transportaion Line No." = FIELD("Line No."),
                                                                        "Parcel Type" = FILTER(Fridge)));
            Description = 'CAS-02164-V7H2Q5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Total Weight (Fridge)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Parcel Details"."Net Weight" WHERE("Transportaion No." = FIELD("No."),
                                                                   "Transportaion Line No." = FIELD("Line No."),
                                                                   "Parcel Type" = FILTER(Fridge)));
            Description = 'CAS-02164-V7H2Q5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Total Parcels(Booked)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Parcel Details"."Parcel Quantity" WHERE("Transportaion No." = FIELD("No."),
                                                                        "Transportaion Line No." = FIELD("Line No.")));
            Description = 'CAS-02164-V7H2Q5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Total Weight(KG)(Booked)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Parcel Details"."Net Weight" WHERE("Transportaion No." = FIELD("No."),
                                                                   "Transportaion Line No." = FIELD("Line No.")));
            Description = 'CAS-02164-V7H2Q5';
            Editable = false;
            FieldClass = FlowField;
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
            TableRelation = IF ("Source Type" = FILTER(Customer)) "Ship-to Address".Code WHERE("Customer No." = FIELD("Source No."));

            trigger OnValidate()
            begin
                // Manish ++
                ShipToAddress.RESET;
                ShipToAddress.SETRANGE(Code, "Ship To Code");
                ShipToAddress.SETRANGE("Customer No.", "Source No.");
                IF ShipToAddress.FINDFIRST THEN
                    "Opening Time" := ShipToAddress."Opening Time";


                // Manish --
            end;
        }
        field(36; Type; Option)
        {
            OptionCaption = 'Schedule,Plan';
            OptionMembers = Schedule,Plan;
        }
        field(37; "Total Parcels(Planned)"; Decimal)
        {
            BlankZero = true;
            Description = 'CAS-02164-V7H2Q5';
            Editable = false;
        }
        field(38; "Total Weight(KG)(Planned)"; Decimal)
        {
            BlankZero = true;
            Description = 'CAS-02164-V7H2Q5';
            Editable = false;
        }
        field(39; "Activity Code"; Option)
        {
            Description = 'CAS-06145-G7N3X3';
            OptionCaption = ' ,Cash Collection,Document Check';
            OptionMembers = " ","Cash Collection","Document Check";
        }
        field(40; "Amount to Collect"; Decimal)
        {
            Description = 'CAS-06145-G7N3X3';
        }
        field(41; "Amount Collected"; Decimal)
        {
            Description = 'CAS-06145-G7N3X3';
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
        field(45; "Expected Delivery/Receipt Time"; Time)
        {
            Caption = 'Expected Delivery/Receipt Date';
        }
        field(46; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Released,Closed';
            OptionMembers = Open,Released,Closed;
        }
        field(47; "Amount Confirmed"; Decimal)
        {
        }
        field(48; "Purchaser /Sales Person"; Code[10])
        {
            Description = 'CAS-07316-C6P4H7';
        }
        field(49; "Location code"; Code[20])
        {
            CalcFormula = Lookup("Gate Entry Header"."Location Code" WHERE("No." = FIELD("No.")));
            Description = 'CAS-07316-C6P4H7';
            FieldClass = FlowField;
        }
        field(50; "Qty-Case"; Decimal)
        {
            Caption = 'Case(Qty)';
            Description = 'CAS-07316-C6P4H7';
        }
        field(51; "Qty-Pallet"; Decimal)
        {
            Caption = 'Pallet(Qty)';
            DecimalPlaces = 0 : 2;
            Description = 'CAS-07316-C6P4H7';
        }
        field(52; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(53; "Transportation Receipt Status"; Option)
        {
            Caption = 'Transportation Receipt Status';
            OptionMembers = "Provisional","Transportation Booked","Goods Arrived","No Shown","Fixed slot","Surprise PO","Suspend";
            OptionCaption = 'Provisional,Transportation Booked,Goods Arrived,No Shown,Fixed slot,Surprise PO,Suspend';
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
        field(58; "Requested Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Route Sequence No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        t: Record "Warehouse Receipt Line";
    begin
        OnDeleteTransportLine;
    end;

    trigger OnModify()
    begin
        // NIK 10-8-17
        /*PurchaseHeader.RESET;
        PurchaseHeader.SETRANGE("Document Type",GateEntryLine."Document Type");
        PurchaseHeader.SETRANGE("No.",GateEntryLine."Document no");
        IF PurchaseHeader.FINDFIRST THEN BEGIN
          PurchaseHeader.VALIDATE("Transport Job Status",GateEntryLine.Status);
          PurchaseHeader.VALIDATE("Transport Job No.",GateEntryLine."No.");
          PurchaseHeader.MODIFY(TRUE);
        END;
        */
        // NIK 10-8-17 END

    end;

    var
        G_Cust: Record 18;
        G_Vend: Record 23;
        PostCode: Record 225;
        TransH: Record "Gate Entry Header";
        Customer: Record 18;
        ShipToAddress: Record 222;
        ParcelDetails: Record "Parcel Details";
        i: Integer;
        PurchaseHeader: Record 38;
        GateEntryLine: Record "Gate Entry Line";
        Text001: Label 'The %1 cannot be deleted when a related %2 exists.';

    local procedure GetHeader()
    begin
        IF ("No." <> TransH."No.") THEN
            TransH.GET("No.");
    end;

    //[Scope('Internal')]
    procedure MoveLinesInPlanningSheet(TransportationLine: Record "Gate Entry Line")
    var
        PlanningLines: Record "Planning Transportation Sheet";
        PlanningLines1: Record "Planning Transportation Sheet";
        LineNo: Integer;
        ParcelDetails: Record "Parcel Details";
        ParcelDetails1: Record "Parcel Details";
        Line1: Integer;
        recTPH: Record "Gate Entry Header";
    begin
        IF PlanningLines1.FINDLAST THEN
            LineNo := PlanningLines1."Line No."
        ELSE
            LineNo := 0;
        LineNo += 10000;
        PlanningLines.INIT;
        PlanningLines.VALIDATE("Line No.", LineNo);
        PlanningLines.VALIDATE("Entry Type", TransportationLine."Entry Type");
        PlanningLines.VALIDATE("Source Type", TransportationLine."Source Type");
        PlanningLines.VALIDATE("Source No.", TransportationLine."Source No.");
        PlanningLines.VALIDATE("Booking Reference No.", TransportationLine."Booking Reference No.");
        PlanningLines.VALIDATE("Expected Delivery/Receipt Date", TransportationLine."Expected Delivery/Receipt Date");
        PlanningLines.VALIDATE("Expected Delivery/Receipt Week", TransportationLine."Expected Delivery/Receipt Week");
        PlanningLines.VALIDATE("Carrier Quantity", TransportationLine."Carrier Quantity");
        PlanningLines.VALIDATE("Carrier UOM", TransportationLine."Carrier UOM");
        PlanningLines.VALIDATE("Total Parcels", TransportationLine."Total Parcels(Booked)");
        PlanningLines.VALIDATE("Total Weight(KG)", TransportationLine."Total Weight(KG)(Booked)");

        PlanningLines.INSERT(TRUE);
        IF recTPH.GET(TransportationLine."No.") THEN
            PlanningLines."Our Location Code" := recTPH."Location Code";
        PlanningLines.MODIFY;
        ParcelDetails1.RESET;
        ParcelDetails1.SETFILTER("Transportaion No.", TransportationLine."No.");
        ParcelDetails1.SETRANGE("Transportaion Line No.", TransportationLine."Line No.");
        //ParcelDetails1.SETRANGE("Line Type",2);
        IF ParcelDetails1.FINDFIRST THEN
            REPEAT
                Line1 += 10000;
                ParcelDetails.INIT;
                ParcelDetails."Transportaion No." := 'Planned';
                ParcelDetails."Transportaion Line No." := PlanningLines."Line No.";
                ParcelDetails."Line No." := Line1;
                ParcelDetails.INSERT(TRUE);
                //ParcelDetails."Line Type":=1;
                ParcelDetails."Entry Type" := ParcelDetails1."Entry Type";
                ParcelDetails."Source Type" := ParcelDetails1."Source Type";
                ParcelDetails."Source No." := ParcelDetails1."Source No.";
                ParcelDetails."Document Type" := ParcelDetails1."Document Type";
                ParcelDetails."Document No." := ParcelDetails1."Document No.";
                //ParcelDetails."Document No":=ParcelDetails1."Document No";
                ParcelDetails."Parcel UOM" := ParcelDetails1."Parcel UOM";
                ParcelDetails."Parcel Quantity" := ParcelDetails1."Parcel Quantity";
                ParcelDetails."Parcel UID" := ParcelDetails1."Parcel UID";
                ParcelDetails."Parcel Type" := ParcelDetails1."Parcel Type";
                ParcelDetails."Net Weight" := ParcelDetails1."Net Weight";
                ParcelDetails."Booking Reference No" := ParcelDetails1."Booking Reference No";
                ParcelDetails.MODIFY(TRUE);

                //ParcelDetails.MODIFY(TRUE);
                ParcelDetails1.DELETE;
            UNTIL ParcelDetails1.NEXT = 0;

        TransportationLine.DELETE(TRUE);
    end;

    local procedure OnDeleteTransportLine()
    var
        SalesHeader: Record 36;
        PurchaseHeader: Record 38;
        TransferHeader: Record 5740;
    begin
        //Chandan------------------Case:CAS-08450-F6Z7J7----End
        CASE Rec."Document Type" OF
            Rec."Document Type"::"Purchase Order":
                BEGIN
                    PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
                    PurchaseHeader.SETRANGE("No.", Rec."Document no");
                    IF PurchaseHeader.FINDSET THEN BEGIN
                        CLEAR(PurchaseHeader."Transport Job No.");
                        CLEAR(PurchaseHeader."Transport Job Status");
                        PurchaseHeader.MODIFY;
                    END;
                END;

            Rec."Document Type"::"Sales Order":
                BEGIN

                    SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SETRANGE("No.", Rec."Document no");
                    IF SalesHeader.FINDSET THEN BEGIN
                        CLEAR(SalesHeader."Transport Job No.");
                        CLEAR(SalesHeader."Transport Status");
                        SalesHeader.MODIFY;
                    END;
                END;

            Rec."Document Type"::"Transfer Order":
                BEGIN

                    TransferHeader.SETRANGE("No.", Rec."Document no");
                    IF TransferHeader.FINDSET THEN BEGIN
                        CLEAR(TransferHeader."Transport Job No.");
                        CLEAR(TransferHeader."Transport Status");
                        TransferHeader.MODIFY;
                    END;
                END;
        END;
    end;

    //[Scope('Internal')]
    procedure RestrictOrderDeletion(DocNo: Code[20]; DocType: Option " ","Sales Order","Purchase Order","Transfer Order")
    var
        GateEntryLine: Record "Gate Entry Line";
        TableCaptionValue: Text;
    begin
        TableCaptionValue := GateEntryLine.TABLECAPTION;
        GateEntryLine.RESET;
        GateEntryLine.SETRANGE("Document Type", DocType);
        GateEntryLine.SETRANGE("Document no", DocNo);
        IF GateEntryLine.FINDSET THEN BEGIN
            ERROR(
             Text001,
             GateEntryLine."Document Type",
             TableCaptionValue);
        END;
        /*CASE DocType OF
          ;
          DocType::"Purchase Order":
            BEGIN
        
            END;
        
          DocType::"Sales Order":
            BEGIN
            END;
        
          DocType::"Transfer Order":
            BEGIN
            END;
        
        END;*/

    end;
}

