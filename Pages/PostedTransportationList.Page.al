page 90255 "Posted Transportation List"
{
    CardPageID = "Posted Transportation Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Posted Gate Entry Header";
    SourceTableView = SORTING("Document Date", "No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Services Code"; Rec."Shipping Agent Services Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Booking Reference No."; Rec."Booking Reference No.")
                {
                    ApplicationArea = All;
                }
                field("LR/RR No."; Rec."LR/RR No.")
                {
                    ApplicationArea = All;
                }
                field("LR/RR Date"; Rec."LR/RR Date")
                {
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Capacity(KG)"; Rec."Vehicle Capacity(KG)")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Transportation Organized By"; Rec."Transportation Organized By")
                {
                    ApplicationArea = All;
                }
                field("Gate Entry No."; Rec."Gate Entry No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

