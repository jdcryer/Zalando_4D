//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 04/12/20, 15:15:26
// ----------------------------------------------------
// Method: ZAL_Get_Me
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($0)

$vt_url:="auth/me"

$0:=ZAL_Make_Request($vt_url; HTTP GET method:K71:1)
