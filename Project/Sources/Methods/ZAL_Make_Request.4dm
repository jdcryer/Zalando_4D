//%attributes = {}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 04/12/20, 14:56:55
// ----------------------------------------------------
// Method: ZAL_Make_Request
// Description
// 
//
// Parameters
// $0 - Object     - API Response
// $1 - String     - Endpoint
// $2 - String     - Request type
// $3 - String     - Query params (optional)
// $4 - Object     - Request Body (optional)
// $5 - Collection - Additional Headers (optional) [ { "name": "", "value": "" } ] 
// ----------------------------------------------------

C_OBJECT:C1216($0)
C_TEXT:C284($1; $2; $3)
C_OBJECT:C1216($4)
C_COLLECTION:C1488($5)

C_OBJECT:C1216($vo_res; $vo_response; $vo_restest; $vo_request; $vo_header)
C_TEXT:C284($vt_request; $vt_url; $vt_response; $vt_params)
C_LONGINT:C283($vl_status)
C_LONGINT:C283(vl_httpError; vl_jsonError)
C_TEXT:C284(vt_httpError; vt_jsonError)
C_BLOB:C604($vx_test)
C_COLLECTION:C1488($vc_responseHeaders)

ARRAY TEXT:C222($at_headName; 0)
ARRAY TEXT:C222($at_headVal; 0)

$vo_res:=ZAL_Refresh_Auth_Token
$vo_response:=New object:C1471
$vc_responseHeaders:=New collection:C1472

vl_httpError:=0
vt_httpError:=""
vl_jsonError:=0
vt_jsonError:=""

If ($vo_res.success)
	If (Count parameters:C259>2)
		$vt_params:=$3
	End if 
	
	$vt_url:=Storage:C1525.keys.baseUrl+$1
	If ($vt_params#"")
		$vt_url:=$vt_url+"?"+$vt_params
	End if 
	APPEND TO ARRAY:C911($at_headName; "Authorization")
	APPEND TO ARRAY:C911($at_headVal; "Bearer "+Storage:C1525.auth.accessToken)
	
	If (Count parameters:C259>4)
		For each ($vo_header; $5)
			APPEND TO ARRAY:C911($at_headName; $vo_header.name)
			APPEND TO ARRAY:C911($at_headVal; $vo_header.value)
		End for each 
	End if 
	
	//APPEND TO ARRAY($at_headName;"Accept")
	//APPEND TO ARRAY($at_headVal;"application/vnd.api+json")
	
	ON ERR CALL:C155("HTTP_Error")
	If (Count parameters:C259>3)
		$vl_status:=HTTP Request:C1158($2; $vt_url; $4; $vx_test; $at_headName; $at_headVal)
		$vt_response:=BLOB to text:C555($vx_test; UTF8 text without length:K22:17)
	Else 
		//Tom - Reasoning for recieving response in Blob:
		//    - GET Orders API with '$vt_response' resulting in 'Incompatible arguement types' error on HTTP Request
		//      But, putting into blob then convert to text / JSON Parse works without issue...
		$vl_status:=HTTP Request:C1158($2; $vt_url; $vt_request; $vx_test; $at_headName; $at_headVal)
		$vt_response:=BLOB to text:C555($vx_test; UTF8 text without length:K22:17)
	End if 
	ON ERR CALL:C155("")
	
	ARRAY TO COLLECTION:C1563($vc_responseHeaders; $at_headName; "name"; $at_headVal; "value")
	
	$vo_response.url:=$vt_url
	$vo_response.responseHeaders:=$vc_responseHeaders
	If (vl_httpError#0)
		$vo_response.status:=0
		$vo_response.response:=New object:C1471("errorCode"; vl_httpError; "errorMessage"; vt_httpError)
		
		//Despite the error, attempt to extract data from blob
		ON ERR CALL:C155("HTTP_Error")
		$vt_response:=BLOB to text:C555($vx_test; UTF8 text without length:K22:17)
		$vo_response.httpResponse:=$vt_response
		ON ERR CALL:C155("")
		
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
		$vo_response.request:=$4
	End if 
	
Else 
	//Error obtaining Auth token!
	$vo_response:=OB Copy:C1225($vo_res)
	$vo_response.status:=0
End if 

$0:=$vo_response
