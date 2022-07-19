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
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                field("Actual Delivery/Receipt Date"; Rec."Actual Delivery/Receipt Date")
                {
                    ApplicationArea = All;
                }
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
                field("Total Fridge Parcels"; Rec."Total Fridge Parcels")
                {
                    ApplicationArea = All;
                }
                field("Sticker on Box"; Rec."Sticker on Box")
                {
                    ApplicationArea = All;
                }
                field("Carrier Quantity"; Rec."Carrier Quantity")
                {
                    ApplicationArea = All;
                }
                field("Carrier UOM"; Rec."Carrier UOM")
                {
                    ApplicationArea = All;
                }
                field("Total Parcels (Ambient)"; Rec."Total Parcels (Ambient)")
                {
                    ApplicationArea = All;
                }
                field("Total Weight (Ambient)"; Rec."Total Weight (Ambient)")
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
                    RunObject = Page "Parcel Details";
                    RunPageLink = "Transportaion No." = FIELD("No."),
                                  "Transportaion Line No." = FIELD("Line No");
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

