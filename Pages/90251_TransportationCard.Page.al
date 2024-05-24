#pragma implicitwith disable
page 90251 "Transportation Card"
{
    Caption = 'Transportation Card';
    PageType = Document;
    Permissions = TableData 36 = m,
                  TableData 38 = m;
    RefreshOnActivate = true;
    SourceTable = "Gate Entry Header";


    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = true;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transport Area Code"; Rec."Transport Area Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Services Code"; Rec."Shipping Agent Services Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Transportation Organized By"; Rec."Transportation Organized By")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Document Time"; Rec."Document Time")
                {
                    ApplicationArea = All;
                }
                field("Booking Reference No."; Rec."Booking Reference No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("LR/RR No."; Rec."LR/RR No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("LR/RR Date"; Rec."LR/RR Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Vehicle Capacity(KG)"; Rec."Vehicle Capacity(KG)")
                {
                    CaptionClass = CapacityText;
                    Caption = 'Vehicle Capacity';
                    DecimalPlaces = 0 : 2;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Avalaible Vehicle Capacity(KG)"; Rec."Avalaible Vehicle Capacity(KG)")
                {
                    CaptionClass = AvlCapacityText;
                    Caption = 'Avalaible Vehicle Capacity';
                    DecimalPlaces = 0 : 2;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    Visible = IsDelivery;
                    ApplicationArea = All;

                }
                field("Driver Phone No."; Rec."Driver Phone No.")
                {
                    Visible = IsDelivery;
                    ApplicationArea = All;
                }
                field("Expected Delivery/Receipt Date"; Rec."Expected Delivery/Receipt Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Expected Delivery/Receipt Time"; Rec."Expected Delivery/Receipt Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Total parcel Weight"; Rec."Total parcel Weight")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                // field(Status; Rec.Status)
                // {
                //     ApplicationArea = All;

                // }
                // field(Comments; rec.Comments)
                // {
                //     MultiLine = true;
                //     ApplicationArea = All;
                // }
                field("Transport Booking Cost"; Rec."Transport Booking Cost")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                    Visible = false;
                }
                // group(Collection)
                // {
                //     Caption = 'Collection';
                //     field("Collection Date"; Rec."Collection Date")
                //     {
                //         Importance = Additional;
                //         ApplicationArea = All;
                //     }
                //     field("Collection Time"; Rec."Collection Time")
                //     {
                //         Importance = Additional;
                //         ApplicationArea = All;
                //     }
                // }
            }


            group("Booking Details")
            {
                field(Carrier; Rec.Carrier)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;

                }
                field("Expected Delivery Date"; Rec."Expected Delivery Date")
                {
                    ApplicationArea = all;
                    Caption = 'Booked Delivery Date';
                }
                field("Expected Delivery Time"; Rec."Expected Delivery Time")
                {
                    ApplicationArea = all;
                    Caption = 'Booked Delivery Time';
                }
                field("Booked Pallets"; Rec."Booked Pallets")
                {
                    ApplicationArea = all;
                }
                field(Lifts; Rec.Lifts)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loose Boxes"; Rec."Loose Boxes")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No. of Items"; Rec."No. of Items")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Curtain Side"; Rec."Curtain Side")
                {
                    ApplicationArea = all;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = all;
                }
                group(Status1)
                {
                    Caption = 'Status';
                    field("Receipt Status"; Rec."Receipt Status")
                    {
                        ApplicationArea = all;
                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            if (Rec."Expected Delivery Date" = 0D) and (Rec."Receipt Status" = rec."Receipt Status"::"Transportation Booked") then
                                Error('You cannot select "Transportation Booked" if "Booked Delivery Date" is empty.');

                            if (Rec."Actual Receipt Date" = 0D) and (Rec."Receipt Status" = rec."Receipt Status"::"Goods Arrived") then
                                Error('You cannot select "Goods Arrived" if "Actual Receipt Date" is empty.');
                        end;
                    }
                    field("Actual Receipt Date"; Rec."Actual Receipt Date")
                    {
                        ApplicationArea = all;
                    }
                    field("Actual Receipt Time"; Rec."Actual Receipt Time")
                    {
                        ApplicationArea = all;
                    }

                }
            }




            part(subpage; "Transportation SubForm")
            {
                //Editable = EditFalse;
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
                UpdatePropagation = Both;
            }
        }

        area(factboxes)
        {
            // systempart(; Links)
            // {
            // }
            // systempart(; Notes)
            // {
            //     Visible = true;
            // }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1000000013>")
            {
                Caption = 'P&osting';
                Image = Post;
                action("<Codeunit Transportation - Post>")
                {
                    Caption = 'Po&st';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    RunObject = Codeunit "Transportation - Post";
                    ShortCutKey = 'F9';
                }
                // action("<Action1000000027>")
                // {
                //     Caption = 'Change Status';
                //     Image = Status;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     begin

                //         IF Rec.Status = Rec.Status::Open THEN
                //             Selection := DIALOG.STRMENU('Open,Released,Closed', 2)
                //         ELSE
                //             Selection := DIALOG.STRMENU('Open,Released,Closed', 1);


                //         IF Selection = 0 THEN
                //             EXIT;
                //         IF Selection = 1 THEN BEGIN
                //             Rec.Status := Rec.Status::Open;
                //             // CLEAR("Expected Delivery/Receipt Date");
                //             CLEAR(Rec."Total parcel Weight");
                //             UpdateDeliveryDateTimeOnOpen(Rec);
                //         END;
                //         IF Selection = 2 THEN BEGIN
                //             Rec.CALCFIELDS("Total parcel Weight");
                //             IF Rec."Vehicle Capacity(KG)" < Rec."Total parcel Weight" THEN
                //                 IF NOT CONFIRM('Total parcel weight is more than vehicle capacity.\\Do you want to continue?', FALSE) THEN
                //                     EXIT;

                //             Rec.Status := Rec.Status::Released;
                //             UpdateDeliveryDateTime(Rec);
                //         END;
                //     end;
            }
            //     action("<Action1000000015>")
            //     {
            //         Caption = 'Calculate Total Parcel Weight';
            //         Image = Calculate;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         Visible = false;
            //         ApplicationArea = All;

            //         trigger OnAction()
            //         var
            //             L_Totqty: Decimal;
            //         begin
            //             GateEntryLine.RESET;
            //             GateEntryLine.SETRANGE(GateEntryLine."No.", Rec."No.");
            //             IF GateEntryLine.FINDSET THEN
            //                 REPEAT

            //                     CLEAR(L_Totqty);
            //                     CLEAR(L_TotalWeight_Ambient);

            //                     PackageDetail.RESET;
            //                     PackageDetail.SETRANGE("Transportaion No.", GateEntryLine."No.");
            //                     PackageDetail.SETRANGE("Transportaion Line No.", GateEntryLine."Line No.");
            //                     PackageDetail.SETRANGE("Parcel Type", PackageDetail."Parcel Type"::Ambient);
            //                     IF PackageDetail.FINDSET THEN
            //                         REPEAT
            //                             L_Totqty += PackageDetail."Parcel Quantity";
            //                             L_TotalWeight_Ambient += PackageDetail."Net Weight";
            //                         UNTIL PackageDetail.NEXT = 0;


            //                     GateEntryLine."Total Weight (Ambient)" := L_Totqty * L_TotalWeight_Ambient;
            //                     //GateEntryLine."Total Parcels (Ambient)":= L_Totqty;

            //                     CLEAR(L_Qty_Fridge);
            //                     CLEAR(L_TotalWeight_Fridge);

            //                     PackageDetailFridge.RESET;
            //                     PackageDetailFridge.SETRANGE("Transportaion No.", GateEntryLine."No.");
            //                     PackageDetailFridge.SETRANGE("Transportaion Line No.", GateEntryLine."Line No.");
            //                     PackageDetailFridge.SETRANGE("Parcel Type", PackageDetailFridge."Parcel Type"::Fridge);
            //                     IF PackageDetailFridge.FINDSET THEN
            //                         REPEAT
            //                             L_Qty_Fridge += PackageDetailFridge."Parcel Quantity";
            //                             L_TotalWeight_Fridge += PackageDetailFridge."Net Weight";
            //                         UNTIL PackageDetailFridge.NEXT = 0;

            //                     GateEntryLine."Total Weight (Fridge)" := L_Qty_Fridge * L_TotalWeight_Fridge;
            //                     //GateEntryLine."Total Parcels (Fridge)":=L_Qty_Fridge;

            //                     GateEntryLine."Total Weight(KG)(Booked)" := GateEntryLine."Total Weight (Ambient)" + GateEntryLine."Total Weight (Fridge)";
            //                     GateEntryLine."Total Parcels(Booked)" := L_Qty_Fridge + L_Totqty;

            //                     GateEntryLine.MODIFY;

            //                 UNTIL GateEntryLine.NEXT = 0;
            //         end;
            //     }

            // group("<Action1000000029>")
            // {
            //     Caption = 'Print';
            //     Image = Email;
            //     action("<Action224>")
            //     {
            //         Caption = '&Consignment';
            //         Image = Print;
            //         ApplicationArea = All;

            //         trigger OnAction()
            //         begin
            //             CLEAR(TripDetails);
            //             GateEntryHeader.RESET;
            //             GateEntryHeader.SETFILTER(GateEntryHeader."No.", '%1', Rec."No.");
            //             TripDetails.SETTABLEVIEW(GateEntryHeader);
            //             TripDetails.RUNMODAL;
            //         end;
            //     }
            //     action("<Action225>")
            //     {
            //         Caption = '&Route Details';
            //         Image = Print;
            //         ApplicationArea = All;

            //         trigger OnAction()
            //         begin
            //             //-----CAS-03084-M6R2S5---31/08/2016----pravin.d-----start----
            //             CLEAR(TransportationRouteDetails);
            //             GateEntryHeader.RESET;
            //             GateEntryHeader.SETFILTER(GateEntryHeader."No.", '%1', Rec."No.");
            //             TransportationRouteDetails.SETTABLEVIEW(GateEntryHeader);
            //             TransportationRouteDetails.RUNMODAL;
            //             //-----CAS-03084-M6R2S5---31/08/2016----pravin.d-----End------
            //         end;
            //     }
            //     action("&Email")
            //     {
            //         Caption = '&Email';
            //         Image = Email;
            //         ApplicationArea = All;
            //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //         //PromotedCategory = Process;

            //         // trigger OnAction()
            //         // var
            //         //     SalesInvHeader: Record 112;
            //         // begin
            //         //     //--CAS-02345-N3M7X5----Pravin.D.--------------facility to send a email to customer/supplier for booking and collection.
            //         //     IF Rec.Status = Rec.Status::Released THEN
            //         //         GateEntryHeader.SendMail(Rec)
            //         //     ELSE
            //         //         ERROR('Status must be released.')
            //         // end;
            //     }
            // }
            // group("<Action1000000032>")
            // {
            //     Caption = 'Function';
            //     action("<Action1000000028>")
            //     {
            //         Caption = '&Track Package';
            //         Image = ItemTracking;
            //         ApplicationArea = All;

            //         trigger OnAction()
            //         begin
            //             HYPERLINK(Rec.GetTrackingInternetAddr);
            //         end;
            //     }
            // action("Select Slot")
            // {
            //     Image = Allocate;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         Slots: Record "Slot Master";
            //         PageSlotlist: Page "Slot List";
            //     begin
            //         //Rec.TESTFIELD(Status, Rec.Status::Open);
            //         Rec.TESTFIELD("Location Code");
            //         IF Rec."Slot No." <> 0 THEN
            //             ERROR(SlotRegisteredError);
            //         Slots.RESET;
            //         Slots.SETRANGE("Location Code", Rec."Location Code");
            //         Slots.SETFILTER(Date, '>=%1', WORKDATE);
            //         IF NOT Slots.FINDSET THEN
            //             MESSAGE('Slots not created for Location %1, Please create slots', Rec."Location Code")
            //         ELSE BEGIN
            //             CLEAR(PageSlotlist);
            //             PageSlotlist.LOOKUPMODE(TRUE);
            //             PageSlotlist.SETTABLEVIEW(Slots);
            //             IF PAGE.RUNMODAL(Page::"Slot List", Slots) = ACTION::LookupOK THEN BEGIN
            //                 IF Slots.Booked THEN
            //                     ERROR('Slot already booked, please select another slot')
            //                 ELSE BEGIN
            //                     //CheckDeliveryDate(Rec."No.",Slots.Date);blocked by alok on 16052018
            //                     Rec.VALIDATE("Expected Delivery/Receipt Date", Slots.Date);
            //                     Rec.VALIDATE("Expected Delivery/Receipt Time", Slots."Start Time");
            //                     Rec.VALIDATE("Slot No.", Slots."Entry No");
            //                     CurrPage.UPDATE;
            //                 END;
            //             END;
            //         END;
            //     end;
            // }
            // action("Cancel Slot")
            // {
            //     Image = Cancel;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     begin
            //         IF Rec."Slot No." <> 0 THEN
            //             IF CONFIRM('Are you sure you want to cancel slot for this Job?') THEN BEGIN
            //                 CLEAR(Rec."Slot No.");
            //                 CLEAR(Rec."Expected Delivery/Receipt Date");
            //                 CLEAR(Rec."Expected Delivery/Receipt Time");
            //                 CurrPage.UPDATE;
            //                 MESSAGE('Slot Cancelled');
            //             END;
            //     end;
            // }
            //}
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //"Avalaible Vehicle Capacity(KG)":=CalculateAvailableCapacity(Rec);
        IF (Rec.Type = Rec.Type::Delivery) OR (Rec.Type = Rec.Type::ForCollection) THEN
            IsDelivery := TRUE
        ELSE
            IsDelivery := FALSE;
    end;

    trigger OnAfterGetRecord()
    begin
        // IF Rec.Status = Rec.Status::Open THEN
        //     EditFalse := TRUE
        // ELSE
        //     EditFalse := FALSE;

        IF (Rec.Type = Rec.Type::Delivery) OR (Rec.Type = Rec.Type::ForCollection) THEN
            IsDelivery := TRUE
        ELSE
            IsDelivery := FALSE;
        Rec.Caption(CapacityText, AvlCapacityText);
    end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     EditFalse := tru;
    // end;

    trigger OnOpenPage()
    begin
        IsDelivery := DeliveryVisible;
        IF (Rec.Type = Rec.Type::Delivery) OR (Rec.Type = Rec.Type::ForCollection) THEN
            IsDelivery := TRUE
        ELSE
            IsDelivery := FALSE;
    end;

    var
        GateEntryHeader: Record "Gate Entry Header";
        GateEntryLine: Record "Gate Entry Line";
        LineCount: Integer;
        // StandardDailog: Page 50008;
        NoSeriesMgt: Codeunit 396;
        SalesSetup: Record 311;
        "Nos.": Code[20];
        Selection: Integer;
        WhseSetup: Record 5769;
        PackageDetail: Record "Parcel Details";
        PackageDetailFridge: Record "Parcel Details";
        L_Qty_Fridge: Decimal;
        L_TotalWeight_Ambient: Decimal;
        L_TotalWeight_Fridge: Decimal;
        TripDetails: Report "Consignment Card";
        TransportationRouteDetails: Report "Transportation Route Detail";
        // Trip_Vendor_cust: Report 60007;
        GateEntryLine1: Record "Gate Entry Line";
        PurDocType: Option;
        "PurDocNo.": Code[30];
        PurchaseHeader: Record 38;
        SalDocType: Option;
        SalDocNo: Code[10];
        SalesHeader: Record 36;
        EditFalse: Boolean;
        [InDataSet]


        IsDelivery: Boolean;
        DeliveryVisible: Boolean;
        SlotRegisteredError: Label 'Slot already booked for this job.\\ To select new slot please cancel slot and Try again.. ';
        ShippingAgentService: Record 5790;
        CapacityText: Text;
        AvlCapacityText: Text;
        InvalidDateError: Label 'There are line with Expected Delivery/Reciept date less then selected slot.';

    // local procedure UpdateDeliveryDateTime(GateEntryHeader: Record "Gate Entry Header")
    // var
    //     RecGateEntryLine: Record "Gate Entry Line";
    // begin
    //     RecGateEntryLine.RESET;
    //     RecGateEntryLine.SETRANGE("No.", GateEntryHeader."No.");
    //     IF RecGateEntryLine.FINDFIRST THEN
    //         REPEAT
    //             RecGateEntryLine."Expected Delivery/Receipt Date" := GateEntryHeader."Expected Delivery/Receipt Date";
    //             RecGateEntryLine."Expected Delivery/Receipt Time" := GateEntryHeader."Expected Delivery/Receipt Time";
    //             //RecGateEntryLine.VALIDATE(Status, GateEntryHeader.Status);
    //             RecGateEntryLine.MODIFY;
    //             Rec.UpdateStatus(RecGateEntryLine);
    //         UNTIL RecGateEntryLine.NEXT = 0;
    // end;

    // local procedure UpdateDeliveryDateTimeOnOpen(GateEntryHeader: Record "Gate Entry Header")
    // var
    //     RecGateEntryLine: Record "Gate Entry Line";
    // begin
    //     RecGateEntryLine.RESET;
    //     RecGateEntryLine.SETRANGE("No.", GateEntryHeader."No.");
    //     IF RecGateEntryLine.FINDFIRST THEN
    //         REPEAT
    //             RecGateEntryLine."Expected Delivery/Receipt Date" := 0D;//GateEntryHeader."Expected Delivery/Receipt Date";
    //             RecGateEntryLine."Expected Delivery/Receipt Time" := 0T;//GateEntryHeader."Expected Delivery/Receipt Time";
    //                                                                     //ecGateEntryLine.VALIDATE(Status, GateEntryHeader.Status);
    //             RecGateEntryLine.MODIFY;
    //         UNTIL RecGateEntryLine.NEXT = 0;
    // end;

    //[Scope('Internal')]
    procedure SetGlobalVariable(bool: Boolean)
    begin
        DeliveryVisible := bool;
    end;

    local procedure CheckDeliveryDate(GateEntryNo: Code[20]; SelectedDate: Date)
    var
        RecGateEntryLine: Record "Gate Entry Line";
    begin
        RecGateEntryLine.RESET;
        RecGateEntryLine.SETRANGE("No.", GateEntryNo);
        RecGateEntryLine.SETFILTER("Expected Delivery/Receipt Date", '<%1', SelectedDate);
        IF RecGateEntryLine.FINDSET THEN
            ERROR(InvalidDateError);
    end;
}

#pragma implicitwith restore

