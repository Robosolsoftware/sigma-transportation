page 90254 "Parcel Details"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Parcel Details";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Parcel UOM"; Rec."Parcel UOM")
                {
                    ApplicationArea = All;
                }
                field("Parcel Type"; Rec."Parcel Type")
                {
                    ApplicationArea = All;
                }
                field("Parcel UID"; Rec."Parcel UID")
                {
                    ApplicationArea = All;
                }
                field("Parcel Quantity"; Rec."Parcel Quantity")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Booking Reference No"; Rec."Booking Reference No")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Rec.UpdateWeight;
        CurrPage.UPDATE;
    end;
}

