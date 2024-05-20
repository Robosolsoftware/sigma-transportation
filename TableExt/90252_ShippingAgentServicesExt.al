tableextension 90252 ShippingAgentServicesExt extends "Shipping Agent Services"
{
    fields
    {
        // Add changes to table fields here
        field(90251; Capacity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90252; "Measurent for Capacity"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Pallet,KG;
            OptionCaption = ' ,Pallet,KG';
        }
    }

    var
        myInt: Integer;
}