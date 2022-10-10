pageextension 90253 WareSetupExt_Transport extends "Warehouse Setup"
{
    layout
    {
        addafter(Numbering)
        {
            group("Transportation")
            {
                field("Transportation Nos."; Rec."Transportation Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Transportation Nos."; Rec."Posted Transportation Nos.")
                {
                    ApplicationArea = All;
                }
                field("Default Location for Transport"; Rec."Default Location for Transport")
                {
                    ApplicationArea = All;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Not used in code. Need to discuss about this option';
                }
            }
        }
    }
}
