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
// $1 - String - Shipment UUID
// ----------------------------------------------------

C_OBJECT:C1216($0)
C_TEXT:C284($1)

C_TEXT:C284($vt_url)

$vt_url:="/zfs/shipping-notices/"+$1

$0:=ZAL_Make_Request($vt_url; HTTP GET method:K71:1)
