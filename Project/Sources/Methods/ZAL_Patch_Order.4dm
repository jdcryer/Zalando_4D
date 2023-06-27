//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 10/12/20, 10:07:14
// ----------------------------------------------------
// Method: ZAL_Patch_Order
// Description
// Updates given Order with the given body
//
// Parameters
// $0 - Object - API Response
// $1 - String - Order ID
// $2 - Object - Request body
// ----------------------------------------------------

C_OBJECT:C1216($0; $2)
C_TEXT:C284($1)

C_TEXT:C284($vt_url)
C_COLLECTION:C1488($vc_headers)

$vt_url:="merchants/"+Storage:C1525.keys.merchantId+"/orders/"+$1
$vc_headers:=New collection:C1472(New object:C1471("name"; "Content-Type"; "value"; "application/vnd.api+json"))

$0:=ZAL_Make_Request($vt_url; "PATCH"; ""; $2; $vc_headers)
