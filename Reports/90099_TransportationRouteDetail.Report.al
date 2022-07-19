report 90299 "Transportation Route Detail"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './TransportationRouteDetail.rdlc';

    dataset
    {
        dataitem("Gate Entry Header"; "Gate Entry Header")
        {
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(Comments_GateEntryHeader; "Gate Entry Header".Comments)
            {
            }
            column(No_GateEntryHeader; "Gate Entry Header"."No.")
            {
            }
            column(DocumentDate_GateEntryHeader; "Gate Entry Header"."Document Date")
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
            column(VehicleNo_GateEntryHeader; "Gate Entry Header"."Vehicle No.")
            {
            }
            column(ExpectedDeliveryReceiptDate_GateEntryHeader; "Gate Entry Header"."Expected Delivery/Receipt Date")
            {
            }
            column(ShipmentMethodCode_GateEntryHeader; "Gate Entry Header"."Shipment Method Code")
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
            column(LRRRDate_GateEntryHeader; "Gate Entry Header"."LR/RR Date")
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(CompanyAddr4; CompanyAddr[4])
            {
            }
            column(CompanyAddr5; CompanyAddr[5])
            {
            }
            column(CompanyAddr6; CompanyAddr[6])
            {
            }
            column(CompanyAddr7; CompanyAddr[7])
            {
            }
            dataitem("Gate Entry Line"; "Gate Entry Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Gate Entry Header";
                DataItemTableView = SORTING("Route Sequence No.")
                                    ORDER(Ascending);
                column(SourceNo_GateEntryLine; "Gate Entry Line"."Source No.")
                {
                }
                column(SourceName_GateEntryLine; "Gate Entry Line"."Source Name")
                {
                }
                column(ExpectedDeliveryReceiptDate_GateEntryLine; "Gate Entry Line"."Expected Delivery/Receipt Date")
                {
                }
                column(CarrierQuantity_GateEntryLine; "Gate Entry Line"."Carrier Quantity")
                {
                }
                column(CarrierUOM_GateEntryLine; "Gate Entry Line"."Carrier UOM")
                {
                }
                column(TotalParcelsAmbient_GateEntryLine; "Gate Entry Line"."Total Parcels (Ambient)")
                {
                }
                column(TotalParcelsFridge_GateEntryLine; "Gate Entry Line"."Total Parcels (Fridge)")
                {
                }
                column(TotalWeightAmbient_GateEntryLine; "Gate Entry Line"."Total Weight (Ambient)")
                {
                }
                column(TotalWeightFridge_GateEntryLine; "Gate Entry Line"."Total Weight (Fridge)")
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CustAddr3; CustAddr[3])
                {
                }
                column(CustAddr4; CustAddr[4])
                {
                }
                column(CustAddr5; CustAddr[5])
                {
                }
                column(CustAddr6; CustAddr[6])
                {
                }
                column(CustAddr7; CustAddr[7])
                {
                }

                trigger OnAfterGetRecord()
                begin

                    CLEAR(CustAddr);


                    IF CountryRegion.GET("Gate Entry Line"."Country/Region Code") THEN;

                    CustAddr[1] := "Gate Entry Line"."Source Name";
                    CustAddr[2] := "Gate Entry Line".Address;
                    CustAddr[3] := "Gate Entry Line"."Address 2";
                    CustAddr[4] := "Gate Entry Line".City;
                    CustAddr[5] := "Gate Entry Line".County;
                    CustAddr[6] := "Gate Entry Line"."Post Code";
                    CustAddr[7] := CountryRegion.Name;
                    COMPRESSARRAY(CustAddr);
                end;
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                FormatAddr.Company(CompanyAddr, CompanyInfo);

                CompanyInfo.CALCFIELDS(Picture);
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

    var
        CompanyInfo: Record 79;
        FormatAddr: Codeunit 365;
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[7] of Text[50];
        CountryRegion: Record 9;
}

