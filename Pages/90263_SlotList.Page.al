page 90263 "Slot List"
{
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Slot Master";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Slot No."; Rec."Entry No")
                {
                    Caption = 'Slot No.';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = Flagavailable;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Style = Unfavorable;
                    StyleExpr = Flagavailable;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Style = Unfavorable;
                    StyleExpr = Flagavailable;
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    Style = Unfavorable;
                    StyleExpr = Flagavailable;
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    Style = Unfavorable;
                    StyleExpr = Flagavailable;
                    ApplicationArea = All;
                }
                field(Booked; Rec.Booked)
                {
                    Style = Unfavorable;
                    StyleExpr = Flagavailable;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Flagavailable := FALSE;
        Rec.CALCFIELDS(Booked);
        IF Rec.Booked THEN
            Flagavailable := TRUE;
    end;

    trigger OnOpenPage()
    begin
        Flagavailable := FALSE;
        Rec.CALCFIELDS(Booked);
        IF Rec.Booked THEN
            Flagavailable := TRUE;
    end;

    var
        Flagavailable: Boolean;
        hideflag: Boolean;

    //[Scope('Internal')]
    procedure Hidefields(Flagtohide: Boolean)
    begin
        hideflag := Flagtohide;
    end;
}

