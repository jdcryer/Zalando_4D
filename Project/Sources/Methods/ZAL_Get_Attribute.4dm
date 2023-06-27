//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 04/12/20, 15:29:35
// ----------------------------------------------------
// Method: ZAL_Get_Attribute
// Description
// 
//
// Parameters
// $0 - Object  - API Response
// $2 - String  - Attribute name
// $2 - Boolean - True to Get Attribute List of options
// ----------------------------------------------------

C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

$vt_url:="merchants/"+Storage:C1525.keys.merchantId+"/attribute-types/"+$1

If (Count parameters:C259>1)
	If ($2)
		$vt_url:=$vt_url+"/attributes"
	End if 
End if 

$0:=ZAL_Make_Request($vt_url; HTTP GET method:K71:1)
