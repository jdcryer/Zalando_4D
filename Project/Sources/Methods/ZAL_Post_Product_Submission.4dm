//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 15/12/20, 12:35:23
// ----------------------------------------------------
// Method: ZAL_Post_Product_Submission
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($0; $1)

C_TEXT:C284($vt_url)

$vt_url:="merchants/"+Storage:C1525.keys.merchantId+"/product-submissions"

$0:=ZAL_Make_Request($vt_url; HTTP POST method:K71:2; ""; $1)
