report 90255 "Batch Post Transportation"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Gate Entry Header"; "Gate Entry Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                CLEAR(TransportPost);
                TransportPost.SetConfirmDialog(TRUE);
                IF TransportPost.RUN("Gate Entry Header") THEN BEGIN
                    CounterOK := CounterOK + 1;
                    IF MARKEDONLY THEN
                        MARK(FALSE);
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                MESSAGE(Text002, CounterOK, CounterTotal);
            end;

            trigger OnPreDataItem()
            begin
                IF ReplacePostingDate AND (PostingDateReq = 0D) THEN
                    ERROR(Text000);

                CounterTotal := COUNT;
                Window.OPEN(Text001);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDate; PostingDateReq)
                    {
                        Caption = 'Posting Date';
                        ApplicationArea = All;
                    }
                    field(ReplacePostingDate; ReplacePostingDate)
                    {
                        Caption = 'Replace Posting Date';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Window: Dialog;
        ReplacePostingDate: Boolean;
        PostingDateReq: Date;
        CounterTotal: Integer;
        Counter: Integer;
        CounterOK: Integer;
        Text000: Label 'Enter the posting date.';
        Text001: Label 'Posting orders  #1########## @2@@@@@@@@@@@@@';
        Text002: Label '%1 Transportation out of a total of %2 have now been posted.';
        TransportPost: Codeunit "Transportation - Post";

    //[Scope('Internal')]
    procedure InitializeRequest(NewPostingDateReq: Date; NewReplacePostingDate: Boolean)
    begin
        PostingDateReq := NewPostingDateReq;
        ReplacePostingDate := NewReplacePostingDate;
    end;

    local procedure UpdateQtyToHandle()
    begin
    end;
}

