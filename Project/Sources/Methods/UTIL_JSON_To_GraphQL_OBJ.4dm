//%attributes = {}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 06/02/20, 13:20:07
// ----------------------------------------------------
// Method: UTIL_JSON_To_GraphQL_OBJ
// Description
// Parses given object into GraphQL string
//
// Parameters
// $0 - String - GraphQL String
// $1 - Object - Data to parse
// ----------------------------------------------------

C_TEXT:C284($0; $vt_res)
C_OBJECT:C1216($1; $vo_req)
C_LONGINT:C283($i)

ARRAY TEXT:C222($at_prop; 0)
ARRAY LONGINT:C221($al_type; 0)

$vo_req:=$1

OB GET PROPERTY NAMES:C1232($vo_req; $at_prop; $al_type)

$vt_res:="{ "

For ($i; 1; Size of array:C274($at_prop))
	If ($i>1)
		$vt_res:=$vt_res+", "
	End if 
	
	$vt_res:=$vt_res+$at_prop{$i}+": "
	
	Case of 
		: ($al_type{$i}=Is text:K8:3)
			If ($vo_req[$at_prop{$i}]="CONST:@")
				$vt_res:=$vt_res+Replace string:C233($vo_req[$at_prop{$i}]; "CONST:"; "")
			Else 
				$vt_res:=$vt_res+"\""+Replace string:C233($vo_req[$at_prop{$i}]; "\""; "\\\"")+"\""
			End if 
		: ($al_type{$i}=Is real:K8:4) | ($al_type{$i}=Is boolean:K8:9)
			$vt_res:=$vt_res+Lowercase:C14(String:C10($vo_req[$at_prop{$i}]))
			
		: ($al_type{$i}=Is collection:K8:32)
			$vt_res:=$vt_res+UTIL_JSON_To_GraphQL_COL($vo_req[$at_prop{$i}])
			
		: ($al_type{$i}=Is object:K8:27)
			$vt_res:=$vt_res+UTIL_JSON_To_GraphQL_OBJ($vo_req[$at_prop{$i}])
			
	End case 
End for 

$vt_res:=$vt_res+" }"

$0:=$vt_res