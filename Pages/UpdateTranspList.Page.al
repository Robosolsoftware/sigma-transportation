#pragma implicitwith disable
page 90262 "Update Transp. List"
{
    CardPageID = "Transportation Card";
    PageType = List;
    SourceTable = "Gate Entry Header";
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTableView = SORTING("Document Date", "No.")
                      ORDER(Ascending);

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
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Services Code"; Rec."Shipping Agent Services Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Booking Reference No."; Rec."Booking Reference No.")
                {
                    ApplicationArea = All;
                }
                field("LR/RR No."; Rec."LR/RR No.")
                {
                    Visible = false;
                }
                field("LR/RR Date"; Rec."LR/RR Date")
                {
                    Visible = false;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Expected Delivery/Receipt Date"; Rec."Expected Delivery/Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Delivery/Receipt Time"; Rec."Expected Delivery/Receipt Time")
                {
                    Visible = true;
                }
                field("Total parcel Weight"; Rec."Total parcel Weight")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Capacity(KG)"; Rec."Vehicle Capacity(KG)")
                {
                    Visible = IsDelivery;
                    ApplicationArea = All;
                }
                field("Avalaible Vehicle Capacity(KG)"; Rec."Avalaible Vehicle Capacity(KG)")
                {
                    Visible = IsDelivery;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Transportation Organized By"; Rec."Transportation Organized By")
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
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Transportation", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Email;
                action("<Action224>")
                {
                    Caption = '&Consignment';
                    Image = Print;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(TripDetails);
                        GateEntryHeader.RESET;
                        GateEntryHeader.SETFILTER(GateEntryHeader."No.", '%1', Rec."No.");
                        TripDetails.SETTABLEVIEW(GateEntryHeader);
                        TripDetails.RUNMODAL;
                    end;
                }
                // action("<Action225>")
                // {
                //     Caption = '&Route Details';
                //     Image = Print;

                //     trigger OnAction()
                //     begin
                //         //-----CAS-03084-M6R2S5---31/08/2016----pravin.d-----start----
                //         CLEAR(TransportationRouteDetails);
                //         GateEntryHeader.RESET;
                //         GateEntryHeader.SETFILTER(GateEntryHeader."No.", '%1', Rec."No.");
                //         TransportationRouteDetails.SETTABLEVIEW(GateEntryHeader);
                //         TransportationRouteDetails.RUNMODAL;
                //         //-----CAS-03084-M6R2S5---31/08/2016----pravin.d-----End------
                //     end;
                // }
            }
            group(Function)
            {
                Caption = 'Function';
                action("&Track Package")
                {
                    Caption = '&Track Package';
                    Image = ItemTracking;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        HYPERLINK(Rec.GetTrackingInternetAddr);
                    end;
                }
                action("Create Line")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        SalesHeader: Record 36;
                        PurchaseHeader: Record 38;
                        GateEntryLine: Record "Gate Entry Line";
                        ParcelDetails: Record "Parcel Details";
                        EntryType: Integer;
                        RecRef: RecordRef;
                        GateEntryHeader1: Record "Gate Entry Header";
                        OrderType: Integer;
                    begin
                        CreateTransLine;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF (Rec.Type = Rec.Type::Delivery) OR (Rec.Type = Rec.Type::ForCollection) THEN
            IsDelivery := TRUE
        ELSE
            IsDelivery := FALSE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::LookupOK] THEN
            CreateTransLine;
    end;

    var
        GateEntryHeader: Record "Gate Entry Header";
        TripDetails: Report "Consignment Card";
        // TransportationRouteDetails: Report 90102;
        OrderNo: Code[20];
        IsSalesOrder: Boolean;
        IsDelivery: Boolean;

    //[Scope('Internal')]
    procedure SetParameter(No: Code[20]; bool: Boolean)
    begin
        OrderNo := No;
        IsSalesOrder := bool;
    end;

    local procedure CreateTransLine()
    var
        SalesHeader: Record 36;
        PurchaseHeader: Record 38;
        GateEntryLine: Record "Gate Entry Line";
        ParcelDetails: Record "Parcel Details";
        EntryType: Integer;
        RecRef: RecordRef;
        GateEntryHeader1: Record "Gate Entry Header";
        OrderType: Integer;
    begin
        CLEAR(EntryType);
        IF IsSalesOrder THEN BEGIN
            SalesHeader.RESET;
            SalesHeader.SETRANGE("No.", OrderNo);
            SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
            SalesHeader.FINDFIRST;
            RecRef.OPEN(36);
            RecRef.GETTABLE(SalesHeader);
            EntryType := 2;
            OrderType := 1;
        END ELSE BEGIN
            PurchaseHeader.RESET;
            PurchaseHeader.SETRANGE("No.", OrderNo);
            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.FINDFIRST;
            RecRef.OPEN(38);
            RecRef.GETTABLE(PurchaseHeader);
            EntryType := 1;
            OrderType := 2;
        END;

        GateEntryHeader1.IsTransportationCreated(RecRef, OrderType, ParcelDetails);
        IF NOT ParcelDetails.FINDFIRST THEN BEGIN
            IF GateEntryHeader.IsAvailableCapacity(Rec, SalesHeader, PurchaseHeader, EntryType) THEN BEGIN
                GateEntryHeader.CreateTransportationLine(SalesHeader, PurchaseHeader, EntryType, Rec, GateEntryLine);
                GateEntryHeader.CreateParcelDetails(SalesHeader, PurchaseHeader, EntryType, Rec, GateEntryLine);
                MESSAGE('Line Added Successfully');
                CurrPage.UPDATE;
            END ELSE
                ERROR('There is no enough loading Capacity');
        END ELSE BEGIN
            MESSAGE('Transporatation line already exists %1,%2,%3', ParcelDetails."Transportaion No.", ParcelDetails."Document No.", ParcelDetails."Document Type");
        END;
    end;
}

#pragma implicitwith restore

