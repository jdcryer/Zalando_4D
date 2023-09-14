//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 14/09/23, 12:37:08
// ----------------------------------------------------
// Method: ZAL_Get_Logistic_Centers
// Description
// 
//
// Parameters
// ----------------------------------------------------

#DECLARE($vt_id : Text)->$vo_response

var $vt_url : Text

$vt_url:="merchants/"+Storage:C1525.keys.merchantId+"/logistic-centers"

If ($vt_id#"")
	$vt_url:=$vt_url+"/"+$vt_id
End if 

$vo_response:=ZAL_Make_Request($vt_url; HTTP GET method:K71:1)
