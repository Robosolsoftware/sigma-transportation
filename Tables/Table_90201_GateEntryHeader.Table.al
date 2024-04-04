table 90251 "Gate Entry Header"
{
    Permissions = TableData 38 = m;

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

            trigger OnValidate()
            var
                gateEntryLine: Record "Gate Entry Line";

            begin
                IF "Location Code" <> xRec."Location Code" THEN
                    IF "Slot No." <> 0 THEN
                        ERROR('You cannot change location if slot booked,cancel slot to change location');

                // gateEntryLine.Reset();
                // gateEntryLine.SetRange("No.", Rec."No.");
                // if gateEntryLine.FindFirst() then begin
                //     gateEntryLine."Location code" := Rec."Location Code";
                // end;
            end;
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
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;

            trigger OnValidate()
            begin
                TransportLine.RESET;
                TransportLine.SETRANGE(TransportLine."No.", "No.");
                IF TransportLine.FINDFIRST THEN BEGIN
                    // IF NOT CONFIRM(STRSUBSTNO(Text001,FIELDCAPTION("Expected Delivery/Receipt Date")),TRUE) THEN  // NIK 8-8-17
                    // EXIT;
                    TransportLine.MODIFYALL(TransportLine."Expected Delivery/Receipt Date", "Expected Delivery/Receipt Date");
                END;
            end;
        }
        // field(12; Status; Option)
        // {
        //     Editable = true;
        //     OptionCaption = 'Open,Released';
        //     OptionMembers = Open,Released;

        // }
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

            trigger OnValidate()
            begin
                IF ShippingAgentService.GET("Shipping Agent Code", "Shipping Agent Services Code") THEN BEGIN
                    "Vehicle Capacity(KG)" := ShippingAgentService.Capacity;
                    "Avalaible Vehicle Capacity(KG)" := CalculateAvailableCapacity(Rec);
                END;
            end;
        }
        field(16; "Booking Reference No."; Code[20])
        {

            // trigger OnValidate()
            // begin
            //     TransportLine.RESET;
            //     TransportLine.SETRANGE(TransportLine."No.", "No.");
            //     IF TransportLine.FINDFIRST THEN BEGIN
            //         //IF NOT CONFIRM(STRSUBSTNO(Text001,FIELDCAPTION("Expected Delivery/Receipt Date")),TRUE) THEN  //NIK (CAS-06144-N0M6X7)
            //         //EXIT;
            //         TransportLine."Expected Delivery/Receipt Date" := "Expected Delivery/Receipt Date";
            //         TransportLine."Booking Reference No." := "Booking Reference No.";
            //         TransportLine.MODIFY;
            //         //TransportLine.MODIFYALL(TransportLine."Expected Delivery/Receipt Date","Expected Delivery/Receipt Date");
            //     END;
            // end;
        }
        field(17; "Vehicle Capacity(KG)"; Decimal)
        {

            trigger OnValidate()
            begin
                "Avalaible Vehicle Capacity(KG)" := CalculateAvailableCapacity(Rec);
            end;
        }
        field(18; "Driver Name"; Text[50])
        {
        }
        field(19; "Driver Phone No."; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(20; "Posting Date"; Date)
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
            Caption = 'Entry Type';
            OptionCaption = ' ,Receipt,Delivery,CollectionFrom,ForCollection,Export';
            OptionMembers = " ",Receipt,Delivery,CollectionFrom,ForCollection,Export;
            trigger OnValidate()
            var
                gateEntryLine: Record "Gate Entry Line";
            begin
                gateEntryLine.Reset();
                gateEntryLine.setrange("No.", Rec."No.");
                if gateEntryLine.FindSet() then begin
                    repeat
                        gateEntryLine."Entry Type" := Rec.Type;
                        gateEntryLine.Modify(true);
                    until gateEntryLine.Next() = 0;

                end;
            end;
        }
        field(25; "Expected Delivery/Receipt Time"; Time)
        {
            Caption = 'Expected Delivery/Receipt Time';

            trigger OnValidate()
            begin
                TransportLine.RESET;
                TransportLine.SETRANGE(TransportLine."No.", "No.");
                IF TransportLine.FINDFIRST THEN BEGIN
                    // IF NOT CONFIRM(STRSUBSTNO(Text001,FIELDCAPTION("Expected Delivery/Receipt Date")),TRUE) THEN  // NIK (CAS-06144-N0M6X7)
                    //   EXIT;
                    TransportLine.MODIFYALL(TransportLine."Expected Delivery/Receipt Date", "Expected Delivery/Receipt Date");
                END;
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
        field(31; "Transport Booking Cost"; Decimal)
        {
        }
        field(32; "Transport Area Code"; Code[10])
        {
            Description = 'CAS-08255-R1L9M0\';
            TableRelation = Area;
        }

        field(34; "Carrier"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Requested Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
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
            DataClassification = ToBeClassified;
            //FieldClass = FlowField;
            Editable = false;
            //CalcFormula = sum("Gate Entry Line"."Total Pallet" where("No." = field("No.")));
        }
        field(39; "Lifts"; Decimal)
        {
            DataClassification = ToBeClassified;
            //FieldClass = FlowField;
            Editable = false;
            //CalcFormula = sum("Gate Entry Line".Lifts where("No." = field("No.")));
        }
        field(40; "Loose Boxes"; Decimal)
        {
            DataClassification = ToBeClassified;
            //FieldClass = FlowField;
            Editable = false;
            //CalcFormula = sum("Gate Entry Line"."Loose Boxes" where("No." = field("No.")));
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
            OptionMembers = "Provisional","Transportation Booked","Goods Arrived","Goods Not Shownup","Fixed slot","Surprise PO";
            OptionCaption = 'Provisional,Transportation Booked,Goods Arrived,Goods Not Shownup,Fixed slot,Surprise PO';
            trigger OnValidate()
            var
                gateEntryLine: Record "Gate Entry Line";
                warehouseReceiptHeader: Record "Warehouse Receipt Header";
                purcHeader: Record "Purchase Header";
            begin
                gateEntryLine.Reset();
                gateEntryLine.setrange("No.", Rec."No.");
                if gateEntryLine.FindSet() then begin
                    repeat
                        gateEntryLine."Transportation Receipt Status" := Rec."Receipt Status";
                        gateEntryLine.Modify(true);
                    until gateEntryLine.Next() = 0;

                end;
                gateEntryLine.Reset();
                gateEntryLine.setrange("No.", Rec."No.");
                if gateEntryLine.FindSet() then begin
                    repeat
                        warehouseReceiptHeader.Reset();
                        warehouseReceiptHeader.SetRange("No.", gateEntryLine."Warehouse Receipt No.");
                        if warehouseReceiptHeader.FindFirst() then begin
                            warehouseReceiptHeader."Receipt Status" := format(Rec."Receipt Status");
                            warehouseReceiptHeader.Modify();
                        end;
                    until gateEntryLine.Next() = 0;
                end;
                gateEntryLine.Reset();
                gateEntryLine.setrange("No.", Rec."No.");
                if gateEntryLine.FindSet() then begin
                    repeat
                        purcHeader.Reset();
                        purcHeader.SetRange("No.", gateEntryLine."Document no");
                        if purcHeader.FindFirst() then begin
                            purcHeader."Receipt Status" := format(Rec."Receipt Status");
                            purcHeader.Modify();
                        end;
                    until gateEntryLine.Next() = 0;
                end;

            end;
        }
        field(45; "Requested Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "No. of Items"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Gate Entry Line" where("No." = field("No.")));
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Chandan------------Start--------140817
        // IF Status = Status::Released THEN
        //     ERROR('You cant delete realesed job');

        GateEntryLine.RESET;
        GateEntryLine.SETRANGE("No.", "No.");
        IF GateEntryLine.FINDSET THEN
            GateEntryLine.DELETEALL;

        ParcelDetails.RESET;
        ParcelDetails.SETRANGE("Transportaion No.", "No.");
        IF ParcelDetails.FINDSET THEN
            ParcelDetails.DELETEALL;
        //Chandan---------------End---------140817
    end;

    trigger OnInsert()
    begin
        WhseSetup.GET;
        IF "No." = '' THEN BEGIN

            WhseSetup.TESTFIELD(WhseSetup."Transportation Nos.");
            NoSeriesMgt.InitSeries(WhseSetup."Transportation Nos.", xRec."No.", 0D, "No.", "No. Series");
        END;
        "Transportation Organized By" := USERID;
        "Document Date" := WORKDATE;
        "Document Time" := TIME;
        //"Location Code" := WhseSetup."Default Location for Transport";
    end;

    var
        recVendor: Record 23;
        RecCust: Record 18;
        NoSeriesMgt: Codeunit 396;
        SalesSetup: Record 311;
        WhseSetup: Record 5769;
        TransportLine: Record "Gate Entry Line";
        Text001: Label 'You have modified %1.\\Do you want to update the lines?';
        ShippingAgent: Record 291;
        TrackingInternetAddr: Text;
        Text002: Label 'Your Delivery has been  shcedule on %1. Please find the attachment datails.';
        Text003: Label 'Please find the attachment of your consigment.';
        PurchaseLine: Record 39;
        salesLine: Record 37;
        UnitofMeasure: Record 204;
        ParcelType: Option;
        GateEntryLine: Record "Gate Entry Line";
        ParcelDetails: Record "Parcel Details";
        ShippingAgentService: Record 5790;

    // //[Scope('Internal')]
    procedure AssistEdit(OldGateEntryHeader: Record "Gate Entry Header"): Boolean
    var
        GateEntryHeader: Record "Gate Entry Header";
    begin
        GateEntryHeader := Rec;
        WhseSetup.GET;
        IF NoSeriesMgt.SelectSeries(WhseSetup."Transportation Nos.", OldGateEntryHeader."No. Series", GateEntryHeader."No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries(GateEntryHeader."No.");
            Rec := GateEntryHeader;
            EXIT(TRUE);
        END;

    end;

    // //[Scope('Internal')]
    procedure CheckLorryCapcity()
    begin
    end;

    // //[Scope('Internal')]
    procedure GetTrackingInternetAddr(): Text
    var
        HttpStr: Text;
    begin
        HttpStr := 'http://';
        TESTFIELD("Shipping Agent Code");
        ShippingAgent.GET("Shipping Agent Code");
        TrackingInternetAddr := STRSUBSTNO(ShippingAgent."Internet Address", "Booking Reference No.");

        IF STRPOS(TrackingInternetAddr, HttpStr) = 0 THEN
            TrackingInternetAddr := HttpStr + TrackingInternetAddr;
        EXIT(TrackingInternetAddr);
    end;

    //Prathamesh++
    // //[Scope('Internal')]
    procedure SendMail(GateEntryHeader: Record "Gate Entry Header")
    var
        // SMTP: Codeunit 400;
        GateEntryLine: Record "Gate Entry Line";
        //SMTPMailSetup: Record 409;
        FileManagement: Codeunit 419;
        ServerAttachmentFilePath: Text[250];
        ConsignmentCard: Report "Consignment Card";
        GateEntryLine1: Record "Gate Entry Line";
        CustVentID: Code[50];
        EmailAccount: Record "Email Account";
        EmailMessage: Codeunit "Email Message";
        Recipients: List of [Text];
        UserSetup: Record "User Setup";
        EmailSend: Codeunit Email;
        AttachmentTempBlob: Codeunit "Temp Blob";
        AttachmentInStrem: InStream;
        AttachmentOutStrem: OutStream;
    begin

        //--CAS-02345-N3M7X5----Pravin.D.--------------facility to send a email to customer/supplier for booking and collection.
        //Prathamesh++  
        // SMTPMailSetup.GET;
        EmailAccount.Reset();
        EmailAccount.SetFilter(Connector, 'SMTP');
        if EmailAccount.FindLast() then;

        GateEntryLine.RESET;
        GateEntryLine.SETRANGE("No.", GateEntryHeader."No.");
        IF GateEntryLine.FINDSET THEN;
        REPEAT
            //ServerAttachmentFilePath := COPYSTR(FileManagement.ServerTempFileName('pdf'), 1, 250);
            GateEntryLine1.RESET;
            GateEntryLine1.SETRANGE("No.", GateEntryLine."No.");
            GateEntryLine1.SETRANGE("Source Type", GateEntryLine."Source Type");
            GateEntryLine1.SETRANGE("Source No.", GateEntryLine."Source No.");
            IF GateEntryLine1.FINDFIRST THEN BEGIN
                CLEAR(CustVentID);
                IF GateEntryLine1."Source Type" = GateEntryLine1."Source Type"::Customer THEN
                    CustVentID := GetCustEmail(GateEntryLine1."Source No.");

                IF GateEntryLine1."Source Type" = GateEntryLine1."Source Type"::Supplier THEN
                    CustVentID := GetVendEmail(GateEntryLine1."Source No.");

                AttachmentTempBlob.CreateOutStream(AttachmentOutStrem);

                REPORT.SaveAs(90013, '', ReportFormat::Pdf, AttachmentOutStrem);
                AttachmentTempBlob.CreateInStream(AttachmentInStrem);

                EmailMessage.Create(USERID, 'Transportation Consignment', STRSUBSTNO(Text002, GateEntryLine1."Expected Delivery/Receipt Date"), FALSE);
                //SMTP.AddAttachment(ServerAttachmentFilePath, GateEntryLine1."No." + '.pdf');
                EmailMessage.AddAttachment(GateEntryLine1."No." + '.pdf', 'PDF', AttachmentInStrem);
                EmailSend.Send(EmailMessage, Enum::"Email Scenario"::Default);
            END;
        UNTIL GateEntryLine.NEXT = 0;
    end;
    //Prathamesh--

    local procedure GetVendEmail(No: Code[20]): Code[50]
    var
        Customer: Record 18;
        Vendor: Record 23;
    begin
        IF Vendor.GET(No) THEN
            EXIT(Vendor."E-Mail");
    end;

    local procedure GetCustEmail(No: Code[20]): Code[50]
    var
        Customer: Record 18;
    begin
        IF Customer.GET(No) THEN
            EXIT(Customer."E-Mail");
    end;

    // //[Scope('Internal')]
    procedure CreateTransportationHeader(var SalesHeader: Record 36; var PurchaseHeader: Record 38; Type: Option " ",Collection,Delivery,Export; var GateEntryHeader: Record "Gate Entry Header")
    var
        GateEntryLine: Record "Gate Entry Line";
        TotalAvaiWeight: Decimal;
    begin
        GateEntryHeader.RESET;
        GateEntryHeader.INIT;
        IF Type = 2 THEN BEGIN
            GateEntryHeader.VALIDATE("Booking Reference No.", SalesHeader."Booking Ref No.");
            GateEntryHeader.VALIDATE("Document Date", SalesHeader.Date);
            GateEntryHeader.VALIDATE("Document Time", SalesHeader.Time);
            GateEntryHeader.VALIDATE("Location Code", SalesHeader."Location Code");
            GateEntryHeader."Transport Area Code" := SalesHeader."Transport Area Code";
            GateEntryHeader.VALIDATE("Shipment Method Code", SalesHeader."Shipment Method Code");
            GateEntryHeader.VALIDATE("Shipping Agent Code", SalesHeader."Shipping Agent Code");
            GateEntryHeader.VALIDATE("Shipping Agent Services Code", SalesHeader."Shipping Agent Service Code");
            //GateEntryHeader.VALIDATE("Expected Delivery/Receipt Date",SalesHeader."Requested Delivery Date");
            GateEntryHeader.INSERT(TRUE);
            GateEntryHeader.Type := GateEntryHeader.Type::Delivery;
            //GateEntryHeader.VALIDATE(GateEntryHeader.Type,GateEntryHeader.Type::Delivery);
            GateEntryHeader.MODIFY;
        END;

        IF Type = 1 THEN BEGIN
            GateEntryHeader.VALIDATE(GateEntryHeader.Type, GateEntryHeader.Type::Receipt);
            // GateEntryHeader.VALIDATE("Booking Reference No.", PurchaseHeader."Booking Ref No.");
            //GateEntryHeader.VALIDATE("Document Date",PurchaseHeader."Booking In Date");
            //GateEntryHeader.VALIDATE("Document Time",PurchaseHeader."Booking In Time");
            GateEntryHeader.VALIDATE("Location Code", PurchaseHeader."Location Code");
            //NIK (CAS-06144-N0M6X7)
            IF "Shipment Method Code" = '' THEN BEGIN
                GateEntryHeader.VALIDATE("Shipment Method Code", PurchaseHeader."Shipment Method Code");
            END;
            ////NIK (CAS-06144-N0M6X7)
            GateEntryHeader.INSERT(TRUE);
        END;

        CreateTransportationLine(SalesHeader, PurchaseHeader, Type, GateEntryHeader, GateEntryLine);
        CreateParcelDetails(SalesHeader, PurchaseHeader, Type, GateEntryHeader, GateEntryLine);
    end;

    // //[Scope('Internal')]
    procedure CreateTransportationLine(var SalesHeader: Record 36; var PurchaseHeader: Record 38; Type: Option " ",Collection,Delivery,Export; var GateEntryHeader: Record "Gate Entry Header"; var GateEntryLine: Record "Gate Entry Line")
    var
        GateEntryLine1: Record "Gate Entry Line";
        LineNo: Integer;
        PurchaseLine: Record 39;
        TotPallet: Decimal;
        TotalAvaiWeight: Decimal;
        TotCase: Decimal;
    begin
        SalesSetup.GET;
        GateEntryLine.RESET;
        GateEntryLine.INIT;
        GateEntryLine1.SETRANGE("No.", GateEntryHeader."No.");
        IF GateEntryLine1.FINDLAST THEN
            LineNo := GateEntryLine1."Line No." + 1000
        ELSE
            LineNo := 1000;

        IF Type = 2 THEN BEGIN
            GateEntryLine.VALIDATE("No.", GateEntryHeader."No.");
            GateEntryLine.VALIDATE("Line No.", LineNo);
            GateEntryLine.VALIDATE("Source Type", GateEntryLine."Source Type"::Customer);
            GateEntryLine.VALIDATE("Source No.", SalesHeader."Sell-to Customer No.");
            GateEntryLine.VALIDATE("Entry Type", GateEntryLine."Entry Type"::Delivery);
            GateEntryLine.VALIDATE(Address, SalesHeader."Ship-to Address");
            GateEntryLine.VALIDATE("Address 2", SalesHeader."Ship-to Address 2");
            GateEntryLine.VALIDATE(City, SalesHeader."Ship-to City");
            GateEntryLine.VALIDATE(County, SalesHeader."Ship-to County");
            GateEntryLine.VALIDATE("Country/Region Code", SalesHeader."Ship-to Country/Region Code");
            GateEntryLine.VALIDATE("Expected Delivery/Receipt Date", SalesHeader."Shipment Date");
            GateEntryLine.VALIDATE("Document Type", GateEntryLine."Document Type"::"Sales Order");
            GateEntryLine.VALIDATE("Document no", SalesHeader."No.");
            GateEntryLine.VALIDATE("Purchaser /Sales Person", SalesHeader."Salesperson Code");
            SalesHeader.CALCFIELDS("Amount Including VAT");
            // IF SalesHeader."Payment Terms Code" = SalesSetup."Default Payment Term Code" THEN
            GateEntryLine.VALIDATE("Amount to Collect", SalesHeader."Amount Including VAT");
            GateEntryLine.INSERT(TRUE);
            SalesHeader.VALIDATE("Transport Status", SalesHeader."Transport Status"::Open);
            SalesHeader.VALIDATE("Transport Job No.", GateEntryLine."No.");
            SalesHeader.MODIFY(TRUE);
            //TotalAvaiWeight:=CalculateAvailableCapacity(GateEntryHeader);
            //GateEntryHeader."Avalaible Vehicle Capacity(KG)":=TotalAvaiWeight;
            //GateEntryHeader.MODIFY;
        END;

        IF Type = 1 THEN BEGIN
            CLEAR(TotPallet);
            PurchaseLine.RESET;
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            IF PurchaseLine.FINDFIRST THEN
                REPEAT
                //TotPallet := TotPallet + PurchaseLine.Pallet;
                // TotPallet := TotPallet + PurchaseLine."Pallet Qty."; //Prathamesh++
                //TotCase := TotCase + PurchaseLine."Case Qty";
                // TotCase := TotCase + PurchaseLine.Cases; //Prathamesh++
                UNTIL PurchaseLine.NEXT = 0;
            GateEntryLine.VALIDATE("No.", GateEntryHeader."No.");
            GateEntryLine.VALIDATE("Line No.", LineNo);
            GateEntryLine.VALIDATE("Source Type", GateEntryLine."Source Type"::Supplier);
            GateEntryLine.VALIDATE("Source No.", PurchaseHeader."Buy-from Vendor No.");
            GateEntryLine.VALIDATE("Entry Type", GateEntryLine."Entry Type"::Receipt);
            GateEntryLine.VALIDATE(Address, PurchaseHeader."Buy-from Address");
            GateEntryLine.VALIDATE("Address 2", PurchaseHeader."Buy-from Address 2");
            GateEntryLine.VALIDATE(City, PurchaseHeader."Buy-from City");
            GateEntryLine.VALIDATE(County, PurchaseHeader."Buy-from County");
            GateEntryLine.VALIDATE("Country/Region Code", PurchaseHeader."Buy-from Country/Region Code");
            GateEntryLine.VALIDATE("Expected Delivery/Receipt Date", PurchaseHeader."Expected Receipt Date");
            GateEntryLine.VALIDATE("Document Type", GateEntryLine."Document Type"::"Purchase Order");
            GateEntryLine.VALIDATE("Document no", PurchaseHeader."No.");
            GateEntryLine.VALIDATE("Total Pallet", TotPallet);
            GateEntryLine.VALIDATE("Qty-Pallet", TotPallet);
            GateEntryLine.VALIDATE("Qty-Case", TotCase);
            GateEntryLine.VALIDATE("Purchaser /Sales Person", PurchaseHeader."Purchaser Code");
            GateEntryLine."Your Reference" := PurchaseHeader."Your Reference";
            GateEntryLine.INSERT(TRUE);
            PurchaseHeader.VALIDATE("Transport Job Status", PurchaseHeader."Transport Job Status"::Open);
            PurchaseHeader.VALIDATE("Transport Job No.", GateEntryLine."No.");
            PurchaseHeader.MODIFY(TRUE);
        END;

        //NIK
        /*PurchaseHeader.RESET;
        PurchaseHeader.SETRANGE("Document Type",GateEntryLine."Document Type");
        PurchaseHeader.SETRANGE("No.",GateEntryLine."Document no");
        IF PurchaseHeader.FINDFIRST THEN BEGIN
          PurchaseHeader.VALIDATE("Transport Job Status",GateEntryLine.Status);
          PurchaseHeader.VALIDATE("Transport Job No.",GateEntryLine."No.");
          PurchaseHeader.MODIFY(TRUE);
        END;*/


    end;

    // //[Scope('Internal')]
    procedure CreateParcelDetails(var SalesHeader: Record 36; var PurchaseHeader: Record 38; Type: Option " ",Collection,Delivery,Export; var GateEntryHeader: Record "Gate Entry Header"; var GateEntryLine: Record "Gate Entry Line")
    var
        ParcelDetails: Record "Parcel Details";
        ParcelDetails1: Record "Parcel Details";
        TotalPurchaseWieght: Decimal;
        TotalSalesWieght: Decimal;
        TotalPurchaseQty: Decimal;
        TotalSalesQty: Decimal;
        TotCase: Decimal;
    begin
        ParcelDetails.RESET;
        ParcelDetails.INIT;
        ParcelDetails.VALIDATE("Transportaion No.", GateEntryHeader."No.");
        ParcelDetails.VALIDATE("Transportaion Line No.", GateEntryLine."Line No.");
        ParcelDetails.VALIDATE(ParcelDetails."Booking Reference No", GateEntryLine."Booking Reference No.");
        ParcelDetails.VALIDATE("Document No.", GateEntryLine."Document no");  //NIK 11-8-17
        IF Type = 1 THEN BEGIN
            ParcelDetails.VALIDATE("Source Type", ParcelDetails."Source Type"::Supplier);
            ParcelDetails.VALIDATE("Document Type", ParcelDetails."Document Type"::"Purchase Order");


            // NIK (CAS-06144-N0M6X7)
            CLEAR(TotalPurchaseWieght);
            CLEAR(TotalPurchaseQty);
            PurchaseLine.RESET;
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            IF PurchaseLine.FINDFIRST THEN
                REPEAT
                    TotalPurchaseWieght := TotalPurchaseWieght + (PurchaseLine."Net Weight") * (PurchaseLine.Quantity);
                // TotalPurchaseQty := TotalPurchaseQty + PurchaseLine.Pallet;
                // TotalPurchaseQty := TotalPurchaseQty + PurchaseLine."Pallet Qty."; //Prathamesh++
                // TotCase := TotCase + PurchaseLine."Case Qty";
                // TotCase := TotCase + PurchaseLine.Cases; //Prathamesh++
                UNTIL PurchaseLine.NEXT = 0;

            ParcelDetails.VALIDATE("Net Weight", TotalPurchaseWieght);
            ParcelDetails.VALIDATE("Parcel Quantity", TotalPurchaseQty);
            GateEntryLine.VALIDATE("Qty-Case", TotCase);
            ParcelDetails.VALIDATE("Parcel UOM", 'PALLET');
            ParcelType := ParcelDetails."Parcel Type"::Ambient;
            ParcelDetails.VALIDATE("Parcel Type", ParcelType);
        END;
        //NIK (CAS-06144-N0M6X7)

        IF Type = 2 THEN BEGIN
            ParcelDetails.VALIDATE("Source Type", ParcelDetails."Source Type"::Customer);
            ParcelDetails.VALIDATE("Document Type", ParcelDetails."Document Type"::"Sales Order");
            ParcelDetails.VALIDATE("Document No.", SalesHeader."No.");

            // NIK (CAS-06144-N0M6X7)
            CLEAR(TotalSalesWieght);
            CLEAR(TotalSalesQty);
            salesLine.RESET;
            salesLine.SETRANGE("Document No.", SalesHeader."No.");
            salesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            IF salesLine.FINDFIRST THEN
                REPEAT
                    TotalSalesWieght := TotalSalesWieght + (salesLine."Net Weight") * (salesLine.Quantity);
                // TotalSalesQty := TotalSalesQty + salesLine.Pallet;
                // TotalSalesQty := TotalSalesQty + salesLine.Pallets; //Prathamesh++
                UNTIL salesLine.NEXT = 0;

            ParcelDetails.VALIDATE("Net Weight", TotalSalesWieght);
            ParcelDetails.VALIDATE("Parcel Quantity", TotalSalesQty);
            ParcelDetails.VALIDATE("Parcel UOM", 'PALLET');
            ParcelType := ParcelDetails."Parcel Type"::Ambient;
            ParcelDetails.VALIDATE("Parcel Type", ParcelType);
        END;
        //NIK (CAS-06144-N0M6X7)
        ParcelDetails.VALIDATE("Source No.", GateEntryLine."Source No.");
        ParcelDetails.INSERT(TRUE);
        GateEntryHeader."Avalaible Vehicle Capacity(KG)" := CalculateAvailableCapacity(GateEntryHeader);
        GateEntryHeader.MODIFY;
    end;

    //[Scope('Internal')]
    procedure NavigateToTransportation(var Recref: RecordRef; var GateEntryLine: Record "Gate Entry Line"; OrdeType: Option " ","Sales Order","Purchase Order")
    var
        SalesHeader: Record 36;
        PurchaseHeader: Record 38;
        ParcelDetails: Record "Parcel Details";
    begin
        CASE OrdeType OF
            OrdeType::"Sales Order":
                BEGIN
                    CLEAR(SalesHeader);
                    Recref.SETTABLE(SalesHeader);
                    ParcelDetails.SETRANGE("Document Type", ParcelDetails."Document Type"::"Sales Order");
                    ParcelDetails.SETRANGE("Document No.", SalesHeader."No.");
                END;
            OrdeType::"Purchase Order":
                BEGIN
                    CLEAR(PurchaseHeader);
                    Recref.SETTABLE(PurchaseHeader);
                    ParcelDetails.SETRANGE("Document Type", ParcelDetails."Document Type"::"Purchase Order");
                    ParcelDetails.SETRANGE("Document No.", PurchaseHeader."No.");
                END;
        END;

        IF ParcelDetails.FINDFIRST THEN BEGIN
            GateEntryLine.RESET;
            GateEntryLine.SETRANGE("Line No.", ParcelDetails."Transportaion Line No.");
            GateEntryLine.SETRANGE("No.", ParcelDetails."Transportaion No.");
            GateEntryLine.FINDSET;
        END;
    end;

    //[Scope('Internal')]
    procedure IsTransportationCreated(var Recref: RecordRef; OrdeType: Option " ","Sales Order","Purchase Order","Transfer Order"; var ParcelDetails: Record "Parcel Details")
    var
        SalesHeader: Record 36;
        PurchaseHeader: Record 38;
        TransferHeader: Record 5740;
    begin
        CASE OrdeType OF
            OrdeType::"Sales Order":
                BEGIN
                    CLEAR(SalesHeader);
                    Recref.SETTABLE(SalesHeader);
                    ParcelDetails.SETRANGE("Document Type", ParcelDetails."Document Type"::"Sales Order");
                    ParcelDetails.SETRANGE("Document No.", SalesHeader."No.");
                END;
            OrdeType::"Purchase Order":
                BEGIN
                    CLEAR(PurchaseHeader);
                    Recref.SETTABLE(PurchaseHeader);
                    ParcelDetails.SETRANGE("Document Type", ParcelDetails."Document Type"::"Purchase Order");
                    ParcelDetails.SETRANGE("Document No.", PurchaseHeader."No.");
                END;
            OrdeType::"Transfer Order":
                BEGIN
                    CLEAR(TransferHeader);
                    Recref.SETTABLE(TransferHeader);
                    ParcelDetails.SETRANGE("Document Type", ParcelDetails."Document Type"::"Transfer Order");
                    ParcelDetails.SETRANGE("Document No.", TransferHeader."No.");
                END;
        END;

        IF ParcelDetails.FINDFIRST THEN BEGIN
            EXIT;
            //MESSAGE('Transportation Line entry already Exists. %1,%2,%3',ParcelDetails."Transportaion No.",ParcelDetails."Document No.",ParcelDetails."Document Type")
        END;

        //Chandan------------------------ Start-----------------------------
    end;

    //[Scope('Internal')]
    procedure UpdateStatusOnPost(GateEntryLine: Record "Gate Entry Line")
    var
        SalesHeader: Record 36;
        PurchaseHeader: Record 38;
    begin
        IF GateEntryLine."Document Type" = GateEntryLine."Document Type"::"Sales Order" THEN BEGIN
            SalesHeader.RESET;
            SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
            SalesHeader.SETRANGE("No.", GateEntryLine."Document no");
            IF SalesHeader.FINDFIRST THEN BEGIN
                SalesHeader.VALIDATE("Transport Status", SalesHeader."Transport Status"::"In-Progress");
                SalesHeader.MODIFY;
            END;
        END;

        IF GateEntryLine."Document Type" = GateEntryLine."Document Type"::"Purchase Order" THEN BEGIN
            PurchaseHeader.RESET;
            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETRANGE("No.", GateEntryLine."Document no");
            IF PurchaseHeader.FINDFIRST THEN BEGIN
                PurchaseHeader.VALIDATE("Transport Job Status", PurchaseHeader."Transport Job Status"::"In-Progress");
                PurchaseHeader.MODIFY;
            END;
        END;
    end;

    //[Scope('Internal')]
    procedure UpdateStatus(GateEntryLine: Record "Gate Entry Line")
    var
        SalesHeader: Record 36;
        PurchaseHeader: Record 38;
    begin
        IF GateEntryLine."Document Type" = GateEntryLine."Document Type"::"Sales Order" THEN BEGIN
            SalesHeader.RESET;
            SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
            SalesHeader.SETRANGE("No.", GateEntryLine."Document no");
            IF SalesHeader.FINDFIRST THEN BEGIN
                //GateEntryLine.CALCFIELDS(Status);
                SalesHeader.VALIDATE("Transport Status", GateEntryLine.Status);
                SalesHeader.VALIDATE("Shipment Date", GateEntryLine."Expected Delivery/Receipt Date");//alok 21/06/20117
                SalesHeader.MODIFY;
            END;
        END;

        IF GateEntryLine."Document Type" = GateEntryLine."Document Type"::"Purchase Order" THEN BEGIN
            PurchaseHeader.RESET;
            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETRANGE("No.", GateEntryLine."Document no");
            IF PurchaseHeader.FINDFIRST THEN BEGIN
                //GateEntryLine.CALCFIELDS(Status);
                PurchaseHeader.VALIDATE("Transport Job Status", GateEntryLine.Status);
                PurchaseHeader.VALIDATE("Expected Receipt Date", GateEntryLine."Expected Delivery/Receipt Date");//alok 21/06/2018
                PurchaseHeader.MODIFY;
            END;
        END;
        //Chandan------------------------ END-----------------------------
    end;

    // //[Scope('Internal')]
    procedure CalculateAvailableCapacity(GateEntryHeader: Record "Gate Entry Header"): Decimal
    var
        GateEntryLine: Record "Gate Entry Line";
        TotalWieght: Decimal;
        AvailableCap: Decimal;
        TotalPallet: Decimal;
    begin
        GateEntryLine.RESET;
        GateEntryLine.SETRANGE("No.", GateEntryHeader."No.");
        IF GateEntryLine.FINDFIRST THEN
            REPEAT
                GateEntryLine.CALCFIELDS("Total Weight (Ambient)", "Total Parcels (Ambient)");
                TotalWieght := TotalWieght + GateEntryLine."Total Weight (Ambient)";
                TotalPallet := TotalPallet + GateEntryLine."Total Parcels (Ambient)";
            UNTIL GateEntryLine.NEXT = 0;

        IF ShippingAgentService.GET("Shipping Agent Code", "Shipping Agent Services Code") THEN;



        /*IF GateEntryHeader."Vehicle Capacity(KG)"<>0 THEN BEGIN
         IF GateEntryHeader."Vehicle Capacity(KG)"<TotalWieght THEN
              ERROR('No Space Available in Vehicle')
         ELSE BEGIN
          AvailableCap:=(GateEntryHeader."Vehicle Capacity(KG)"-TotalWieght);
          EXIT(AvailableCap);
         END;
        END ELSE BEGIN
         AvailableCap:=(GateEntryHeader."Vehicle Capacity(KG)"-TotalWieght);
         EXIT(AvailableCap);
        END;*/
        CASE ShippingAgentService."Measurent for Capacity" OF
            ShippingAgentService."Measurent for Capacity"::KG:
                AvailableCap := (GateEntryHeader."Vehicle Capacity(KG)" - TotalWieght);
            ShippingAgentService."Measurent for Capacity"::Pallet:
                AvailableCap := (GateEntryHeader."Vehicle Capacity(KG)" - TotalPallet);
        END;
        EXIT(AvailableCap);

    end;

    //[Scope('Internal')]
    procedure IsAvailableCapacity(GateEntryHeader: Record "Gate Entry Header"; SalesHeader: Record 36; PurchaseHeader: Record 38; Type: Option " ",Collection,Delivery,Export,Transfer): Boolean
    var
        GateEntryLine: Record "Gate Entry Line";
        TotalWieght: Decimal;
        AvailableCap: Decimal;
        SalesLine: Record 37;
        PurchaseLine: Record 39;
        TotalPallet: Decimal;
    begin
        IF Type = 1 THEN BEGIN
            PurchaseLine.RESET;
            PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
            PurchaseLine.SETRANGE(PurchaseLine."Document No.", PurchaseHeader."No.");
            IF PurchaseLine.FINDFIRST THEN
                REPEAT
                    TotalWieght := TotalWieght + (PurchaseLine.Quantity * PurchaseLine."Net Weight");
                // TotalPallet := TotalPallet + PurchaseLine.Pallet;
                // TotalPallet := TotalPallet + PurchaseLine."Pallet Qty."; //Prathamesh++
                UNTIL SalesLine.NEXT = 0;
        END;

        IF Type = 2 THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
            SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
            IF SalesLine.FINDFIRST THEN
                REPEAT
                    TotalWieght := TotalWieght + (SalesLine.Quantity * SalesLine."Net Weight");
                //TotalPallet := TotalPallet + SalesLine.Pallet;
                // TotalPallet := TotalPallet + SalesLine.Pallets; //Prathamesh ++
                UNTIL SalesLine.NEXT = 0;
        END;
        IF ShippingAgentService.GET("Shipping Agent Code", "Shipping Agent Services Code") THEN;
        CASE ShippingAgentService."Measurent for Capacity" OF
            ShippingAgentService."Measurent for Capacity"::KG:
                BEGIN
                    IF TotalWieght > GateEntryHeader."Avalaible Vehicle Capacity(KG)" THEN
                        EXIT(FALSE)
                END;
            ShippingAgentService."Measurent for Capacity"::Pallet:
                BEGIN
                    IF TotalPallet > GateEntryHeader."Avalaible Vehicle Capacity(KG)" THEN
                        EXIT(FALSE)
                END;
        END;
        EXIT(TRUE)

        /*GateEntryLine.RESET;
        GateEntryLine.SETRANGE("No.",GateEntryHeader."No.");
        IF GateEntryLine.FINDFIRST THEN REPEAT
          GateEntryLine.CALCFIELDS("Total Weight (Ambient)" );
          TotalWieght:=TotalWieght+GateEntryLine."Total Weight (Ambient)";
        UNTIL GateEntryLine.NEXT=0;
        
        IF GateEntryHeader."Vehicle Capacity(KG)"<>0 THEN BEGIN
         IF GateEntryHeader."Vehicle Capacity(KG)"<TotalWieght THEN
              EXIT(FALSE)
         ELSE
           EXIT(TRUE);
        END;*/

    end;

    //[Scope('Internal')]
    procedure Caption(var CapacityText: Text; var AvlCapacityText: Text)
    begin
        IF ShippingAgentService.GET("Shipping Agent Code", "Shipping Agent Services Code") THEN BEGIN
            CapacityText := 'Vehicle Capacity(' + FORMAT(ShippingAgentService."Measurent for Capacity") + ')';
            AvlCapacityText := 'Avalaible Vehicle Capacity(' + FORMAT(ShippingAgentService."Measurent for Capacity") + ')';
        END;
    end;

    //[Scope('Internal')]
    procedure CreateTransportationHeaderFromTransferOrder(var TransferHeader: Record 5740; Type: Option " ",Collection,Delivery,Export; var GateEntryHeader: Record "Gate Entry Header")
    var
        GateEntryLine: Record "Gate Entry Line";
        TotalAvaiWeight: Decimal;
    begin
        GateEntryHeader.RESET;
        GateEntryHeader.INIT;

        IF Type = 2 THEN BEGIN
            GateEntryHeader.VALIDATE("Location Code", TransferHeader."Transfer-to Code");
            GateEntryHeader.VALIDATE("Shipment Method Code", TransferHeader."Shipment Method Code");
            GateEntryHeader.VALIDATE("Shipping Agent Code", TransferHeader."Shipping Agent Code");
            GateEntryHeader.VALIDATE("Shipping Agent Services Code", TransferHeader."Shipping Agent Service Code");
            GateEntryHeader.INSERT(TRUE);
            GateEntryHeader.Type := GateEntryHeader.Type::Delivery;
            GateEntryHeader.VALIDATE(GateEntryHeader.Type, GateEntryHeader.Type::Delivery);
            GateEntryHeader.MODIFY;
        END;

        CreateTransportationLineFromTransferLine(TransferHeader, Type, GateEntryHeader, GateEntryLine);
        CreateParcelDetailsFromTransferOrder(TransferHeader, Type, GateEntryHeader, GateEntryLine);
    end;

    // //[Scope('Internal')]
    procedure CreateTransportationLineFromTransferLine(var TransferHeader: Record 5740; Type: Option " ",Collection,Delivery,Export; var GateEntryHeader: Record "Gate Entry Header"; var GateEntryLine: Record "Gate Entry Line")
    var
        GateEntryLine1: Record "Gate Entry Line";
        LineNo: Integer;
        PurchaseLine: Record 39;
        TotPallet: Integer;
        TotalAvaiWeight: Decimal;
        TotCase: Decimal;
    begin
        SalesSetup.GET;
        GateEntryLine.RESET;
        GateEntryLine.INIT;
        GateEntryLine1.SETRANGE("No.", GateEntryHeader."No.");
        IF GateEntryLine1.FINDLAST THEN
            LineNo := GateEntryLine1."Line No." + 1000
        ELSE
            LineNo := 1000;

        IF Type = 2 THEN BEGIN
            GateEntryLine.VALIDATE("No.", GateEntryHeader."No.");
            GateEntryLine.VALIDATE("Line No.", LineNo);
            GateEntryLine.VALIDATE("Source Type", GateEntryLine."Source Type"::"Outbound Transfer");
            GateEntryLine.VALIDATE("Source No.", TransferHeader."No.");
            GateEntryLine.VALIDATE("Entry Type", GateEntryLine."Entry Type"::Delivery);
            GateEntryLine.VALIDATE(Address, TransferHeader."Transfer-to Address");
            GateEntryLine.VALIDATE("Address 2", TransferHeader."Transfer-to Address 2");
            GateEntryLine.VALIDATE(City, TransferHeader."Transfer-to City");
            GateEntryLine.VALIDATE(County, TransferHeader."Transfer-to County");
            GateEntryLine.VALIDATE("Expected Delivery/Receipt Date", TransferHeader."Receipt Date");
            GateEntryLine.VALIDATE("Document Type", GateEntryLine."Document Type"::"Transfer Order");
            GateEntryLine.VALIDATE("Document no", TransferHeader."No.");
            //SalesHeader.CALCFIELDS("Amount Including VAT");
            //IF SalesHeader."Payment Terms Code"=SalesSetup."Default Payment Term Code" THEN
            //  GateEntryLine.VALIDATE("Amount to Collect",SalesHeader."Amount Including VAT");
            GateEntryLine.INSERT(TRUE);

            TransferHeader.VALIDATE("Transport Status", GateEntryLine.Status);
            TransferHeader.VALIDATE("Transport Job No.", GateEntryLine."No.");
            TransferHeader.MODIFY(TRUE);
        END;
    end;

    // //[Scope('Internal')]
    procedure CreateParcelDetailsFromTransferOrder(var TransferHeader: Record 5740; Type: Option " ",Collection,Delivery,Export; var GateEntryHeader: Record "Gate Entry Header"; var GateEntryLine: Record "Gate Entry Line")
    var
        ParcelDetails: Record "Parcel Details";
        ParcelDetails1: Record "Parcel Details";
        TotalPurchaseWieght: Decimal;
        TotalSalesWieght: Decimal;
        TotalPurchaseQty: Decimal;
        TotalSalesQty: Decimal;
        TotCase: Decimal;
        TransferLine: Record 5741;
    begin
        ParcelDetails.RESET;
        ParcelDetails.INIT;
        ParcelDetails.VALIDATE("Transportaion No.", GateEntryHeader."No.");
        ParcelDetails.VALIDATE("Transportaion Line No.", GateEntryLine."Line No.");
        ParcelDetails.VALIDATE(ParcelDetails."Booking Reference No", GateEntryLine."Booking Reference No.");
        ParcelDetails.VALIDATE("Document No.", GateEntryLine."Document no");  //NIK 11-8-17

        IF Type = 2 THEN BEGIN
            //ParcelDetails.VALIDATE("Source Type",ParcelDetails."Source Type"::Customer);
            ParcelDetails.VALIDATE("Document Type", ParcelDetails."Document Type"::"Transfer Order");
            ParcelDetails.VALIDATE("Document No.", TransferHeader."No.");

            // NIK (CAS-06144-N0M6X7)
            CLEAR(TotalSalesWieght);
            CLEAR(TotalSalesQty);
            TransferLine.RESET;
            TransferLine.SETRANGE("Document No.", TransferHeader."No.");
            IF TransferLine.FINDFIRST THEN
                REPEAT
                    TotalSalesWieght := TotalSalesWieght + (TransferLine."Net Weight") * (TransferLine.Quantity);
                    //TotalSalesQty := TotalSalesQty + TransferLine.Pallet;
                    TotalSalesQty := TotalSalesQty + TransferLine.Pallet;
                UNTIL TransferLine.NEXT = 0;

            ParcelDetails.VALIDATE("Net Weight", TotalSalesWieght);
            ParcelDetails.VALIDATE("Parcel Quantity", TotalSalesQty);
            ParcelDetails.VALIDATE("Parcel UOM", 'PALLET');
            ParcelType := ParcelDetails."Parcel Type"::Ambient;
            ParcelDetails.VALIDATE("Parcel Type", ParcelType);
        END;
        //NIK (CAS-06144-N0M6X7)
        ParcelDetails.VALIDATE("Source No.", GateEntryLine."Source No.");
        ParcelDetails.INSERT(TRUE);
        GateEntryHeader."Avalaible Vehicle Capacity(KG)" := CalculateAvailableCapacity(GateEntryHeader);
        GateEntryHeader.MODIFY;
    end;

    // //[Scope('Internal')]
    procedure CancelTransportJobFromTransferOrder(TransferOrderNo: Code[20]; TransportJobNo: Code[20])
    var
        GateEntryHeader1: Record "Gate Entry Header";
    begin
        GateEntryHeader1.RESET;
        GateEntryHeader1.SETRANGE("No.", TransportJobNo);
        IF GateEntryHeader1.FINDFIRST THEN BEGIN
            //IF GateEntryHeader1.Status = GateEntryHeader1.Status::Open THEN BEGIN
            IF GateEntryHeader1."Slot No." = 0 THEN BEGIN
                // deleteTransportLine(SalesOrderNo,GateEntryHeader1."No.");
                DeleteTransportLineFromTransferOrder(TransferOrderNo, GateEntryHeader1."No.");
                GateEntryHeader1."Avalaible Vehicle Capacity(KG)" := GateEntryHeader1.CalculateAvailableCapacity(GateEntryHeader1);
                GateEntryHeader1.MODIFY;
            END
            ELSE BEGIN
                IF FindTransportLine(TransferOrderNo, GateEntryHeader1."No.") = 1 THEN BEGIN
                    ERROR('Slot is booked for transport no %1', TransportJobNo);
                END
                ELSE BEGIN
                    //deleteTransportLineFromTransferOrder(SalesOrderNo,GateEntryHeader1."No.");
                    DeleteTransportLineFromTransferOrder(TransferOrderNo, GateEntryHeader1."No.");
                    GateEntryHeader1."Avalaible Vehicle Capacity(KG)" := GateEntryHeader1.CalculateAvailableCapacity(GateEntryHeader1);
                    GateEntryHeader1.MODIFY;
                END;
            END;
        END
        ELSE BEGIN
            MESSAGE('Transport job status must be open for order no %1', TransferOrderNo);
        END;
    END;
    //end;

    local procedure DeleteTransportLineFromTransferOrder(TransferOrderNo: Code[20]; TransportJobNo: Code[20])
    var
        GateEntryLine1: Record "Gate Entry Line";
    begin
        GateEntryLine1.RESET;
        GateEntryLine1.SETRANGE("No.", TransportJobNo);
        GateEntryLine1.SETRANGE("Document Type", GateEntryLine1."Document Type"::"Transfer Order");
        GateEntryLine1.SETRANGE("Document no", TransferOrderNo);
        IF GateEntryLine1.FINDFIRST THEN BEGIN
            //deleteParcelDetail(GateEntryLine1."Document no",GateEntryLine1."No.",GateEntryLine1."Line No.");
            deleteParcelDetailFromTransferOrder(GateEntryLine1."Document no", GateEntryLine1."No.", GateEntryLine1."Line No.");
            GateEntryLine1.DELETE;
        END;
    end;

    local procedure deleteParcelDetailFromTransferOrder(TransferOrderNo: Code[20]; TransportJobNo: Code[20]; TransportJobLineNo: Integer)
    var
        ParcelDetails: Record "Parcel Details";
    begin
        ParcelDetails.RESET;
        ParcelDetails.SETRANGE("Document Type", ParcelDetails."Document Type"::"Transfer Order");
        ParcelDetails.SETRANGE("Document No.", TransferOrderNo);
        ParcelDetails.SETRANGE("Transportaion No.", TransportJobNo);
        ParcelDetails.SETRANGE("Transportaion Line No.", TransportJobLineNo);
        IF ParcelDetails.FINDFIRST THEN
            ParcelDetails.DELETE;
    end;

    local procedure FindTransportLine(TransferOrderNo: Code[20]; TransportJobNo: Code[20]): Integer
    var
        GateEntryLine1: Record "Gate Entry Line";
        TempGateEntryLine: Record "Gate Entry Line" temporary;
    begin
        CLEAR(TempGateEntryLine);
        GateEntryLine1.RESET;
        GateEntryLine1.SETRANGE("No.", TransportJobNo);
        GateEntryLine1.SETRANGE("Document Type", GateEntryLine1."Document Type"::"Transfer Order");
        IF GateEntryLine1.FINDSET THEN
            // MESSAGE('%1',GateEntryLine1.COUNT)
            EXIT(GateEntryLine1.COUNT);
    end;

    // //[Scope('Internal')]
    procedure deleteTransportHeaderFromTransferOrder(TransferOrderNo: Code[20]; TransportJobNo: Code[20])
    var
        GateEntryHeader1: Record "Gate Entry Header";
        GateEntryLine1: Record "Gate Entry Line";
    begin
        GateEntryHeader1.RESET;
        GateEntryHeader1.SETRANGE("No.", TransportJobNo);
        IF GateEntryHeader1.FINDFIRST THEN BEGIN
            GateEntryLine1.RESET;
            GateEntryLine1.SETRANGE("No.", GateEntryHeader1."No.");
            IF NOT GateEntryLine1.FINDFIRST THEN BEGIN
                GateEntryHeader1.DELETE;
            END
            ELSE BEGIN
                GateEntryHeader1."Avalaible Vehicle Capacity(KG)" := GateEntryHeader1.CalculateAvailableCapacity(GateEntryHeader1);
                GateEntryHeader1.MODIFY;
            END;
        END;
    end;

    // //[Scope('Internal')]
    procedure IsAvailableCapacityFromTransfer(GateEntryHeader: Record "Gate Entry Header"; TransferHeader: Record 5740; Type: Option " ",Collection,Delivery,Export,Transfer): Boolean
    var
        GateEntryLine: Record "Gate Entry Line";
        TotalWieght: Decimal;
        AvailableCap: Decimal;
        SalesLine: Record 37;
        PurchaseLine: Record 39;
        TotalPallet: Decimal;
        TransferLine: Record 5741;
    begin
        /*IF Type=1 THEN BEGIN
          PurchaseLine.RESET;
          PurchaseLine.SETRANGE("Document Type",PurchaseLine."Document Type"::Order);
          PurchaseLine.SETRANGE(PurchaseLine."Document No.",PurchaseHeader."No.");
          IF PurchaseLine.FINDFIRST THEN REPEAT
            TotalWieght:=TotalWieght+(PurchaseLine.Quantity*PurchaseLine."Net Weight");
            TotalPallet:=TotalPallet+PurchaseLine.Pallet;
           UNTIL SalesLine.NEXT=0;
        END;
        
        IF Type=2  THEN BEGIN
           SalesLine.RESET;
          SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::Order);
          SalesLine.SETRANGE(SalesLine."Document No.",SalesHeader."No.");
          IF SalesLine.FINDFIRST THEN REPEAT
            TotalWieght:=TotalWieght+(SalesLine.Quantity*SalesLine."Net Weight");
            TotalPallet:=TotalPallet+SalesLine.Pallet;
           UNTIL SalesLine.NEXT=0;
        END;*/

        IF Type = 4 THEN BEGIN
            TransferLine.RESET;
            TransferLine.SETRANGE("Document No.", TransferHeader."No.");
            IF TransferLine.FINDFIRST THEN
                REPEAT
                    TotalWieght := TotalWieght + (TransferLine.Quantity * TransferLine."Net Weight");
                    //TotalPallet := TotalPallet + TransferLine.Pallet;
                    TotalPallet := TotalPallet + TransferLine.Pallet; //Prathamesh++
                UNTIL TransportLine.NEXT = 0;
        END;

        IF ShippingAgentService.GET("Shipping Agent Code", "Shipping Agent Services Code") THEN;
        CASE ShippingAgentService."Measurent for Capacity" OF
            ShippingAgentService."Measurent for Capacity"::KG:
                BEGIN
                    IF TotalWieght > GateEntryHeader."Avalaible Vehicle Capacity(KG)" THEN
                        EXIT(FALSE)
                END;
            ShippingAgentService."Measurent for Capacity"::Pallet:
                BEGIN
                    IF TotalPallet > GateEntryHeader."Avalaible Vehicle Capacity(KG)" THEN
                        EXIT(FALSE)
                END;
        END;
        EXIT(TRUE)

        /*GateEntryLine.RESET;
        GateEntryLine.SETRANGE("No.",GateEntryHeader."No.");
        IF GateEntryLine.FINDFIRST THEN REPEAT
          GateEntryLine.CALCFIELDS("Total Weight (Ambient)" );
          TotalWieght:=TotalWieght+GateEntryLine."Total Weight (Ambient)";
        UNTIL GateEntryLine.NEXT=0;
        
        IF GateEntryHeader."Vehicle Capacity(KG)"<>0 THEN BEGIN
         IF GateEntryHeader."Vehicle Capacity(KG)"<TotalWieght THEN
              EXIT(FALSE)
         ELSE
           EXIT(TRUE);
        END;*/

    end;

    // //[Scope('Internal')]
    procedure CancelJob(RecSalesHeader: Record 36; RecPurchaseHeader3: Record 38; RecDocType: Option "Sales Order","Purchase Order")
    var
        Recref: RecordRef;
        recGateEntryHeader1: Record "Gate Entry Header";
        recGateEntryLine1: Record "Gate Entry Line";
        recParcelDetails1: Record "Parcel Details";
        recTransportationLineList1: Page "Transportation List";
        recTransportationList1: Page "Transportation List";
        recSalesHeader2: Record 36;
        recPurchaseHeader2: Record 38;
        SalesHeader1: Record "Sales Header";
    begin
        IF RecDocType = RecDocType::"Purchase Order" THEN BEGIN
            IF CONFIRM('Do you want to cancel transport job?', TRUE) THEN BEGIN
                //MESSAGE('Canceljob');
                recPurchaseHeader2.RESET;
                recPurchaseHeader2.SETRANGE("Document Type", RecPurchaseHeader3."Document Type");
                recPurchaseHeader2.SETRANGE("No.", RecPurchaseHeader3."No.");
                IF recPurchaseHeader2.FINDFIRST THEN BEGIN
                    IF recPurchaseHeader2."Transport Job No." <> '' THEN BEGIN
                        IF recPurchaseHeader2."Transport Job Status" = recPurchaseHeader2."Transport Job Status"::Open THEN BEGIN
                            CancelTransportJob('', recPurchaseHeader2."Transport Job No.", recPurchaseHeader2."No.", RecDocType::"Purchase Order");
                            deleteTransportHeader('', recPurchaseHeader2."Transport Job No.", recPurchaseHeader2."No.", RecDocType::"Purchase Order");
                            recPurchaseHeader2."Transport Job No." := '';
                            recPurchaseHeader2."Transport Job Status" := recPurchaseHeader2."Transport Job Status"::Open;
                            recPurchaseHeader2.MODIFY;
                        END
                        ELSE BEGIN
                            ERROR('Transport job status must be open for order no %1', recPurchaseHeader2."No.");
                        END;
                    END
                    ELSE BEGIN
                        ERROR('Transport job is not created for order no %1', recPurchaseHeader2."No.");
                    END;
                END;
            END;
        END;

        If RecDocType = RecDocType::"Sales Order" then begin
            IF CONFIRM('Do you want to cancel Transport job ?', TRUE) THEN BEGIN
                SalesHeader1.RESET;
                SalesHeader1.SETRANGE("Document Type", RecSalesHeader."Document Type");
                SalesHeader1.SETRANGE("No.", RecSalesHeader."No.");
                IF SalesHeader1.FINDFIRST THEN BEGIN
                    IF SalesHeader1."Transport Job No." <> '' THEN BEGIN
                        IF SalesHeader1."Transport Status" = SalesHeader1."Transport Status"::Open THEN BEGIN
                            CancelTransportJob('', SalesHeader1."Transport Job No.", SalesHeader1."No.", RecDocType::"Sales Order");
                            deleteTransportHeader('', SalesHeader1."Transport Job No.", SalesHeader1."No.", RecDocType::"Sales Order");
                            //CancelTransportJob(SalesHeader1."No.", SalesHeader1."Transport Job No.");
                            //deleteTransportHeader(SalesHeader1."No.", SalesHeader1."Transport Job No.");
                            SalesHeader1."Transport Job No." := '';
                            SalesHeader1."Transport Status" := SalesHeader1."Transport Status"::Open;
                            SalesHeader1.MODIFY;
                        END
                        ELSE BEGIN
                            ERROR('Transport job status must be open for order no %1', SalesHeader1."No.");
                        END;
                    END
                    ELSE BEGIN
                        ERROR('Transport job is not created for order no %1', SalesHeader1."No.");
                    END;
                END;
            END;
        end;
    end;

    // //[Scope('Internal')]
    procedure CancelTransportJob(SalesOrderNo: Code[20]; TransportJobNo: Code[20]; PurchaseOrderNo: Code[20]; RecDocType: Option "Sales Order","Purchase Order")
    var
        recGateEntryHeader1: Record "Gate Entry Header";
        recGateEntryLine1: Record "Gate Entry Line";
    begin
        IF RecDocType = RecDocType::"Purchase Order" THEN BEGIN
            //MESSAGE('CancelTransportJob');
            recGateEntryHeader1.RESET;
            recGateEntryHeader1.SETRANGE("No.", TransportJobNo);
            IF recGateEntryHeader1.FINDFIRST THEN BEGIN
                // IF recGateEntryHeader1.Status = recGateEntryHeader1.Status::Open THEN BEGIN
                IF recGateEntryHeader1."Slot No." = 0 THEN BEGIN
                    deleteTransportLine('', recGateEntryHeader1."No.", PurchaseOrderNo, RecDocType::"Purchase Order");
                    recGateEntryHeader1."Avalaible Vehicle Capacity(KG)" := recGateEntryHeader1.CalculateAvailableCapacity(recGateEntryHeader1);
                    recGateEntryHeader1.MODIFY;
                END
                ELSE BEGIN
                    IF FindTransportLine(PurchaseOrderNo, recGateEntryHeader1."No.") = 1 THEN BEGIN
                        ERROR('Slot is booked for transport no %1', TransportJobNo);
                    END
                    ELSE BEGIN
                        deleteTransportLine('', recGateEntryHeader1."No.", PurchaseOrderNo, RecDocType::"Purchase Order");
                        recGateEntryHeader1."Avalaible Vehicle Capacity(KG)" := recGateEntryHeader1.CalculateAvailableCapacity(recGateEntryHeader1);
                        recGateEntryHeader1.MODIFY;
                    END;
                END;
            END
            ELSE
                MESSAGE('Transport job status must be open for order no %1', PurchaseOrderNo);
        END;
    END;
    // end;

    // //[Scope('Internal')]
    procedure deleteTransportLine(SalesOrderNo: Code[20]; TransportJobNo: Code[20]; PurchaseOrderNo: Code[20]; RecDocType: Option "Sales Order","Purchase Order")
    var
        recGateEntryLine1: Record "Gate Entry Line";
    begin
        IF RecDocType = RecDocType::"Purchase Order" THEN BEGIN
            //MESSAGE('deleteTransportLine');
            recGateEntryLine1.RESET;
            recGateEntryLine1.SETRANGE("No.", TransportJobNo);
            recGateEntryLine1.SETRANGE("Document Type", recGateEntryLine1."Document Type"::"Purchase Order");
            recGateEntryLine1.SETRANGE("Document no", PurchaseOrderNo);
            IF recGateEntryLine1.FINDFIRST THEN BEGIN
                deleteParcelDetail('', recGateEntryLine1."No.", recGateEntryLine1."Line No.", recGateEntryLine1."Document no", RecDocType::"Purchase Order");
                recGateEntryLine1.DELETE;
            END;
        END;

        IF RecDocType = RecDocType::"Sales Order" THEN BEGIN
            //MESSAGE('deleteTransportLine');
            recGateEntryLine1.RESET;
            recGateEntryLine1.SETRANGE("No.", TransportJobNo);
            recGateEntryLine1.SETRANGE("Document Type", recGateEntryLine1."Document Type"::"Sales Order");
            recGateEntryLine1.SETRANGE("Document no", PurchaseOrderNo);
            IF recGateEntryLine1.FINDFIRST THEN BEGIN
                deleteParcelDetail('', recGateEntryLine1."No.", recGateEntryLine1."Line No.", recGateEntryLine1."Document no", RecDocType::"Sales Order");
                recGateEntryLine1.DELETE;
            END;
        END;
    end;

    // //[Scope('Internal')]
    procedure deleteTransportHeader(SalesOrderNo: Code[20]; TransportJobNo: Code[20]; PurchaseOrderNo: Code[20]; RecDocType: Option "Sales Order","Purchase Order")
    var
        recGateEntryHeader1: Record "Gate Entry Header";
        recGateEntryLine1: Record "Gate Entry Line";
    begin
        IF RecDocType = RecDocType::"Purchase Order" THEN BEGIN
            //MESSAGE('deleteTransportHeader');
            recGateEntryHeader1.RESET;
            recGateEntryHeader1.SETRANGE("No.", TransportJobNo);
            IF recGateEntryHeader1.FINDFIRST THEN BEGIN
                recGateEntryLine1.RESET;
                recGateEntryLine1.SETRANGE("No.", recGateEntryHeader1."No.");
                IF NOT recGateEntryLine1.FINDFIRST THEN BEGIN
                    recGateEntryHeader1.DELETE;
                END
                ELSE BEGIN
                    recGateEntryHeader1."Avalaible Vehicle Capacity(KG)" := recGateEntryHeader1.CalculateAvailableCapacity(recGateEntryHeader1);
                    recGateEntryHeader1.MODIFY;
                END;
            END;
        END;
    end;

    // //[Scope('Internal')]
    procedure deleteParcelDetail(SalesOrderNo: Code[20]; TransportJobNo: Code[20]; TransportJobLineNo: Integer; PurchaseOrderNo: Code[20]; RecDocType: Option "Sales Order","Purchase Order")
    var
        recParcelDetails: Record "Parcel Details";
    begin
        IF RecDocType = RecDocType::"Purchase Order" THEN BEGIN
            //MESSAGE('deleteParcelDetail');
            recParcelDetails.RESET;
            recParcelDetails.SETRANGE("Document Type", recParcelDetails."Document Type"::"Purchase Order");
            recParcelDetails.SETRANGE("Document No.", PurchaseOrderNo);
            recParcelDetails.SETRANGE("Transportaion No.", TransportJobNo);
            recParcelDetails.SETRANGE("Transportaion Line No.", TransportJobLineNo);
            IF recParcelDetails.FINDFIRST THEN
                recParcelDetails.DELETE;
        END;
    end;
}

