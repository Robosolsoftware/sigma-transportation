pageextension 90254 PurchaseLIstExt_Transport extends "Purchase Order List"
{
    layout
    {
        //ShubhamM07112022_US_9281++
        addafter("Amount Including VAT")
        {
            field(Receive; Rec.Receive)
            {
                ApplicationArea = All;
            }
            // field("Completely Received"; Rec."Completely Received")
            // {
            //     ApplicationArea = All;
            // }
            // field("Your Reference"; Rec."Your Reference")
            // {
            //     ApplicationArea = All;
            // }
            field("Booking In Date"; Rec."Booking In Date")
            {
                ApplicationArea = All;
            }
            field("Booking In Time"; Rec."Booking In Time")
            {
                ApplicationArea = All;
            }
        }
        //ShubhamM07112022_US_9281--
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
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        PurchaseHeader.SETRANGE("No.", Rec."No.");
                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                            PurchaseHeader.CALCFIELDS("Completely Received");
                            IF PurchaseHeader."Completely Received" THEN BEGIN
                                MESSAGE('This Order is completely Received');
                            END ELSE BEGIN
                                //Chandan
                                PurchaseHeader.TESTFIELD(Status, PurchaseHeader.Status::Open);//alok 21/06/2018
                                RecRef.OPEN(38);
                                RecRef.GETTABLE(Rec);
                                GateEntryHeader1.IsTransportationCreated(RecRef, 2, ParcelDetails);
                                IF NOT ParcelDetails.FINDFIRST THEN BEGIN
                                    GateEntryHeader1.CreateTransportationHeader(SalesHeader, Rec, 1, GateEntryHeader);
                                    CLEAR(TransportationCard);
                                    TransportationCard.SetGlobalVariable(FALSE);
                                    TransportationCard.SETRECORD(GateEntryHeader);
                                    TransportationCard.RUN;
                                END ELSE BEGIN
                                    MESSAGE('Transporatation line already exists %1,%2,%3', ParcelDetails."Transportaion No.", ParcelDetails."Document No.", ParcelDetails."Document Type");
                                END;
                                //Chandan
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
                    begin
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        PurchaseHeader.SETRANGE("No.", Rec."No.");
                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                            PurchaseHeader.CALCFIELDS("Completely Received");
                            IF PurchaseHeader."Completely Received" THEN BEGIN
                                MESSAGE('This Order is completely Received');
                            END ELSE BEGIN
                                //MESSAGE('HIHIH');
                                // NIK 9-8-17 (CAS-06144-N0M6X7)

                                GateEntryHeader.SETRANGE(Type, GateEntryHeader.Type::Receipt);
                                GateEntryHeader.SETFILTER("Expected Delivery/Receipt Date", '%1|=%2', 0D, Rec."Expected Receipt Date");
                                GateEntryHeader.SETRANGE("Location Code", Rec."Location Code");
                                IF GateEntryHeader.FINDSET THEN BEGIN
                                    TransportationList.SetParameter(Rec."No.", 1);
                                    //GateEntryHeader.SETRANGE(Status,GateEntryHeader.Type::Receipt);
                                    TransportationList.SETTABLEVIEW(GateEntryHeader);
                                    TransportationList.LOOKUPMODE := TRUE;
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
                        SalesHeader: Record "Sales Header";
                    begin
                        GateEntryHeader.CancelJob(SalesHeader, Rec, 1);
                    end;
                }
            }
        }
    }
}
