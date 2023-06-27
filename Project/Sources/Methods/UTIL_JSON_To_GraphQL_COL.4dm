//%attributes = {}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 06/02/20, 13:39:26
// ----------------------------------------------------
// Method: UTIL_JSON_To_GraphQL_COL
// Description
// Parses given collection into GraphQL String
//
// Parameters
// $0 - String     - GraphQL String
// $1 - Collection - Data to parse
// ----------------------------------------------------

C_TEXT:C284($0; $vt_res)
C_COLLECTION:C1488($1; $vc_req)
C_LONGINT:C283($i; $vl_type)

$vc_req:=$1
$vt_res:="[ "

For ($i; 0; $vc_req.length-1)
	If ($i>0)
		$vt_res:=$vt_res+", "
	End if 
	
	$vl_type:=Value type:C1509($vc_req[$i])
	Case of 
		: ($vl_type=Is real:K8:4) | ($vl_type=Is longint:K8:6) | ($vl_type=Is boolean:K8:9)
			$vt_res:=$vt_res+Lowercase:C14(String:C10($vc_req[$i]))
			
		: ($vl_type=Is object:K8:27)
			$vt_res:=$vt_res+UTIL_JSON_To_GraphQL_OBJ($vc_req[$i])
			
		: ($vl_type=Is collection:K8:32)
			$vt_res:=$vt_res+UTIL_JSON_To_GraphQL_COL($vc_req[$i])
			
		: ($vl_type=Is text:K8:3)
			If ($vc_req[$i]="CONST:@")
				$vt_res:=$vt_res+Replace string:C233($vc_req[$i]; "CONST:"; "")
			Else 
				$vt_res:=$vt_res+"\""+Replace string:C233($vc_req[$i]; "\""; "\\\"")+"\""
			End if 
		Else 
			$vt_res:=$vt_res+"\""+String:C10($vc_req[$i])+"\""
			
	End case 
End for 

$vt_res:=$vt_res+" ]"

$0:=$vt_res