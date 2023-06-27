//%attributes = {}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 15/12/20, 16:43:59
// ----------------------------------------------------
// Method: ZAL_Make_GraphQL_Request
// Description
// 
//
// Parameters
// $0 - Object - API Response
// $1 - Object - Request to be converted
// ----------------------------------------------------

C_OBJECT:C1216($0; $1)

C_OBJECT:C1216($vo_res; $vo_response; $vo_restest; $vo_request)
C_TEXT:C284($vt_request; $vt_url; $vt_response; $vt_params)
C_LONGINT:C283($vl_status)
C_LONGINT:C283(vl_httpError; vl_jsonError)
C_TEXT:C284(vt_httpError; vt_jsonError)
C_BLOB:C604($vx_test)

ARRAY TEXT:C222($at_headName; 0)
ARRAY TEXT:C222($at_headVal; 0)

$vo_res:=ZAL_Refresh_Auth_Token
$vo_response:=New object:C1471

vl_httpError:=0
vt_httpError:=""
vl_jsonError:=0
vt_jsonError:=""

If ($vo_res.success)
	
	$vt_url:=Storage:C1525.keys.baseUrl+"graphql"
	
	APPEND TO ARRAY:C911($at_headName; "Authorization")
	APPEND TO ARRAY:C911($at_headVal; "Bearer "+Storage:C1525.auth.accessToken)
	
	APPEND TO ARRAY:C911($at_headName; "Content-Type")
	APPEND TO ARRAY:C911($at_headVal; "application/json")
	
	$vt_request:=UTIL_JSON_To_GraphQL("psr"; $1; False:C215)
	$vo_request:=New object:C1471("query"; $vt_request)
	
	ON ERR CALL:C155("HTTP_Error")
	//  //Tom - Reasoning for recieving response in Blob:
	//  //    - GET Orders API with '$vt_response' resulting in 'Incompatible arguement types' error on HTTP Request
	//  //      But, putting into blob then convert to text / JSON Parse works without issue...
	
	//$vl_status:=HTTP Request(HTTP POST method;$vt_url;$vt_request;$vt_response;$at_headName;$at_headVal)
	$vl_status:=HTTP Request:C1158(HTTP POST method:K71:2; $vt_url; $vo_request; $vx_test; $at_headName; $at_headVal)
	$vt_response:=BLOB to text:C555($vx_test; UTF8 text without length:K22:17)
	
	ON ERR CALL:C155("")
	
	$vo_response.url:=$vt_url
	If (vl_httpError#0)
		$vo_response.status:=0
		$vo_response.response:=New object:C1471("errorCode"; vl_httpError; "errorMessage"; vt_httpError)
	Else 
		$vo_response.status:=$vl_status
		If ($vt_response#"")
			ON ERR CALL:C155("JSON_Error")
			$vo_response.response:=JSON Parse:C1218($vt_response)
			ON ERR CALL:C155("")
			
			If (vl_jsonError#0)  //Error occured when parsing JSON
				$vo_response.jsonError:=vt_jsonError
				$vo_response.response:=$vt_response
			End if 
		Else 
			$vo_response.response:=New object:C1471
		End if 
	End if 
	
	If (Count parameters:C259>3)
		$vo_response.request:=$vt_request
	End if 
	
Else 
	//Error obtaining Auth token!
	$vo_response:=OB Copy:C1225($vo_res)
	$vo_response.status:=0
End if 

$0:=$vo_response
