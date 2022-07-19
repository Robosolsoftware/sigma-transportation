#pragma implicitwith disable
page 90260 "Transportation planning"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Worksheet;
    RefreshOnActivate = true;
    SourceTable = "Planning Transportation Sheet";

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
                field("Order Address/Ship To Code"; Rec."Order Address/Ship To Code")
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
                }
                field("Supplier invoice No."; Rec."Supplier invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Expected Delivery/Receipt Date"; Rec."Expected Delivery/Receipt Date")
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
                field("Booking Reference No."; Rec."Booking Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Total Parcels"; Rec."Total Parcels")
                {
                    ApplicationArea = All;
                }
                field("Total Weight(KG)"; Rec."Total Weight(KG)")
                {
                    ApplicationArea = All;
                }
                field("Expected Delivery/Receipt Week"; Rec."Expected Delivery/Receipt Week")
                {
                    ApplicationArea = All;
                }
                field("Opening Time"; Rec."Opening Time")
                {
                    ApplicationArea = All;
                }
                field("Our Location Code"; Rec."Our Location Code")
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
            action("Shedule Selected lines")
            {
                Visible = false;
            }
            action("Parcel Details")
            {
                RunObject = Page "Parcel Details";
                RunPageLink = "Transportaion Line No." = FIELD("Line No."),
                              "Transportaion No." = CONST('PLANNED');
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.UPDATE(TRUE);
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::LookupOK] THEN BEGIN
            Planninglines.COPY(Rec);
            CurrPage.SETSELECTIONFILTER(Planninglines);
            IF Planninglines.FINDFIRST THEN
                REPEAT
                    LineNo += 10000;
                    Rec.ScheduleSelectedLines(Planninglines, DocNo, LineNo);
                UNTIL Planninglines.NEXT = 0;
        END;
    end;

    var
        Planninglines: Record "Planning Transportation Sheet";
        LineNo: Integer;
        TranporationLines1: Record "Gate Entry Line";
        DocNo: Code[20];

    //[Scope('Internal')]
    procedure FindTransportationLineNo(var TransporationLines: Record "Gate Entry Line")
    begin
        IF TransporationLines.FINDLAST THEN
            LineNo := TransporationLines."Line No."
        ELSE
            LineNo := 0;
        DocNo := TransporationLines."No.";
    end;
}

#pragma implicitwith restore

