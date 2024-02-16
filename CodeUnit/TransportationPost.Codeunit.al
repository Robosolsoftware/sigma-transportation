codeunit 90251 "Transportation - Post"
{
    TableNo = "Gate Entry Header";

    trigger OnRun()
    begin

        TransHeader := Rec;
        //rec.TESTFIELD(Status, Rec.Status::Released);
        ValidatePosting(TransHeader);
        IF NOT HideConfirmationDialog THEN
            IF NOT CONFIRM(STRSUBSTNO(Text16500, TransHeader."No."), FALSE) THEN
                EXIT;
        WhseSetup.GET;
        WhseSetup.TESTFIELD(WhseSetup."Posted Transportation Nos.");
        "Nos." := NoSeriesMgt.GetNextNo(WhseSetup."Posted Transportation Nos.", 0D, TRUE);
        PostedTransHeader.INIT;
        PostedTransHeader.TRANSFERFIELDS(TransHeader);
        PostedTransHeader."No." := "Nos.";
        PostedTransHeader."Transportation No." := TransHeader."No.";
        PostedTransHeader.INSERT(TRUE);

        TransLine.RESET;
        TransLine.SETRANGE("No.", TransHeader."No.");
        IF TransLine.FINDSET THEN
            REPEAT
                PostedTransLine.INIT;
                PostedTransLine.TRANSFERFIELDS(TransLine);
                PostedTransLine."No." := PostedTransHeader."No.";
                PostedTransLine.INSERT(TRUE);

                ParcelDetail.RESET;
                ParcelDetail.SETRANGE("Transportaion No.", TransLine."No.");
                ParcelDetail.SETRANGE("Transportaion Line No.", TransLine."Line No.");
                IF ParcelDetail.FINDSET THEN
                    REPEAT
                        PostedParcelDetail.INIT;
                        PostedParcelDetail.TRANSFERFIELDS(ParcelDetail);
                        PostedParcelDetail."Transportaion No." := PostedTransLine."No.";
                        PostedParcelDetail.INSERT(TRUE);
                    UNTIL ParcelDetail.NEXT = 0;
                //Chandan
                TransHeader.UpdateStatusOnPost(TransLine);
            UNTIL TransLine.NEXT = 0;

        ParcelDetail.RESET;
        ParcelDetail.SETRANGE("Transportaion No.", PostedTransHeader."Transportation No.");
        IF ParcelDetail.FINDSET THEN
            ParcelDetail.DELETEALL;

        TransLine.RESET;
        TransLine.SETRANGE("No.", PostedTransHeader."Transportation No.");
        IF TransLine.FINDSET THEN
            TransLine.DELETEALL;

        TransHeader.RESET;
        TransHeader.SETRANGE("No.", PostedTransHeader."Transportation No.");
        IF TransHeader.FINDSET THEN
            TransHeader.DELETEALL;
        Commit();
    end;

    var
        TransHeader: Record "Gate Entry Header";
        WhseSetup: Record 5769;
        "Nos.": Code[20];
        NoSeriesMgt: Codeunit 396;
        Text16500: Label 'Do you want to Post the Transportation No. %1  ?';
        PostedTransHeader: Record "Posted Gate Entry Header";
        TransLine: Record "Gate Entry Line";
        PostedTransLine: Record "Posted Gate Entry Line";
        ParcelDetail: Record "Parcel Details";
        PostedParcelDetail: Record "Posted Parcel Details";
        HideConfirmationDialog: Boolean;

    local procedure Post()
    begin
    end;

    // [Scope('Internal')]
    procedure SetConfirmDialog(P_HideConfirmationDialog: Boolean)
    begin
        HideConfirmationDialog := P_HideConfirmationDialog;
    end;

    local procedure ValidatePosting(RecGateEntryHeader: Record "Gate Entry Header")
    var
        GateEntryLine: Record "Gate Entry Line";
    begin
        GateEntryLine.RESET;
        GateEntryLine.SETRANGE("No.", RecGateEntryHeader."No.");
        IF GateEntryLine.FINDFIRST THEN
            REPEAT
                IF (GateEntryLine."Amount to Collect" <> 0) AND ((GateEntryLine."Amount Collected" = 0) OR (GateEntryLine."Amount Confirmed" = 0)) THEN
                    ERROR('Please Fill Amount Collected and Cornfirmed..');
            UNTIL GateEntryLine.NEXT = 0;
    end;

    local procedure PostOnafterPostSourceDocumeent(DocuementType: Option " ","Sales Order","Purchase Order","Transfer Order"; DocumentSubType: Integer; TrasnsportJobNo: Code[20])
    begin
        GetHeader(TrasnsportJobNo);
        CASE DocuementType OF
            DocuementType::"Purchase Order":
                IF CheckTrasnportJobCompleted(TransHeader) THEN
                    Post;
        END;
    end;

    local procedure CheckTrasnportJobCompleted(TransportHeader: Record "Gate Entry Header"): Boolean
    begin
        /*WITH TransportHeader DO BEGIN
          TransLine.SETRANGE("No.","No.");
          IF TransLine.FINDFIRST THEN BEGIN
            CASE TransLine."Entry Type" OF
          END;
        END;*/

    end;

    local procedure GetHeader(No: Code[20])
    begin
        IF TransHeader."No." = '' THEN
            TransHeader.GET(No);
    end;
}

