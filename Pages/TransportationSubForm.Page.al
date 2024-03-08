#pragma implicitwith disable
page 90252 "Transportation SubForm"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Gate Entry Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field("Route Sequence No."; Rec."Route Sequence No.")
                // {
                //     ApplicationArea = All;
                // }
                // field("Booking Reference No."; Rec."Booking Reference No.")
                // {
                //     ApplicationArea = All;
                // }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Transportation No."; rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transportation Receipt Status"; Rec."Transportation Receipt Status")
                {
                    ApplicationArea = all;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Warehouse Receipt No."; Rec."Warehouse Receipt No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Source Document"; Rec."Source Document")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document no"; Rec."Document no")
                {
                    ApplicationArea = All;
                    Visible = true;
                    Editable = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Visible = true;
                    Editable = false;
                    //Visible = false;
                }

                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    //Visible = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expected Delivery/Receipt Date"; Rec."Expected Delivery/Receipt Date")
                {
                    Caption = 'Expected Delivery/Receipt Date';
                    ApplicationArea = All;
                    Visible = false;

                }
                // field("Actual Delivery/Receipt Date"; Rec."Actual Delivery/Receipt Date")
                // {
                //     Visible = false;
                // }
                field("Goods Checked"; Rec."Goods Checked")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF Rec."Goods Checked" THEN
                            Rec."Goods Checked By" := USERID
                        else
                            Rec."Goods Checked By" := '';

                    end;
                }
                field("Goods Checked By"; Rec."Goods Checked By")
                {
                    ApplicationArea = All;
                }
                // field("Sticker on Box"; Rec."Sticker on Box")
                // {
                //     ApplicationArea = All;
                // }
                // field("Carrier Quantity"; Rec."Carrier Quantity")
                // {
                //     Visible = false;
                // }
                // field("Carrier UOM"; Rec."Carrier UOM")
                // {
                //     Visible = false;
                // }
                // field("Activity Code"; Rec."Activity Code")
                // {
                //     Visible = false;
                // }
                // field("Amount to Collect"; Rec."Amount to Collect")
                // {
                //     Editable = false;
                //     ApplicationArea = All;
                // }
                // field("Amount Collected"; Rec."Amount Collected")
                // {
                //     ApplicationArea = All;
                // }
                // field("Amount Confirmed"; Rec."Amount Confirmed")
                // {
                //     ApplicationArea = All;
                // }
                // field("Total Parcels (Ambient)"; Rec."Total Parcels (Ambient)")
                // {
                //     Caption = 'Total pallet';
                //     ApplicationArea = All;
                // }
                // field("Total Weight (Ambient)"; Rec."Total Weight (Ambient)")
                // {
                //     Caption = 'Total Weight';
                //     ApplicationArea = All;
                // }
                // field("Total Parcels (Fridge)"; Rec."Total Parcels (Fridge)")
                // {
                //     Visible = false;
                // }
                // field("Total Weight (Fridge)"; Rec."Total Weight (Fridge)")
                // {
                //     Visible = false;
                // }
                // field("Total Parcels(Booked)"; Rec."Total Parcels(Booked)")
                // {
                //     Visible = false;
                // }
                // field("Total Weight(KG)(Booked)"; Rec."Total Weight(KG)(Booked)")
                // {
                //     Visible = false;
                // }
                field("Total Pallet"; Rec."Total Pallet")
                {
                    ApplicationArea = All;
                    Caption = 'Booked Pallets';
                    trigger OnValidate()
                    var
                        L_TransportHeader: Record "Gate Entry Header";
                        L_TransportLine: Record "Gate Entry Line";
                        TotalBookedPallets: Decimal;
                    begin
                        L_TransportHeader.Reset();
                        L_TransportHeader.SetFilter("No.", Rec."No.");
                        if L_TransportHeader.FindFirst() then begin
                            Clear(TotalBookedPallets);
                            L_TransportLine.Reset();
                            L_TransportLine.SetRange("No.", L_TransportHeader."No.");
                            if L_TransportLine.FindSet() then begin
                                repeat
                                    if L_TransportLine."Line No." = Rec."Line No." then begin
                                        TotalBookedPallets += rec."Total Pallet";
                                    end
                                    else begin
                                        TotalBookedPallets += L_TransportLine."Total Pallet";
                                    end;
                                until L_TransportLine.Next() = 0;

                            end;
                            L_TransportHeader."Booked Pallets" := TotalBookedPallets;
                            L_TransportHeader.Modify()

                        end;
                        CurrPage.Update();
                    end;
                }
                field(Lifts; Rec.Lifts)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        L_TransportHeader: Record "Gate Entry Header";
                        L_TransportLine: Record "Gate Entry Line";
                        TotalLifts: Decimal;
                    begin
                        L_TransportHeader.Reset();
                        L_TransportHeader.SetFilter("No.", Rec."No.");
                        if L_TransportHeader.FindFirst() then begin
                            Clear(TotalLifts);
                            L_TransportLine.Reset();
                            L_TransportLine.SetRange("No.", L_TransportHeader."No.");
                            if L_TransportLine.FindSet() then begin
                                repeat
                                    if L_TransportLine."Line No." = Rec."Line No." then begin
                                        TotalLifts += rec.Lifts;
                                    end
                                    else begin
                                        TotalLifts += L_TransportLine.Lifts;
                                    end;
                                until L_TransportLine.Next() = 0;

                            end;
                            L_TransportHeader.Lifts := TotalLifts;
                            L_TransportHeader.Modify()
                        end;
                        CurrPage.Update();
                    end;
                }
                field("Loose Boxes"; Rec."Loose Boxes")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        L_TransportHeader: Record "Gate Entry Header";
                        L_TransportLine: Record "Gate Entry Line";
                        TotalLooseBoxes: Decimal;
                    begin
                        L_TransportHeader.Reset();
                        L_TransportHeader.SetFilter("No.", Rec."No.");
                        if L_TransportHeader.FindFirst() then begin
                            Clear(TotalLooseBoxes);
                            L_TransportLine.Reset();
                            L_TransportLine.SetRange("No.", L_TransportHeader."No.");
                            if L_TransportLine.FindSet() then begin
                                repeat
                                    if L_TransportLine."Line No." = Rec."Line No." then begin
                                        TotalLooseBoxes += rec."Loose Boxes";
                                    end
                                    else begin
                                        TotalLooseBoxes += L_TransportLine."Loose Boxes";
                                    end;
                                until L_TransportLine.Next() = 0;

                            end;
                            L_TransportHeader."Loose Boxes" := TotalLooseBoxes;
                            L_TransportHeader.Modify()
                        end;
                        CurrPage.Update();
                    end;

                }
                // field("Opening Time"; Rec."Opening Time")
                // {
                //     ApplicationArea = All;
                // }


            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Parcel Details")
                {
                    RunObject = Page "Parcel Details";
                    RunPageLink = "Transportaion No." = FIELD("No."),
                                  "Transportaion Line No." = FIELD("Line No.");
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                action("Get planning Lines")
                {
                    Visible = false;

                    trigger OnAction()
                    begin
                        CLEAR(PagePlanningLines);
                        PlanningLines.RESET;
                        PagePlanningLines.FindTransportationLineNo(Rec);
                        PagePlanningLines.LOOKUPMODE := TRUE;
                        PlanningLines.SETCURRENTKEY("Entry Type", "Source Type");
                        GetHeader;
                        IF recGateEntryHeader."Location Code" <> '' THEN
                            PlanningLines.SETRANGE("Our Location Code", recGateEntryHeader."Location Code");
                        PagePlanningLines.SETTABLEVIEW(PlanningLines);
                        PagePlanningLines.EDITABLE(FALSE);
                        PagePlanningLines.RUNMODAL;
                    end;
                }
                action("Delete Lines")
                {
                    Image = Delete;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        TranportationLine.COPY(Rec);
                        CurrPage.SETSELECTIONFILTER(TranportationLine);
                        //MoveLinesInPlanningSheet(TranportationLine);
                        IF CONFIRM('Do you want to Move selected Lines in Planning Sheet?', FALSE) THEN BEGIN
                            IF TranportationLine.FINDFIRST THEN
                                REPEAT
                                    Rec.MoveLinesInPlanningSheet(TranportationLine);
                                UNTIL TranportationLine.NEXT = 0;
                        END
                        ELSE
                            IF CONFIRM('Do you want to delete all selected lines Permanently?', FALSE) THEN;

                        //MESSAGE(FORMAT(Rec.CO
                        //TransportationLine.DELETE(TRUE);
                    end;
                }




                action("Select Warehouse Receipts")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        WarehouseReceiptListPage: Page "Warehouse Receipts";
                        warehousereceiptheader: Record "Warehouse Receipt Header";
                        gateentryheader: Record "Gate Entry Header";
                        gateEntryLine: Record "Gate Entry Line";
                        test: page "Sales Order Subform";
                        ItemListPage: Page "Item List";
                        warehouseReceiptLine: Record "Warehouse Receipt Line";
                    begin
                        gateentryheader.Reset();
                        gateentryheader.SetRange("No.", Rec."No.");
                        if gateentryheader.FindFirst() then begin
                            Clear(WarehouseReceiptListPage);
                            warehousereceiptheader.Reset();
                            warehousereceiptheader.SetFilter("Transportation No.", '%1', '');
                            warehousereceiptheader.SetFilter("Location Code", gateentryheader."Location Code");

                            WarehouseReceiptListPage.SetTableView(warehousereceiptheader);
                            WarehouseReceiptListPage.LookupMode(true);
                            if WarehouseReceiptListPage.RunModal() = ACTION::LookupOK then begin
                                //warehousereceiptheader.Reset();

                                WarehouseReceiptListPage.SetSelectionFilter(warehousereceiptheader);
                                if warehousereceiptheader.FindSet() then begin
                                    repeat
                                        warehouseReceiptLine.Reset();
                                        warehouseReceiptLine.SetRange("No.", warehousereceiptheader."No.");
                                        warehouseReceiptLine.SetFilter("Source Document", format(warehouseReceiptLine."Source Document"::"Purchase Order"));
                                        if warehouseReceiptLine.FindSet() then begin
                                            repeat
                                                gateEntryLine.Reset();
                                                gateEntryLine.SetRange("No.", gateentryheader."No.");
                                                gateEntryLine.SetRange("Warehouse Receipt No.", warehouseReceiptLine."No.");
                                                if not gateEntryLine.FindFirst() then
                                                    InsetGateEntryLine(gateentryheader, warehouseReceiptLine);
                                            until warehouseReceiptLine.Next() = 0;
                                        end;
                                    until warehousereceiptheader.Next() = 0;
                                end;
                            end;
                        end;

                    end;


                }


            }
        }
    }
    local procedure InsetGateEntryLine(var gateentryheader: Record "Gate Entry Header"; var warehousereceiptline: Record "Warehouse Receipt Line")
    var
        gateEntryLine: Record "Gate Entry Line";
        purchHeader: Record "Purchase Header";
        warehouseReceiptHeader: Record "Warehouse Receipt Header";
        purchaseCard: Record "Purchase Header";


    begin

        gateEntryLine.Init();
        gateEntryLine."No." := gateentryheader."No.";
        gateEntryLine."Line No." := FindLastLineNo(gateentryheader);
        gateEntryLine."Warehouse Receipt No." := warehousereceiptline."No.";
        gateEntryLine."Source Document" := gateEntryLine."Document Type"::"Purchase Order";
        gateEntryLine."Document no" := warehousereceiptline."Source No.";
        gateEntryLine."Requested Receipt Date" := warehouseReceiptHeader."Requested Receipt Date";
        if (warehousereceiptline."Source Document" = warehousereceiptline."Source Document"::"Purchase Order") then begin
            gateEntryLine."Source Type" := gateEntryLine."Source Type"::Supplier;
        end;
        purchHeader.Reset();
        purchHeader.SetRange("No.", gateEntryLine."Document no");
        if purchHeader.FindFirst() then begin
            gateEntryLine.Validate("Source Name", purchHeader."Buy-from Vendor Name");
            gateEntryLine.Validate("Source No.", purchHeader."Buy-from Vendor No.");
        end;


        gateentryheader.Reset();
        gateentryheader.SetRange("No.", Rec."No.");
        if gateentryheader.FindFirst() then begin
            warehouseReceiptHeader.Reset();
            warehouseReceiptHeader.SetRange("No.", gateEntryLine."Warehouse Receipt No.");
            if warehouseReceiptHeader.FindFirst() then begin
                warehouseReceiptHeader."Transportation No." := gateentryheader."No.";
                warehouseReceiptHeader."Receipt Status" := gateentryheader."Receipt Status";
                warehouseReceiptHeader."Requested Receipt Date" := gateEntryHeader."Requested Receipt Date";
                warehouseReceiptHeader.Modify(true);
            end;
        end;

        purchaseCard.Reset();
        purchaseCard.SetRange("No.", gateEntryLine."Document no");
        if Purchasecard.Findfirst() then begin
            purchaseCard."Transportation No." := gateEntryLine."No.";
            purchaseCard."Receipt Status" := format(gateEntryLine."Transportation Receipt Status");
            purchaseCard.Modify();
        end;




        gateEntryLine.Insert();
        Commit();
    end;

    local procedure FindLastLineNo(P_gateEntryHeader: Record "Gate Entry Header"): Integer
    //Code to find a last line no in web order
    var
        L_gateEntryLine: Record "Gate Entry Line";
    begin
        L_gateEntryLine.RESET;
        //L_gateEntryLine.SETRANGE("Document Type", L_gateEntryLine."Document Type"::);
        L_gateEntryLine.SETRANGE("No.", P_gateEntryHeader."No.");
        IF L_gateEntryLine.FINDLAST THEN
            EXIT(L_gateEntryLine."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;

    trigger OnAfterGetRecord()
    begin
        /*
        IF CompanyType = CompanyType::Customer  THEN
        BEGIN
          MESSAGE(FORMAT(CompanyType));
        
            IF "Source Type" = "Source Type"::"Sales Shipment" THEN
              ERROR('You have select wrong selection')
        END;
        */

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        recGateEntryHeader.RESET;
        recGateEntryHeader.SETRANGE(recGateEntryHeader."No.", Rec."No.");
        IF recGateEntryHeader.FINDFIRST THEN begin
            Rec."Entry Type" := recGateEntryHeader.Type;
            // rec."Location code" := recGateEntryHeader."Location Code";
        end;
    end;

    var
        recGateEntryHeader: Record "Gate Entry Header";
        PlanningLines: Record "Planning Transportation Sheet";
        PagePlanningLines: Page "Transportation planning";
        TranportationLine: Record "Gate Entry Line";

    local procedure GetHeader()
    begin
        recGateEntryHeader.GET(Rec."No.");
    end;

    var
        test: Record 7332;
}

#pragma implicitwith restore

