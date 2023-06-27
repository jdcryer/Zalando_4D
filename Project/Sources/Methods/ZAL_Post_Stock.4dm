//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 07/12/20, 14:55:59
// ----------------------------------------------------
// Method: ZAL_Post_Stock
// Description
// 
//
// Parameters
// $0 - Object  - API Response
// $1 - String  - EAN
// $2 - String  - Product ID
// $3 - String  - Sales Channel ID
// $4 - Longint - Quantity
// ----------------------------------------------------


C_OBJECT:C1216($0)
C_COLLECTION:C1488($1)

C_OBJECT:C1216($vo_request)
C_TEXT:C284($vt_url)

$vt_url:="merchants/"+Storage:C1525.keys.merchantId+"/stocks"

$vo_request:=New object:C1471
$vo_request.items:=$1

$0:=ZAL_Make_Request($vt_url; HTTP POST method:K71:2; ""; $vo_request)
