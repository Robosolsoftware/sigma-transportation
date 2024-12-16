tableextension 90256 WarehouseReceipHeaderExt extends "Warehouse Receipt Header"
{
    trigger OnDelete()
    var
        PostedGateEntryHeader: Record "Posted Gate Entry Header";
    begin
        if (rec."Transportation No." <> '') and (Rec."Receipt Status" <> 'Suspend') then begin
            PostedGateEntryHeader.Reset();
            PostedGateEntryHeader.SetRange("Transportation No.", Rec."Transportation No.");
            if not PostedGateEntryHeader.FindFirst() then begin
                Error('Cannot Delete the Record because either Transportation No. is not blank or Receipt Status is not set to Suspend');
            end;
        end;
    end;
}