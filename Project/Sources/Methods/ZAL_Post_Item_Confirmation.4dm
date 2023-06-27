//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 14/01/21, 17:03:20
// ----------------------------------------------------
// Method: ZAL_Post_Item_Confirmation
// Description
// 
//
// Parameters
// $0 - Object - API Response
// $1 - String - Shipping Notice UUID
// $2 - String - ETag
// ----------------------------------------------------

C_OBJECT:C1216($0)
C_TEXT:C284($1; $2)

C_TEXT:C284($vt_url)
C_COLLECTION:C1488($vc_headers)

$vt_url:="zfs/shipping-notices/"+$1+"/announcement-confirmations"

$vc_headers:=New collection:C1472
$vc_headers.push(New object:C1471("name"; "If-Match"; "value"; $2))

$0:=ZAL_Make_Request($vt_url; HTTP POST method:K71:2; ""; New object:C1471; $vc_headers)
