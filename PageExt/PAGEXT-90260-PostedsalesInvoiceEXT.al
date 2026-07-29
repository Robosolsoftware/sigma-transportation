// pageextension 90260 "Posted Sales Invoice Ext" extends "Posted Sales Invoices"       //One Time Use
// {

//     actions
//     {
//         addlast(Processing)
//         {
//             action(OneTimeOrderNoFix)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Update Order No.';
//                 Image = FixedAssetLog;
//                 ToolTip = 'Update Order No. on specific posted sales invoices.';


//                 trigger OnAction()
//                 var
//                     Updater: Codeunit "Order No Update";
//                 begin
//                     if Confirm('This will update Order No. on 25 specific posted invoices to 1111111111. Continue?') then
//                         Updater.UpdateOrderNumbers();
//                 end;

//             }
//         }
//     }
// }