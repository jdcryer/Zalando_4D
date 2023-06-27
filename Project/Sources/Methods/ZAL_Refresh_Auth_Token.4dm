//%attributes = {}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 04/12/20, 12:29:49
// ----------------------------------------------------
// Method: ZAL_Refresh_Auth_Token
// Description
// Checks auth expiry, gets new access token as required
//
// Parameters
// $0 - Object - Either { success: true } or { success: false, error: something ... }
// ----------------------------------------------------

C_OBJECT:C1216($0; $vo_response; $vo_res)
C_TEXT:C284($vt_auth; $vt_base64; $vt_filepath; $vt_json; $vt_refreshToken; \
$vt_request; $vt_response; $vt_timestamp; $vt_url)
C_BLOB:C604($vx_blob)
C_BOOLEAN:C305($vb_getNew)
C_LONGINT:C283(vl_httpError)
C_TEXT:C284(vt_httpError)
C_TIME:C306($vh_expiaryTime; $vh_tempTime)

vl_httpError:=0
vt_httpError:=""

ARRAY TEXT:C222($at_headName; 0)
ARRAY TEXT:C222($at_headVal; 0)

$vo_response:=New object:C1471
$vb_getNew:=True:C214

If (OB Is defined:C1231(Storage:C1525.auth; "expiry"))
	$vb_getNew:=(Storage:C1525.auth.expiry<String:C10(Current date:C33; ISO date:K1:8; Current time:C178))
End if 

If ($vb_getNew)
	$vt_auth:=Storage:C1525.keys.clientId+":"+Storage:C1525.keys.clientSecret
	TEXT TO BLOB:C554($vt_auth; $vx_blob; UTF8 text without length:K22:17)
	BASE64 ENCODE:C895($vx_blob; $vt_base64)
	//4D's implementation of Base64 Encode"chunks"the result which
	//will corrupt our request. We need to "de-chunk" it by removing CR's and LF's
	$vt_base64:=Replace string:C233($vt_base64; Char:C90(13); "")
	$vt_base64:=Replace string:C233($vt_base64; Char:C90(10); "")
	
	APPEND TO ARRAY:C911($at_headName; "authorization")
	APPEND TO ARRAY:C911($at_headVal; "Basic "+$vt_base64)
	
	APPEND TO ARRAY:C911($at_headName; "Content-Type")
	APPEND TO ARRAY:C911($at_headVal; "application/x-www-form-urlencoded")
	
	$vt_request:="grant_type=client_credentials&scope=access_token_only"
	
	$vt_url:=Storage:C1525.keys.baseUrl+"auth/token"
	
	ON ERR CALL:C155("HTTP_Error")
	$vl_status:=HTTP Request:C1158(HTTP POST method:K71:2; $vt_url; $vt_request; $vt_response; $at_headName; $at_headVal)
	ON ERR CALL:C155("")
	
	If ($vl_status=200)
		$vo_res:=JSON Parse:C1218($vt_response)
		$vd_date:=Current date:C33(*)
		$vh_tempTime:=Current time:C178(*)
		
		$vh_expiaryTime:=Time:C179($vh_tempTime+$vo_res.expires_in)
		If ($vh_expiaryTime>?24:00:00?)
			$vh_expiaryTime:=$vh_expiaryTime-?24:00:00?
			$vd_date:=Add to date:C393($vd_date; 0; 0; 1)
		End if 
		
		$vt_timestamp:=String:C10($vd_date; ISO date:K1:8; $vh_expiaryTime)
		
		Use (Storage:C1525.auth)
			Storage:C1525.auth.accessToken:=$vo_res.access_token
			Storage:C1525.auth.expiry:=$vt_timestamp
		End use 
		
		$vo_response.success:=True:C214
		
	Else 
		If (vl_httpError#0)
			$vo_response.success:=False:C215
			$vo_response.error:=New object:C1471("errorCode"; vl_httpError; "errorMessage"; vt_httpError)
		Else 
			$vo_response.success:=False:C215
			$vo_response.error:=JSON Parse:C1218($vt_response)
		End if 
	End if 
Else 
	$vo_response.success:=True:C214
End if 

$0:=$vo_response