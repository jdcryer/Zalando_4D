//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 18/01/21, 11:30:56
// ----------------------------------------------------
// Method: ZAL_Get_Tour
// Description
// 
//
// Parameters
// $0 - Object - API Response
// $1 - String - Zalando Shipment Advice ID
// ----------------------------------------------------

C_OBJECT:C1216($0)
C_TEXT:C284($1)

C_TEXT:C284($vt_url; $vt_param)

$vt_url:="/zfs/tours"

If (Count parameters:C259>0)
	$vt_param:="zalando_advice_id="+$1
End if 

$0:=ZAL_Make_Request($vt_url; HTTP GET method:K71:1; $vt_param)
