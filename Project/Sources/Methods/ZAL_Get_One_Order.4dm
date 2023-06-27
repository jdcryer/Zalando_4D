//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 07/12/20, 14:07:50
// ----------------------------------------------------
// Method: ZAL_Get_One_Order
// Description
// 
//
// Parameters
// $0 - Object     - API Response
// $1 - String     - Order ID
// $2 - Collection - Coll of { 'param': '', 'value': '' } containing query params to use in this request
// ----------------------------------------------------

C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_COLLECTION:C1488($2; $vc_params)

C_OBJECT:C1216($vo_param)
C_BOOLEAN:C305($vb_first)
C_TEXT:C284($vt_url; $vt_params)

$vt_url:="merchants/"+Storage:C1525.keys.merchantId+"/orders/"+$1

$vc_params:=New collection:C1472
If (Count parameters:C259>0)
	$vc_params:=$2
End if 

For each ($vo_param; $vc_params)
	If ($vb_first)
		$vt_params:=$vo_param.param+"="+String:C10($vo_param.value)
	Else 
		$vt_params:=$vt_params+"&"+$vo_param.param+"="+String:C10($vo_param.value)
	End if 
	$vb_first:=False:C215
End for each 

$0:=ZAL_Make_Request($vt_url; HTTP GET method:K71:1; $vt_params)
