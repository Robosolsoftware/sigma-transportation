pageextension 90255 SalesOrderListExt_Transport extends "Sales Order List"
{
    layout
    {

    }
    actions
    {
        // Add changes to page actions here
        addafter("P&osting")
        {
            group(Transport)
            {
                action("Create Job")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Create Job', ENG = 'Create Job';
                    PromotedCategory = Process;
                    Promoted = true;
                    Image = NewShipment;

                    trigger OnAction()
                    var
                        GateEntryHeader: Record "Gate Entry Header";
                        GateEntryLine: Record "Gate Entry Line";
                        TransportationCard: Page "Transportation Card";
                        GateEntryHeader1: Record "Gate Entry Header";
                        RecRef: RecordRef;
                        ParcelDetails: Record "Parcel Details";
                        SalesHeader: Record "Sales Header";
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        SalesHeader.RESET;
                        SalesHeader.SETRANGE("Document Type", Rec."Document Type");
                        SalesHeader.SETRANGE("No.", Rec."No.");
                        IF SalesHeader.FINDFIRST THEN BEGIN
                            SalesHeader.CALCFIELDS("Completely Shipped");
                            IF SalesHeader."Completely Shipped" THEN BEGIN
                                MESSAGE('This Order is completely Shipped');
                            END ELSE BEGIN
                                RecRef.OPEN(36);
                                RecRef.GETTABLE(Rec);
                                GateEntryHeader1.IsTransportationCreated(RecRef, 1, ParcelDetails);
                                IF NOT ParcelDetails.FINDFIRST THEN BEGIN
                                    GateEntryHeader1.CreateTransportationHeader(Rec, PurchaseHeader, 2, GateEntryHeader);
                                    CLEAR(TransportationCard);
                                    TransportationCard.SetGlobalVariable(TRUE);
                                    TransportationCard.SETRECORD(GateEntryHeader);
                                    TransportationCard.RUN;
                                END ELSE BEGIN
                                    MESSAGE('Transporatation line already exists %1,%2,%3', ParcelDetails."Transportaion No.", ParcelDetails."Document No.", ParcelDetails."Document Type");
                                END;
                            END;
                        END;
                    end;
                }

                action("Add to Job")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Add to Job', ENG = 'Add to Job';
                    Promoted = true;
                    Image = Add;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        GateEntryHeader: Record "Gate Entry Header";
                        TransportationList: Page "Transportation List";
                        PurchaseHeader: Record "Purchase Header";
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.RESET;
                        SalesHeader.SETRANGE("Document Type", Rec."Document Type");
                        SalesHeader.SETRANGE("No.", Rec."No.");
                        IF SalesHeader.FINDFIRST THEN BEGIN
                            SalesHeader.CALCFIELDS("Completely Shipped");
                            IF SalesHeader."Completely Shipped" THEN BEGIN
                                MESSAGE('This Order is completely Shipped');
                            END ELSE BEGIN
                                // NIK 9-8-17 (CAS-06144-N0M6X7)
                                GateEntryHeader.SETFILTER(Type, '%1|%2', GateEntryHeader.Type::ForCollection, GateEntryHeader.Type::Delivery);
                                GateEntryHeader.SETRANGE("Location Code", Rec."Location Code");
                                GateEntryHeader.SETFILTER("Expected Delivery/Receipt Date", '%1|>=%2', 0D, Rec."Shipment Date");
                                IF GateEntryHeader.FINDSET THEN BEGIN
                                    TransportationList.SetParameter(Rec."No.", 3);
                                    TransportationList.SETTABLEVIEW(GateEntryHeader);
                                    TransportationList.LOOKUPMODE(TRUE);
                                    //TransportationList.RUN;
                                    TransportationList.RUNMODAL;
                                    // PAGE.RUN(50112);
                                END;
                                // NIK 9-8-17 (CAS-06144-N0M6X7)
                            END;
                        END;

                    end;
                }
                action("Navigate to Job")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Navigate to Job',
                    ENG = 'Navigate to Job';
                    Promoted = true;
                    Image = Card;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        GateEntryHeader: Record "Gate Entry Header";
                        TransportationCard: Page "Transportation Card";
                    begin
                        CLEAR(TransportationCard);
                        GateEntryHeader.RESET;
                        GateEntryHeader.SETRANGE("No.", Rec."Transport Job No.");
                        IF GateEntryHeader.FINDFIRST THEN BEGIN
                            TransportationCard.SETTABLEVIEW(GateEntryHeader);
                            TransportationCard.RUN;
                        END
                    end;
                }

                action("Cancel Job")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Cancel Job',
                    ENG = 'Cancel Job';
                    Promoted = true;
                    Image = Delete;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        GateEntryHeader: Record "Gate Entry Header";
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        GateEntryHeader.CancelJob(Rec, PurchaseHeader, 1);
                    end;
                }
            }
        }
    }

}
