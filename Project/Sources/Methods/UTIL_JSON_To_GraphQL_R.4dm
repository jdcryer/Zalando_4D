//%attributes = {}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 05/02/20, 10:48:00
// ----------------------------------------------------
// Method: UTIL
// Description
// Takes JSON object and returns GraphQL string
// Recursive function called by SHOPIFY_JSON_To_GraphQL
// Parameters
// $0 - String  - GraphQL string
// $1 - Object  - JSON Data to convert
// $2 - String  - Parent Property name
// $3 - Boolean - Include pagination details
// ----------------------------------------------------

C_TEXT:C284($0; $vt_res; $2; $vt_prop)
C_OBJECT:C1216($1; $vo_req)
C_BOOLEAN:C305($3; $vb_pagination)

C_LONGINT:C283($i)
C_TEXT:C284($vt_field)
C_OBJECT:C1216($vo_child)
C_BOOLEAN:C305($vb_edges)

ARRAY TEXT:C222($at_prop; 0)
ARRAY LONGINT:C221($al_type; 0)

$vo_req:=OB Copy:C1225($1)
$vt_prop:=$2
$vb_pagination:=$3

OB GET PROPERTY NAMES:C1232($vo_req; $at_prop; $al_type)

$vt_res:=$vt_prop

If (Find in array:C230($at_prop; "args")>0)
	ARRAY TEXT:C222($at_argProps; 0)
	ARRAY LONGINT:C221($al_argTypes; 0)
	OB GET PROPERTY NAMES:C1232($vo_req.args; $at_argProps; $al_argTypes)
	
	$vt_res:=$vt_res+"("
	
	For ($i; 1; Size of array:C274($at_argProps))
		$vb_edges:=($vb_edges | ($at_argProps{$i}="first") | ($at_argProps{$i}="last") | ($at_argProps{$i}="query")) & ($vt_prop#"bulkOperationRunQuery")
		$vt_res:=$vt_res+$at_argProps{$i}+": "
		
		Case of 
			: ($al_argTypes{$i}=Is real:K8:4) | ($al_argTypes{$i}=Is boolean:K8:9)
				$vt_res:=$vt_res+Lowercase:C14(String:C10($vo_req.args[$at_argProps{$i}]))
				
			: ($al_argTypes{$i}=Is text:K8:3)
				If ($vo_req.args[$at_argProps{$i}]="CONST:@")
					$vt_res:=$vt_res+Replace string:C233($vo_req.args[$at_argProps{$i}]; "CONST:"; "")
				Else 
					$vt_res:=$vt_res+"\""+Replace string:C233($vo_req.args[$at_argProps{$i}]; "\""; "\\\"")+"\""
				End if 
			: ($al_argTypes{$i}=Is collection:K8:32)
				$vt_res:=$vt_res+UTIL_JSON_To_GraphQL_COL($vo_req.args[$at_argProps{$i}])
				
			: ($al_argTypes{$i}=Is object:K8:27)
				$vt_res:=$vt_res+UTIL_JSON_To_GraphQL_OBJ($vo_req.args[$at_argProps{$i}])
				
		End case 
		If ($i<Size of array:C274($at_argProps))
			$vt_res:=$vt_res+", "
		End if 
	End for 
	
	$vt_res:=$vt_res+")"
End if 

$vt_res:=$vt_res+"{ "

If ($vb_edges)
	$vt_res:=$vt_res+"edges{ node {"
End if 


If (Find in array:C230($at_prop; "fields")>0)
	For each ($vt_field; $vo_req.fields)
		$vt_res:=$vt_res+$vt_field+" "
	End for each 
End if 


If (Find in array:C230($at_prop; "children")>0)
	For each ($vo_child; $vo_req.children)
		OB GET PROPERTY NAMES:C1232($vo_child; $at_childProps)
		If (Size of array:C274($at_childProps)>0)
			$vt_res:=$vt_res+UTIL_JSON_To_GraphQL_R($vo_child[$at_childProps{1}]; $at_childProps{1}; $vb_pagination)
		End if 
	End for each 
	
End if 

If ($vb_edges)
	If ($vb_pagination)
		$vt_res:=$vt_res+"}cursor}pageInfo{hasNextPage hasPreviousPage}"
	Else 
		$vt_res:=$vt_res+"}}"
	End if 
End if 
$vt_res:=$vt_res+"}"
$0:=$vt_res