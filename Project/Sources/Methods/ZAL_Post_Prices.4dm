//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 07/12/20, 15:08:48
// ----------------------------------------------------
// Method: ZAL_Post_Prices
// Description
// 
//
// Parameters
// $0 - Object     - API Response
// $1 - Collection - Prices Collection
// ----------------------------------------------------

C_OBJECT:C1216($0)
C_COLLECTION:C1488($1)

C_OBJECT:C1216($vo_request)
C_TEXT:C284($vt_url)

$vo_request:=New object:C1471("product_prices"; $1)

$vt_url:="merchants/"+Storage:C1525.keys.merchantId+"/prices"

$0:=ZAL_Make_Request($vt_url; HTTP POST method:K71:2; ""; $vo_request)
