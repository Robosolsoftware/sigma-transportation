#pragma implicitwith disable
page 90253 "Transportation List"
{
    CardPageID = "Transportation Card";
    PageType = List;
    SourceTable = "Gate Entry Header";
    SourceTableView = SORTING("Document Date", "No.")
                      ORDER(Ascending);
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Transport Area Code"; Rec."Transport Area Code")
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
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Capacity(KG)"; Rec."Vehicle Capacity(KG)")
                {
                    CaptionClass = CapacityText;
                    Caption = 'Vehicle Capacity';
                    ApplicationArea = All;
                }
                field("Avalaible Vehicle Capacity(KG)"; Rec."Avalaible Vehicle Capacity(KG)")
                {
                    CaptionClass = AvlCapacityText;
                    Caption = 'Avalaible Vehicle Capacity';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Transportation Organized By"; Rec."Transportation Organized By")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Expected Delivery/Receipt Date"; Rec."Expected Delivery/Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Delivery/Receipt Time"; Rec."Expected Delivery/Receipt Time")
                {
                    ApplicationArea = All;
                }
                field("Total parcel Weight"; Rec."Total parcel Weight")
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

                    trigger OnAction()
                    begin
                        CLEAR(TripDetails);
                        GateEntryHeader.RESET;
                        GateEntryHeader.SETFILTER(GateEntryHeader."No.", '%1', Rec."No.");
                        TripDetails.SETTABLEVIEW(GateEntryHeader);
                        TripDetails.RUNMODAL;
                    end;
                }
                action("<Action225>")
                {
                    Caption = '&Route Details';
                    Image = Print;

                    trigger OnAction()
                    begin
                        //-----CAS-03084-M6R2S5---31/08/2016----pravin.d-----start----
                        CLEAR(TransportationRouteDetails);
                        GateEntryHeader.RESET;
                        GateEntryHeader.SETFILTER(GateEntryHeader."No.", '%1', Rec."No.");
                        TransportationRouteDetails.SETTABLEVIEW(GateEntryHeader);
                        TransportationRouteDetails.RUNMODAL;
                        //-----CAS-03084-M6R2S5---31/08/2016----pravin.d-----End------
                    end;
                }
            }
            group(Function)
            {
                Caption = 'Function';
                action("&Track Package")
                {
                    Caption = '&Track Package';
                    Image = ItemTracking;

                    trigger OnAction()
                    begin
                        HYPERLINK(Rec.GetTrackingInternetAddr);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.Caption(CapacityText, AvlCapacityText);
    end;

    trigger OnOpenPage()
    begin
        CLEAR(Locations);
        UsersLocations.RESET;
        UsersLocations.SETRANGE("User ID", USERID);
        IF UsersLocations.FINDSET THEN
            REPEAT
                IF Locations = '' THEN
                    Locations := UsersLocations.Location
                ELSE
                    Locations := Locations + '|' + UsersLocations.Location;
            UNTIL UsersLocations.NEXT = 0;
        Rec.FILTERGROUP(8);
        Rec.SETFILTER("Location Code", Locations);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::LookupOK] THEN
            CreateTransLine;
    end;

    var
        GateEntryHeader: Record "Gate Entry Header";
        TripDetails: Report "Consignment Card";
        TransportationRouteDetails: Report "Transportation Route Detail";
        UsersLocations: Record 50108;
        Locations: Text;
        CapacityText: Text;
        AvlCapacityText: Text;
        OrderNo: Code[20];
        IsSalesOrder: Boolean;
        DocType: Option " ","Purchase Order","Purchase Return","Sales Order","Sales Shipment","Sales Return Order","Transfer Order";

    //[Scope('Internal')]
    procedure SetParameter(No: Code[20]; Type: Option " ","Purchase Order","Purchase Return","Sales Order","Sales Shipment","Sales Return Order","Transfer Order")
    begin
        OrderNo := No;
        //IsSalesOrder:=bool;
        DocType := Type;
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
        TransferHeader: Record 5740;
    begin
        CLEAR(EntryType);
        IF (DocType = DocType::"Purchase Order") OR (DocType = DocType::"Sales Order") THEN BEGIN
            IF DocType = DocType::"Sales Order" THEN BEGIN
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.", OrderNo);
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.FINDFIRST;
                RecRef.OPEN(36);
                RecRef.GETTABLE(SalesHeader);
                EntryType := 2;
                OrderType := 1;
            END
            ELSE BEGIN
                IF DocType = DocType::"Purchase Order" THEN BEGIN
                    PurchaseHeader.RESET;
                    PurchaseHeader.SETRANGE("No.", OrderNo);
                    PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
                    PurchaseHeader.FINDFIRST;
                    RecRef.OPEN(38);
                    RecRef.GETTABLE(PurchaseHeader);
                    EntryType := 1;
                    OrderType := 2;
                END;
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
        END;

        IF DocType = DocType::"Transfer Order" THEN BEGIN
            TransferHeader.RESET;
            TransferHeader.SETRANGE("No.", OrderNo);
            TransferHeader.FINDFIRST;
            RecRef.OPEN(5740);
            RecRef.GETTABLE(TransferHeader);
            EntryType := 2;
            OrderType := 3;

            GateEntryHeader1.IsTransportationCreated(RecRef, 3, ParcelDetails);
            IF NOT ParcelDetails.FINDFIRST THEN BEGIN
                //IF GateEntryHeader.IsAvailableCapacity(Rec,SalesHeader,PurchaseHeader,4) THEN BEGIN
                IF GateEntryHeader.IsAvailableCapacityFromTransfer(Rec, TransferHeader, 4) THEN BEGIN
                    //GateEntryHeader.CreateTransportationLine(SalesHeader,PurchaseHeader,EntryType,Rec,GateEntryLine);
                    GateEntryHeader.CreateTransportationLineFromTransferLine(TransferHeader, EntryType, Rec, GateEntryLine);
                    //GateEntryHeader.CreateParcelDetails(SalesHeader,PurchaseHeader,EntryType,Rec,GateEntryLine);
                    GateEntryHeader.CreateParcelDetailsFromTransferOrder(TransferHeader, EntryType, Rec, GateEntryLine);
                    MESSAGE('Line Added Successfully');
                    CurrPage.UPDATE;
                END ELSE
                    ERROR('There is no enough loading Capacity');
            END ELSE BEGIN
                MESSAGE('Transporatation line already exists %1,%2,%3', ParcelDetails."Transportaion No.", ParcelDetails."Document No.", ParcelDetails."Document Type");
            END;
        END;
    end;
}

#pragma implicitwith restore

