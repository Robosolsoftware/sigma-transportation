page 90262 "Posted Transport Line (API)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Posted Gate Entry Line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transportation Receipt Status"; Rec."Transportation Receipt Status")
                {
                    ApplicationArea = All;

                }
                field("Warehouse Receipt No."; Rec."Warehouse Receipt No.")
                {
                    ApplicationArea = All;

                }
                field("Source Document"; Rec."Source Document")
                {
                    ApplicationArea = All;

                }
                field("Document no"; Rec."Document no")
                {
                    ApplicationArea = All;

                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor No.';
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
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
                field("Goods Checked"; Rec."Goods Checked")
                {
                    ApplicationArea = All;

                }
                field("Goods Checked By"; Rec."Goods Checked By")
                {
                    ApplicationArea = All;

                }
                field("Total Pallet"; Rec."Total Pallet")
                {
                    ApplicationArea = All;
                    Caption = 'Booked pallets';
                }
                field(Lifts; Rec.Lifts)
                {
                    ApplicationArea = All;
                    Caption = 'Booked lifts';
                }
                field("Loose Boxes"; Rec."Loose Boxes")
                {
                    ApplicationArea = All;
                    Caption = 'Booked Loose Boxes';
                }
            }
        }
    }
}