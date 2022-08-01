pageextension 90252 "SalesOrderExt" extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here

        //Pranali08012022_US7084++
        addfirst(Export)
        {
            field("Loading Date"; Rec."Loading Date")
            {
                ApplicationArea = all;
            }
        }
        //Pranali08012022_US7084--
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}