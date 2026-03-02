page 90256 "Posted Transportation Card"
{
    Caption = 'Posted Transportation Card';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = "Posted Gate Entry Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
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
                    Visible = false;
                }
                field("Transportation Organized By"; Rec."Transportation Organized By")
                {
                    Importance = Promoted;
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
                field("Booking Reference No."; Rec."Booking Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                // field("LR/RR No."; Rec."LR/RR No.")
                // {
                //     ApplicationArea = All;
                // }
                // field("LR/RR Date"; Rec."LR/RR Date")
                // {
                //     ApplicationArea = All;
                // }
                // field("Vehicle No."; Rec."Vehicle No.")
                // {
                //     ApplicationArea = All;
                // }
                // field("Vehicle Capacity(KG)"; Rec."Vehicle Capacity(KG)")
                // {
                //     ApplicationArea = All;
                // }
                // field("Driver Name"; Rec."Driver Name")
                // {
                //     ApplicationArea = All;
                // }
                // field("Driver Phone No."; Rec."Driver Phone No.")
                // {
                //     ApplicationArea = All;
                // }
                field("Expected Delivery/Receipt Date"; Rec."Expected Delivery/Receipt Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                // field(Status; Rec.Status)
                // {
                //     ApplicationArea = All;
                // }

            }
            group("Booking Details")
            {
                field(Carrier; Rec.Carrier)
                {
                    ApplicationArea = all;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = all;
                }
                field("Expected Delivery Date"; Rec."Expected Delivery Date")
                {
                    ApplicationArea = all;
                    Caption = 'Booked Delivery Date';
                }
                field("Expected Delivery Time"; Rec."Expected Delivery Time")
                {
                    ApplicationArea = all;
                    Caption = 'Booked Delivery Time';
                }
                field("Booked Pallets"; Rec."Booked Pallets")
                {
                    ApplicationArea = all;
                }
                field(Lifts; Rec.Lifts)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loose Boxes"; Rec."Loose Boxes")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Curtain Side"; Rec."Curtain Side")
                {
                    ApplicationArea = all;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = all;
                }
                group(Status1)
                {
                    Caption = 'Status';
                    field("Receipt Status"; Rec."Receipt Status")
                    {
                        ApplicationArea = all;
                    }
                    field("Actual Receipt Date"; Rec."Actual Receipt Date")
                    {
                        ApplicationArea = all;
                    }
                    field("Actual Receipt Time"; Rec."Actual Receipt Time")
                    {
                        ApplicationArea = all;
                    }

                }
            }
            part(subpage; "Posted Transportation SubForm")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            // systempart(Links;)
            // {
            // }
            // systempart(Notes;)
            // {
            //     Visible = true;
            // }
        }
    }

    actions
    {
    }

    var
        GateEntryHeader: Record "Gate Entry Header";
        Text16500: Label 'Do you want to Post the Gate Entry?';
        GateEntryLine: Record "Gate Entry Line";
        LineCount: Integer;
        //  StandardDailog: Page 50111;
        //NoSeriesMgt: Codeunit 396;
        SalesSetup: Record 311;
        "Nos.": Code[20];
        Selection: Integer;
        WhseSetup: Record 5769;
}

