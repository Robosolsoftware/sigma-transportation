table 90255 "Parcel Details"
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
            OptionCaption = ' ,Purchase Order,Purchase Return,Sales Order,Sales Shipment,Sales Return Order,Transfer Order';
            OptionMembers = " ","Purchase Order","Purchase Return","Sales Order","Sales Shipment","Sales Return Order","Transfer Order";

            trigger OnValidate()
            begin

                IF "Source Type" = "Source Type"::Customer THEN BEGIN
                    IF ("Document Type" = "Document Type"::"Purchase Order") OR ("Document Type" = "Document Type"::"Purchase Return") THEN
                        ERROR('You can not select Purchase Order Or Purchase Return Order if source type is customer');
                END;

                IF "Source Type" = "Source Type"::Supplier THEN BEGIN
                    IF ("Document Type" = "Document Type"::"Sales Order") OR ("Document Type" = "Document Type"::"Sales Shipment") THEN
                        ERROR('You can not select the sales order or sales return order if source type is supplier');

                END;
            end;
        }
        field(7; "Document No."; Code[20])
        {
            TableRelation = IF ("Document Type" = FILTER("Purchase Order"),
                                "Source No." = FILTER(<> '')) "Purchase Header"."No." WHERE("Document Type" = FILTER(Order),
                                                                                      "Buy-from Vendor No." = FIELD("Source No."))
            ELSE
            IF ("Document Type" = FILTER("Purchase Return"),
                                                                                               "Source No." = FILTER(<> '')) "Return Shipment Header"."No." WHERE("Buy-from Vendor No." = FIELD("Source No."))
            ELSE
            IF ("Document Type" = FILTER("Sales Shipment"),
                                                                                                        "Source No." = FILTER(<> '')) "Sales Shipment Header"."No." WHERE("Sell-to Customer No." = FIELD("Source No."))
            ELSE
            IF ("Document Type" = FILTER("Sales Return Order"),
                                                                                                                 "Source No." = FILTER(<> '')) "Sales Header"."No." WHERE("Document Type" = FILTER("Return Order"),
                                                                                                                                                                    "Sell-to Customer No." = FIELD("Source No."))
            ELSE
            IF ("Document Type" = FILTER("Sales Order"),
                                                                                                                                                                             "Source No." = FILTER(<> '')) "Sales Header"."No." WHERE("Document Type" = FILTER(Order),
                                                                                                                                                                                                                                "Sell-to Customer No." = FIELD("Source No."));

            trigger OnValidate()
            var
                GateEntryLine: Record "Gate Entry Line";
                SalesHeader: Record 36;
            begin
                //Chandan
                IF "Document Type" = Rec."Document Type"::"Sales Order" THEN BEGIN
                    SalesHeader.SETRANGE("No.", "Document No.");
                    SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SETRANGE("Payment Terms Code", 'COD');
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        GateEntryLine.SETRANGE("Line No.", Rec."Transportaion Line No.");
                        GateEntryLine.SETRANGE("No.", Rec."Transportaion No.");
                        GateEntryLine.SETRANGE("Entry Type", GateEntryLine."Entry Type"::Delivery);
                        IF GateEntryLine.FINDFIRST THEN BEGIN
                            GateEntryLine."Activity Code" := GateEntryLine."Activity Code"::"Cash Collection";
                            SalesHeader.CALCFIELDS("Amount Including VAT");
                            GateEntryLine."Amount to Collect" := SalesHeader."Amount Including VAT";
                            GateEntryLine.MODIFY(TRUE);
                        END;
                    END;
                END;
                //Chandan

                IF "Document Type" = Rec."Document Type"::"Purchase Order" THEN BEGIN
                    // PurchaseLine.SETCURRENTKEY("Document Type","Document No.","Line No.");
                    PurchaseLine.SETRANGE("Document No.", PurchaseLine."Document No.");
                    PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
                    IF PurchaseLine.FINDSET THEN BEGIN
                        // PackageDetail.SETCURRENTKEY("Transportaion No.","Transportaion Line No.","Line No.");
                        PackageDetail.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
                        PackageDetail.SETRANGE("Document No.", PurchaseLine."Document No.");
                        IF PackageDetail.FINDFIRST THEN BEGIN
                            REPEAT
                                "Net Weight" := "Net Weight" + PurchaseLine."Net Weight";
                            UNTIL PurchaseLine.NEXT = 0;
                        END;
                    END;
                END;
                /*
                IF "Document Type" = Rec."Document Type"::"Transfer Order" THEN
                  BEGIN
                    TransferLine.SETRANGE("Document No.",TransferLine."Document No.");
                    IF TransferLine.FINDSET THEN
                      BEGIN
                        PackageDetail.SETRANGE("Document Type",PackageDetail."Document Type"::"Transfer Order");
                        PackageDetail.SETRANGE("Document No.",TransferLine."Document No.");
                        IF PackageDetail.FINDFIRST THEN
                          BEGIN
                            REPEAT
                              "Net Weight" := "Net Weight" + TransferLine."Net Weight";
                            UNTIL TransferLine.NEXT =0;
                          END;
                      END;
                  END;
                  */


            end;
        }
        field(8; "Parcel UOM"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;

            trigger OnValidate()
            begin
                // Manish ++
                IF RecTransLine.GET("Transportaion No.", "Transportaion Line No.") THEN BEGIN
                    "Source Type" := RecTransLine."Source Type";
                    "Source No." := RecTransLine."Source No.";
                END;
                // Manish --
            end;
        }
        field(9; "Parcel Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
        }
        field(10; "Parcel UID"; Code[20])
        {

            trigger OnValidate()
            begin
                CLEAR("Parcel Quantity");
                IF "Parcel UID" <> '' THEN
                    "Parcel Quantity" := 1;
            end;
        }
        field(11; "Parcel Type"; Option)
        {
            Description = 'Fridge or Ambient CAS-01968-W1Z5R4';
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
        field(15; "Line Type"; Option)
        {
            OptionCaption = ' ,Planned,Scheduled';
            OptionMembers = " ",Planned,Scheduled;
        }
        field(16; "Qty-Case"; Decimal)
        {
            Description = 'CAS-07316-C6P4H7';
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
        RecTransLine: Record "Gate Entry Line";
        PurchaseLine: Record 39;
        TransferLine: Record 5741;

    //[Scope('Internal')]
    procedure UpdateWeight()
    var
        L_Totqty: Decimal;
    begin
        /*
        PackageDetail.RESET;
        PackageDetail.SETRANGE("Transportaion No.","Transportaion No.");
        PackageDetail.SETRANGE("Transportaion Line No.","Transportaion Line No.");
        IF PackageDetail.FINDFIRST THEN REPEAT
          L_Totqty +=  PackageDetail."Net Weight";
        UNTIL PackageDetail.NEXT = 0;
        IF TransLine.GET("Transportaion No.","Transportaion Line No.") THEN BEGIN
          TransLine."Total Weight (Ambient)" := L_Totqty;
          TransLine.MODIFY;
        END;*/

    end;
}

