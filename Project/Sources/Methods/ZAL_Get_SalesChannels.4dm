//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 07/12/20, 12:55:59
// ----------------------------------------------------
// Method: ZAL_Get_SalesChannels
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($0)
C_TEXT:C284($vt_url)
$vt_url:="sales-channels?merchant_ids="+Storage:C1525.keys.merchantId

$0:=ZAL_Make_Request($vt_url; HTTP GET method:K71:1)
