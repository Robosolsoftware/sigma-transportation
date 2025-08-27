page 90261 "Posted Transport List (API)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Posted Gate Entry Header";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Editable = false;
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
                field("Document Time"; Rec."Document Time")
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
                field("Booking Reference No."; Rec."Booking Reference No.")
                {
                    ApplicationArea = All;


                }
                field("Transportation Organized By"; Rec."Transportation Organized By")
                {
                    ApplicationArea = All;


                }
                field(Carrier; Rec.Carrier)
                {
                    ApplicationArea = All;


                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;


                }
                field("Expected Delivery Date"; Rec."Expected Delivery Date")
                {
                    ApplicationArea = All;
                    Caption = 'Booked Delivery Date';

                }
                field("Expected Delivery Time"; Rec."Expected Delivery Time")
                {
                    ApplicationArea = All;
                    Caption = 'Booked Delivery Time';

                }
                field("Booked Pallets"; Rec."Booked Pallets")
                {
                    ApplicationArea = All;


                }
                field(Lifts; Rec.Lifts)
                {
                    ApplicationArea = All;
                    Caption = 'Booked Lifts';

                }
                field("Loose Boxes"; Rec."Loose Boxes")
                {
                    ApplicationArea = All;
                    Caption = 'Booked Loose Boxes';

                }
                field("Curtain Side"; Rec."Curtain Side")
                {
                    ApplicationArea = All;


                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;


                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;


                }
                field("Actual Receipt Date"; Rec."Actual Receipt Date")
                {
                    ApplicationArea = All;


                }
                field("Actual Receipt Time"; Rec."Actual Receipt Time")
                {
                    ApplicationArea = All;


                }

            }
        }
    }
}