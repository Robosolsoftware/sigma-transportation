report 90257 Trip_Vendor_cust
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './TripVendorcust.rdlc';

    dataset
    {
        dataitem("Gate Entry Line"; "Gate Entry Line")
        {
            CalcFields = "Goods Checked", "Goods Checked By";
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
            column(ExtrnalDocNo; "Sales Header"."External Document No.")
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

            trigger OnAfterGetRecord()
            begin
                //CAS-01968-W1Z5R4 swapnil s

                CLEAR(ParcelDetails);
                ParcelDetails.RESET;
                ParcelDetails.SETRANGE("Transportaion No.", "Gate Entry Line"."No.");
                ParcelDetails.SETRANGE("Transportaion Line No.", "Gate Entry Line"."Line No.");
                IF ParcelDetails.FINDFIRST THEN;
                //CAS-01968-W1Z5R4 swapnil s
                IF (ParcelDetails."Document Type" = ParcelDetails."Document Type"::"Sales Order") AND
                   (ParcelDetails."Document Type" = ParcelDetails."Document Type"::"Sales Shipment") THEN BEGIN
                    "Sales Header".GET(ParcelDetails."Transportaion No.");

                END;
            end;
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
        "Sales Header": Record 36;
}

