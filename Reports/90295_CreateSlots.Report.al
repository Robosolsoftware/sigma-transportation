report 90295 "Create Slots"
{
    // FORMAT(WORKDATE,0,'<Weekday Text>')
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    ProcessingOnly = true;

    dataset
    {
        dataitem("Slot Master"; "Slot Master")
        {
            CalcFields = Booked;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Location Code"; Location)
                {
                    TableRelation = Location.Code;
                    ApplicationArea = All;
                }
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF WORKDATE > StartDate THEN
                            ERROR('Start date cannot be less than current date');
                        IF (StartDate <> 0D) AND (EndDate <> 0D) THEN BEGIN

                            IF StartDate > EndDate THEN
                                ERROR('Start date cannot be greater than End date');
                        END;
                    end;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF WORKDATE > EndDate THEN
                            ERROR('Start date cannot be less than current date');
                        IF (StartDate <> 0D) AND (EndDate <> 0D) THEN BEGIN
                            IF StartDate > EndDate THEN
                                ERROR('End date must be greater than Start date');
                        END;
                    end;
                }
                field("Start Time"; StartTime)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (StartTime <> 0T) AND (EndTime <> 0T) THEN BEGIN
                            IF StartTime > EndTime THEN
                                ERROR('Start time cannot be greater than End time');
                        END;
                    end;
                }
                field("End Time"; EndTime)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (StartTime <> 0T) AND (EndTime <> 0T) THEN BEGIN
                            IF StartTime > EndTime THEN
                                ERROR('End time must be greater than Start time');
                        END;
                    end;
                }
                field("Lunch Start Time"; LunchStartTime)
                {
                    Caption = 'Lunch Start Time';
                    ApplicationArea = All;
                }
                field("Lunch End Time"; LunchEndTime)
                {
                    Caption = 'Lunch End Time';
                    ApplicationArea = All;
                }
                field("Include Saturday"; IncludeSaturday)
                {
                    Caption = 'Include Saturday';
                    ApplicationArea = All;
                }
                field("Include Sunday"; IncludeSunday)
                {
                    Caption = 'Include Sunday';
                    ApplicationArea = All;
                }
                field("Omit Lunch Hrs"; OmitLunchHrs)
                {
                    Caption = 'Omit Lunch Hrs';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            LunchEndTime := 140000T;
            LunchStartTime := 130000T;
            ManufacturingSetup.GET;
            StartTime := ManufacturingSetup."Normal Starting Time";
            EndTime := ManufacturingSetup."Normal Ending Time";
        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            IF CloseAction = ACTION::OK THEN
                Validation;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE('Slots created successfully')
    end;

    trigger OnPreReport()
    var
        NextDate: Date;
        NextStart: Time;
        NextEnd: Time;
        Checkday: Date;
        Flagreset: Boolean;
        i: Integer;
        Recslotmaster: Record "Slot Master";
        LStartTime: Time;
        LEndTime: Time;
    begin
        Recslotmaster.RESET;
        Recslotmaster.SETRANGE("Location Code", Location);
        Recslotmaster.SETRANGE(Date, StartDate, EndDate);
        Recslotmaster.SETRANGE("Start Time", StartTime, EndTime);
        Recslotmaster.SETRANGE("End Time", StartTime, EndTime);
        IF Recslotmaster.FINDSET THEN
            ERROR('Slots for given dates and time are already exist. Please slot list')
        ELSE BEGIN
            i := 1;
            NextDate := StartDate;
            NextStart := StartTime;
            NextEnd := 0T;
            //Chandan-----
            IF LunchStartTime = 0T THEN
                LStartTime := 130000T
            ELSE
                LStartTime := LunchStartTime;
            IF LunchEndTime = 0T THEN
                LEndTime := 140000T
            ELSE
                LEndTime := LunchEndTime;
            //Chandan-----
            REPEAT
                Checkday := NextDate;
                Flagreset := TRUE;
                //MESSAGE(FORMAT(Checkday)+FORMAT(CALCDATE('1D',Checkday),0,'<Weekday Text>'));
                //IF NOT ((FORMAT(CALCDATE('1D',Checkday),0,'<Weekday Text>')='Sunday') OR (FORMAT(CALCDATE('1D',Checkday),0,'<Weekday Text>')='Saturday')) THEN
                IF NOT (((DATE2DWY(Checkday, 1) = 6) AND NOT IncludeSaturday) OR ((DATE2DWY(Checkday, 1) = 7) AND NOT IncludeSunday)) THEN BEGIN
                    NextEnd := NextStart + 900000;
                    //Chandan-----
                    IF OmitLunchHrs THEN BEGIN
                        IF NOT ((NextStart >= LStartTime) AND (NextStart < LEndTime)) THEN
                            CreateSlot(NextDate, NextStart, NextEnd);
                    END ELSE
                        CreateSlot(NextDate, NextStart, NextEnd);
                    //Chandan-----
                    IF (NextStart + 900000) = EndTime THEN BEGIN
                        IF NextDate < EndDate THEN BEGIN
                            NextDate := CALCDATE('1D', NextDate);
                            NextStart := StartTime;
                            NextEnd := 0T;
                            Flagreset := FALSE;
                        END
                        ELSE BEGIN
                            i -= 1;
                            EXIT;
                        END;
                    END;
                    IF Flagreset AND ((NextStart + 900000) <> EndTime) THEN
                        NextStart := NextStart + 900000;
                END
                ELSE BEGIN
                    IF (DATE2DWY(Checkday, 1) = 6) AND (NOT IncludeSunday) THEN
                        NextDate := CALCDATE('2D', NextDate)
                    ELSE
                        IF (DATE2DWY(Checkday, 1) = 6) AND (IncludeSunday) THEN
                            NextDate := CALCDATE('1D', NextDate)
                        ELSE
                            IF DATE2DWY(Checkday, 1) = 7 THEN
                                NextDate := CALCDATE('1D', NextDate);
                    NextStart := StartTime;
                    NextEnd := 0T;
                    IF NextDate > EndDate THEN
                        i -= 1;
                END;
            UNTIL i = 0;

        END;
    end;

    var
        Location: Code[20];
        StartDate: Date;
        EndDate: Date;
        StartTime: Time;
        EndTime: Time;
        IncludeSaturday: Boolean;
        IncludeSunday: Boolean;
        LunchStartTime: Time;
        LunchEndTime: Time;
        OmitLunchHrs: Boolean;
        ManufacturingSetup: Record 99000765;

    local procedure Validation()
    begin
        IF Location = '' THEN
            ERROR('Please select location')
        ELSE
            IF (StartDate = 0D) OR (EndDate = 0D) THEN
                ERROR('Start/End Date should not be blank')
            ELSE
                IF (StartTime = 0T) OR (EndTime = 0T) THEN
                    ERROR('Start/End time should not be blank');
    end;

    local procedure CreateSlot(Nextdate: Date; NextStartTime: Time; NextEndTime: Time)
    var
        SlotMaster: Record "Slot Master";
    begin
        SlotMaster.RESET;
        SlotMaster.INIT;
        SlotMaster.VALIDATE("Location Code", Location);
        SlotMaster.VALIDATE(Date, Nextdate);
        SlotMaster.VALIDATE("Start Time", NextStartTime);
        SlotMaster.VALIDATE("End Time", NextEndTime);
        SlotMaster.INSERT;
    end;
}

