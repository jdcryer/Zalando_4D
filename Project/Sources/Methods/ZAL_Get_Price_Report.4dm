//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 19/02/21, 12:01:15
// ----------------------------------------------------
// Method: ZAL_Get_Price_Report
// Description
// 
//
// Parameters
// $0 - Object - API Response
// $1 - Object - Query params
// ----------------------------------------------------

C_OBJECT:C1216($0; $1)
C_TEXT:C284($vt_params; $vt_url)
C_OBJECT:C1216($vo_query)

$vt_url:="merchants/"+Storage:C1525.keys.merchantId+"/price-attempts"

If (Count parameters:C259>0)
	$vo_query:=OB Copy:C1225($1)
Else 
	$vo_query:=New object:C1471("page_size"; 500)
End if 

$0:=ZAL_Make_Request($vt_url; HTTP POST method:K71:2; $vt_params; $vo_query)
