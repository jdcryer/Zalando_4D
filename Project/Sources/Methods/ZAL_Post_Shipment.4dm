//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 13/01/21, 14:41:50
// ----------------------------------------------------
// Method: ZAL_Post_Shipment
// Description
// 
//
// Parameters
// $0 - Object - API Response
// $1 - Object - Request body
// $2 - String - Shipment UUID
// $3 - String - ETag Value
// ----------------------------------------------------

C_OBJECT:C1216($0; $1)
C_TEXT:C284($2; $3)

C_TEXT:C284($vt_url)
C_COLLECTION:C1488($vc_headers)

$vt_url:="/zfs/shipping-notices/"+$2

$vc_headers:=New collection:C1472
$vc_headers.push(New object:C1471("name"; "Content-Type"; "value"; "application/json"))
$vc_headers.push(New object:C1471("name"; "If-Match"; "value"; $3))

$0:=ZAL_Make_Request($vt_url; HTTP POST method:K71:2; ""; $1; $vc_headers)
