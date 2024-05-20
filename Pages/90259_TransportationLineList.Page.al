#pragma implicitwith disable
page 90259 "Transportation Line List"
{
    Editable = false;
    PageType = List;
    SourceTable = "Gate Entry Line";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Route Sequence No."; Rec."Route Sequence No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Booking Reference No."; Rec."Booking Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
                }
                field("Order Address code"; Rec."Order Address code")
                {
                    Visible = false;
                }
                field(Address; Rec.Address)
                {
                    Visible = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Visible = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    Visible = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Visible = false;
                }
                field("Goods Checked"; Rec."Goods Checked")
                {
                    Visible = false;
                }
                field("Goods Checked By"; Rec."Goods Checked By")
                {
                    Visible = false;
                }
                field("Total Fridge Parcels"; Rec."Total Fridge Parcels")
                {
                    Visible = false;
                }
                field("Sticker on Box"; Rec."Sticker on Box")
                {
                    Visible = false;
                }
                field(Scan; Rec.Scan)
                {
                    Visible = false;
                }
                field("Supplier invoice No."; Rec."Supplier invoice No.")
                {
                    Visible = false;
                }
                field("Expected Delivery/Receipt Date"; Rec."Expected Delivery/Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Delivery/Receipt Time"; Rec."Expected Delivery/Receipt Time")
                {
                    ApplicationArea = All;
                }
                field("Actual Delivery/Receipt Date"; Rec."Actual Delivery/Receipt Date")
                {
                    Visible = false;
                }
                field("Carrier Quantity"; Rec."Carrier Quantity")
                {
                    ApplicationArea = All;
                }
                field("Carrier UOM"; Rec."Carrier UOM")
                {
                    Visible = false;
                }
                field("Total Parcels (Ambient)"; Rec."Total Parcels (Ambient)")
                {
                    ApplicationArea = All;
                }
                field("Total Weight (Ambient)"; Rec."Total Weight (Ambient)")
                {
                    Visible = false;
                }
                field("Purchaser /Sales Person"; Rec."Purchaser /Sales Person")
                {
                    ApplicationArea = All;
                }
                field("Qty-Pallet"; Rec."Qty-Pallet")
                {
                    ApplicationArea = All;
                }
                field("Qty-Case"; Rec."Qty-Case")
                {
                    ApplicationArea = All;
                }
                field("Location code"; Rec."Location code")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document no"; Rec."Document no")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Edit)
            {
                Image = Edit;
                Promoted = true;

                trigger OnAction()
                begin
                    //Chandan------------------Case:CAS-07189-F1X8W4----start
                    OpenRecord(TRUE);
                end;
            }
            action(View)
            {
                Image = View;
                Promoted = true;

                trigger OnAction()
                begin
                    //Chandan------------------Case:CAS-07189-F1X8W4----start
                    OpenRecord(FALSE);
                end;
            }
            action("Show Document")
            {
                Caption = 'Show Document';
                Image = Document;
                Promoted = true;

                trigger OnAction()
                begin
                    ShowDocument;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Chandan+++
        //txtLocFilter := GetLocationFilter;
        IF txtLocFilter <> '' THEN
            Rec.SETFILTER("Location code", txtLocFilter);
        //Chandan---
    end;

    var
        txtLocFilter: Text;

    local procedure OpenRecord(Mode: Boolean)
    var
        GateEntryHeader: Record "Gate Entry Header";
        TransportationCard: Page "Transportation Card";
    begin
        //Chandan------------------Case:CAS-07189-F1X8W4----start
        CLEAR(TransportationCard);
        GateEntryHeader.RESET;
        GateEntryHeader.SETRANGE("No.", Rec."No.");
        IF GateEntryHeader.FINDFIRST THEN BEGIN
            TransportationCard.SETRECORD(GateEntryHeader);
            TransportationCard.EDITABLE := Mode;
            TransportationCard.RUN;
        END;

        //Chandan------------------Case:CAS-07189-F1X8W4----End
    end;

    local procedure ShowDocument()
    var
        SalesHeader: Record 36;
        PurchaseHeader: Record 38;
        TransferHeader: Record 5740;
        SalesOrder: Page 42;
        PurchaseOrder: Page 50;
        TransferOrder: Page 5740;
    begin
        CASE Rec."Document Type" OF
            Rec."Document Type"::"Purchase Order":
                BEGIN
                    CLEAR(PurchaseOrder);
                    PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
                    PurchaseHeader.SETRANGE("No.", Rec."Document no");
                    IF PurchaseHeader.FINDSET THEN BEGIN
                        PurchaseOrder.SETRECORD(PurchaseHeader);
                        PurchaseOrder.RUN;
                    END;
                END;

            Rec."Document Type"::"Sales Order":
                BEGIN
                    CLEAR(SalesOrder);
                    SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SETRANGE("No.", Rec."Document no");
                    IF SalesHeader.FINDSET THEN BEGIN
                        SalesOrder.SETRECORD(SalesHeader);
                        SalesOrder.RUN;
                    END;
                END;

            Rec."Document Type"::"Transfer Order":
                BEGIN
                    CLEAR(TransferOrder);
                    TransferHeader.SETRANGE("No.", Rec."Document no");
                    IF TransferHeader.FINDSET THEN BEGIN
                        TransferOrder.SETRECORD(TransferHeader);
                        TransferOrder.RUN;
                    END;
                END;
        END;
    end;

    // local procedure GetLocationFilter(): Text
    // var
    //     //UserLocations: Record 50108;
    //     LocFilter: Text;
    // begin
    //     UserLocations.RESET;
    //     UserLocations.SETRANGE("User ID", USERID);
    //     IF UserLocations.FINDSET THEN
    //         REPEAT
    //             AddToFilterText2(LocFilter, '|', '', UserLocations.Location);
    //         UNTIL UserLocations.NEXT = 0;
    //     EXIT(LocFilter);
    // end;

    local procedure AddToFilterText2(var TextVar: Text; Separator: Code[10]; Comparator: Code[10]; Addendum: Code[20])
    begin
        IF TextVar = '' THEN
            TextVar := Comparator + Addendum
        ELSE
            TextVar += Separator + Comparator + Addendum;
    end;
}

#pragma implicitwith restore

