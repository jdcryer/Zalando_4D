//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 04/12/20, 12:24:53
// ----------------------------------------------------
// Method: ZAL_SET_KEYS
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $2; $3)

Use (Storage:C1525.keys)
	Storage:C1525.keys.clientId:=$1
	Storage:C1525.keys.clientSecret:=$2
	Storage:C1525.keys.merchantId:=$3
	Storage:C1525.keys.baseUrl:=$4
End use 
