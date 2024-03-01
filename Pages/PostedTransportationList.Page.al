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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                // field("Transport Area Code"; Rec."Transport Area Code")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
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
                    Visible = false;
                }
                field("Booking Reference No."; Rec."Booking Reference No.")
                {
                    ApplicationArea = All;
                }


                // field(Status; Rec.Status)
                // {
                //     ApplicationArea = All;
                // }
                field("Transportation Organized By"; Rec."Transportation Organized By")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Total parcel Weight"; Rec."Total parcel Weight")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = all;

                }
            }
        }
    }

    actions
    {
    }
}

