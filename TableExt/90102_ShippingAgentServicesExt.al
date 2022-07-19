tableextension 90252 ShippingAgentServicesExt extends "Shipping Agent Services"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Capacity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Measurent for Capacity"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Pallet,KG;
            OptionCaption = ' ,Pallet,KG';
        }
    }

    var
        myInt: Integer;
}