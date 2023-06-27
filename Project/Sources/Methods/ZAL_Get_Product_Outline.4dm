//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 04/12/20, 14:49:56
// ----------------------------------------------------
// Method: ZAL_Get_Product_Outline
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($0)
C_TEXT:C284($1; $vt_url)

$vt_url:="merchants/"+Storage:C1525.keys.merchantId+"/outlines"
If (Count parameters:C259>0)
	$vt_url:=$vt_url+"/"+$1+"/"
End if 

$0:=ZAL_Make_Request($vt_url; HTTP GET method:K71:1)
