// codeunit 90252 "Order No Update"                   //One Time Use
// {
//     Permissions = tabledata "Sales Invoice Header" = RIMD;
//     procedure UpdateOrderNumbers()
//     var
//         SalesInvHeader: Record "Sales Invoice Header";
//         DocNoList: List of [Code[20]];
//         DocNo: Code[20];
//         UpdatedCount: Integer;
//         NotFoundCount: Integer;
//         NotFoundList: Text;
//         DocNoFilter: Text;
//         RecordCount: Integer;
//     begin
//         DocNoList.Add('5002417980');
//         DocNoList.Add('5002269590');
//         DocNoList.Add('5002205113');
//         DocNoList.Add('5000691132');
//         DocNoList.Add('5001426535');
//         DocNoList.Add('5001426533');
//         DocNoList.Add('5002007684');
//         DocNoList.Add('5001961016');
//         DocNoList.Add('5001581687');
//         DocNoList.Add('5001581683');
//         DocNoList.Add('5001580941');
//         DocNoList.Add('5001426531');
//         DocNoList.Add('5001408921');
//         DocNoList.Add('5001408889');
//         DocNoList.Add('5001200936');
//         DocNoList.Add('5001182738');
//         DocNoList.Add('5001170050');
//         DocNoList.Add('5000885504');
//         DocNoList.Add('5001095585');
//         DocNoList.Add('5000885515');
//         DocNoList.Add('5000885494');
//         DocNoList.Add('5000885483');
//         DocNoList.Add('5000516536');
//         DocNoList.Add('5000260991');
//         DocNoList.Add('5000111393');

//         foreach DocNo in DocNoList do begin
//             SalesInvHeader.Reset();
//             if SalesInvHeader.Get(DocNo) then begin
//                 SalesInvHeader."Order No." := '1111111111';
//                 SalesInvHeader.Modify(false);
//                 UpdatedCount += 1;
//             end;
//         end;
//         Message('Updated: %1 Records', UpdatedCount);
//     end;
// }