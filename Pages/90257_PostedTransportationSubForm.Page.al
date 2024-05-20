page 90257 "Posted Transportation SubForm"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Posted Gate Entry Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry Type"; Rec."Entry Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Transportation No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Transportation Receipt Status"; Rec."Transportation Receipt Status")
                {
                    ApplicationArea = all;
                }

                field("Warehouse Receipt No."; Rec."Warehouse Receipt No.")
                {
                    ApplicationArea = all;
                }
                field("Source Document"; Rec."Source Document")
                {
                    ApplicationArea = all;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }


                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document no"; Rec."Document no")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    //Visible = false;
                    Caption = 'Vendor No.';
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
                    //Visible = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
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
                            Rec."Goods Checked By" := USERID;
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
                }
                field(Lifts; Rec.Lifts)
                {
                    ApplicationArea = All;
                }
                field("Loose Boxes"; Rec."Loose Boxes")
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
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Parcel Details")
                {
                    Visible = false;
                    RunObject = Page "Parcel Details";
                    RunPageLink = "Transportaion No." = FIELD("No."),
                                  "Transportaion Line No." = FIELD("Line No");
                    ApplicationArea = All;
                }
            }
        }
    }

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

    var
        recGateEntryHeader: Record "Gate Entry Header";
}

