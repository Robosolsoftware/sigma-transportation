report 90253 "Consignment Card"
{
    // //Swapnil :- Added code from adding External Doc number CAS-01968-W1Z5R4
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ConsignmentCard.rdlc';

    Caption = 'Consignment Card';

    dataset
    {
        dataitem("Gate Entry Header"; "Gate Entry Header")
        {
            column(CompanyinfoPicture; CompInfo.Picture)
            {
            }
            column(CompyName; CompInfo.Name)
            {
            }
            column(ComapnyPostCode; CompInfo."Post Code")
            {
            }
            column(ComapnyTown; CompInfo.City)
            {
            }
            column(CompyAddr; CompInfo.Address)
            {
            }
            column(No_GateEntryHeader; "Gate Entry Header"."No.")
            {
            }
            column(DocumentDate_GateEntryHeader; "Gate Entry Header"."Document Date")
            {
            }
            column(DocumentTime_GateEntryHeader; "Gate Entry Header"."Document Time")
            {
            }
            column(LocationCode_GateEntryHeader; "Gate Entry Header"."Location Code")
            {
            }
            column(ShippingAgentCode_GateEntryHeader; "Gate Entry Header"."Shipping Agent Code")
            {
            }
            column(TransportationOrganizedBy_GateEntryHeader; "Gate Entry Header"."Transportation Organized By")
            {
            }
            column(LRRRNo_GateEntryHeader; "Gate Entry Header"."LR/RR No.")
            {
            }
            column(LRRRDate_GateEntryHeader; "Gate Entry Header"."LR/RR Date")
            {
            }
            column(VehicleNo_GateEntryHeader; "Gate Entry Header"."Vehicle No.")
            {
            }
            column(ExpectedDeliveryReceiptDate_GateEntryHeader; "Gate Entry Header"."Expected Delivery/Receipt Date")
            {
            }
            column(Status; Status)
            {
            }
            column(ShipmentMethodCode_GateEntryHeader; "Gate Entry Header"."Shipment Method Code")
            {
            }
            column(NoSeries_GateEntryHeader; "Gate Entry Header"."No. Series")
            {
            }
            column(ShippingAgentServicesCode_GateEntryHeader; "Gate Entry Header"."Shipping Agent Services Code")
            {
            }
            column(BookingReferenceNo_GateEntryHeader; "Gate Entry Header"."Booking Reference No.")
            {
            }
            column(VehicleCapacityKG_GateEntryHeader; "Gate Entry Header"."Vehicle Capacity(KG)")
            {
            }
            column(DriverName_GateEntryHeader; "Gate Entry Header"."Driver Name")
            {
            }
            column(DriverPhoneNo_GateEntryHeader; "Gate Entry Header"."Driver Phone No.")
            {
            }
            column(PostingDate_GateEntryHeader; "Gate Entry Header"."Posting Date")
            {
            }
            column(S_name; GateEntryLine."Source Name")
            {
            }
            column(TotalparcelWeight_GateEntryHeader; "Gate Entry Header"."Total parcel Weight")
            {
            }
            dataitem("Gate Entry Line"; "Gate Entry Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Line No.");
                RequestFilterFields = "Source No.";
                CalcFields = "Goods Checked By", "Goods Checked";
                column(ExternalDocNo; SH."External Document No.")
                {
                }
                column(No_GateEntryLine; "Gate Entry Line"."No.")
                {
                }
                column(InvoiceNumber; ParcelDetails."Document No.")
                {
                }
                column(Parcel_UOM; ParcelDetails."Parcel UOM")
                {
                }
                column(Parcel_docType; ParcelDetails."Document Type")
                {
                }
                column(EntryType_GateEntryLine; "Gate Entry Line"."Entry Type")
                {
                }
                column(LineNo_GateEntryLine; "Gate Entry Line"."Line No.")
                {
                }
                column(SourceNo_GateEntryLine; "Gate Entry Line"."Source No.")
                {
                }
                column(SourceName_GateEntryLine; "Gate Entry Line"."Source Name")
                {
                }
                column(OrderAddresscode_GateEntryLine; "Gate Entry Line"."Order Address code")
                {
                }
                column(Address_GateEntryLine; "Gate Entry Line".Address)
                {
                }
                column(Address2_GateEntryLine; "Gate Entry Line"."Address 2")
                {
                }
                column(GoodsChecked_GateEntryLine; "Gate Entry Line"."Goods Checked")
                {
                }
                column(GoodsCheckedBy_GateEntryLine; "Gate Entry Line"."Goods Checked By")
                {
                }
                column(TotalFridgeParcels_GateEntryLine; "Gate Entry Line"."Total Fridge Parcels")
                {
                }
                column(StickeronBox_GateEntryLine; "Gate Entry Line"."Sticker on Box")
                {
                }
                column(Scan_GateEntryLine; "Gate Entry Line".Scan)
                {
                }
                column(SupplierinvoiceNo_GateEntryLine; "Gate Entry Line"."Supplier invoice No.")
                {
                }
                column(ExpectedDeliveryReceiptDate_GateEntryLine; "Gate Entry Line"."Expected Delivery/Receipt Date")
                {
                }
                column(ActualDeliveryReceiptDate_GateEntryLine; "Gate Entry Line"."Actual Delivery/Receipt Date")
                {
                }
                column(CarrierQuantity_GateEntryLine; "Gate Entry Line"."Carrier Quantity")
                {
                }
                column(CarrierUOM_GateEntryLine; "Gate Entry Line"."Carrier UOM")
                {
                }
                column(City_GateEntryLine; "Gate Entry Line".City)
                {
                }
                column(County_GateEntryLine; "Gate Entry Line".County)
                {
                }
                column(PostCode_GateEntryLine; "Gate Entry Line"."Post Code")
                {
                }
                column(CountryRegionCode_GateEntryLine; "Gate Entry Line"."Country/Region Code")
                {
                }
                column(TotalParcelsAmbient_GateEntryLine; "Gate Entry Line"."Total Parcels (Ambient)")
                {
                }
                column(TotalWeightAmbient_GateEntryLine; "Gate Entry Line"."Total Weight (Ambient)")
                {
                }
                column(RouteSequenceNo_GateEntryLine; "Gate Entry Line"."Route Sequence No.")
                {
                }
                column(BookingReferenceNo_GateEntryLine; "Gate Entry Line"."Booking Reference No.")
                {
                }
                column(SourceType_GateEntryLine; "Gate Entry Line"."Source Type")
                {
                }
                column(TotalParcelsFridge_GateEntryLine; "Gate Entry Line"."Total Parcels (Fridge)")
                {
                }
                column(TotalWeightFridge_GateEntryLine; "Gate Entry Line"."Total Weight (Fridge)")
                {
                }
                column(TotalParcels_GateEntryLine; "Gate Entry Line"."Total Parcels(Booked)")
                {
                }
                column(TotalWeight_GateEntryLine; "Gate Entry Line"."Total Weight(KG)(Booked)")
                {
                }
                column(OpeningTime; "Gate Entry Line"."Opening Time")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //CAS-01968-W1Z5R4 swapnil s

                    CLEAR(ParcelDetails);

                    ParcelDetails.RESET;
                    ParcelDetails.SETRANGE("Transportaion No.", "Gate Entry Line"."No.");
                    ParcelDetails.SETRANGE("Transportaion Line No.", "Gate Entry Line"."Line No.");
                    IF ParcelDetails.FINDFIRST THEN BEGIN

                        // sales order
                        IF (ParcelDetails."Document Type" = ParcelDetails."Document Type"::"Sales Order") THEN BEGIN
                            CLEAR(SH);
                            SH.SETFILTER("Document Type", '%1', SH."Document Type"::Order);
                            SH.SETRANGE("No.", ParcelDetails."Document No.");
                            IF SH.FINDLAST THEN;
                        END
                        ELSE
                            IF (ParcelDetails."Document Type" = ParcelDetails."Document Type"::"Sales Shipment") THEN BEGIN
                                CLEAR(SH);
                                SH.SETFILTER("Document Type", '%1', SH."Document Type"::"Return Order");
                                SH.SETRANGE("No.", ParcelDetails."Document No.");
                                IF SH.FINDLAST THEN;
                            END;
                        // Purchase order
                        IF (ParcelDetails."Document Type" = ParcelDetails."Document Type"::"Purchase Order") THEN BEGIN
                            CLEAR(SH);
                            SH.SETFILTER("Document Type", '%1', SH."Document Type"::Order);
                            SH.SETRANGE("No.", ParcelDetails."Document No.");
                            IF SH.FINDLAST THEN;
                        END
                        ELSE
                            IF (ParcelDetails."Document Type" = ParcelDetails."Document Type"::"Purchase Return") THEN BEGIN
                                CLEAR(SH);
                                SH.SETFILTER("Document Type", '%1', SH."Document Type"::"Return Order");
                                SH.SETRANGE("No.", ParcelDetails."Document No.");
                                IF SH.FINDLAST THEN;
                            END;



                    END;
                    // MESSAGE(FORMAT(SH."External Document No."));
                    //CAS-01968-W1Z5R4 swapnil s
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(CompInfo.Picture);
    end;

    var
        CompInfo: Record 79;
        PrintOnNextPage: Boolean;
        Vendor: Boolean;
        Customer: Boolean;
        GateEntryLine: Record "Gate Entry Line";
        CopyText: Text[30];
        OutputNo: Integer;
        ParcelDetails: Record "Parcel Details";
        SH: Record 36;
        Status: Text;
}

