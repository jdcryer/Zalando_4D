//%attributes = {}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 05/02/20, 10:38:49
// ----------------------------------------------------
// Method: UTIL_JSON_To_GraphQL
// Description
// Takes JSON object and returns GraphQL string
//
// Parameters
// $0 - String  - GraphQL string
// $1 - String  - Type of request, 'query' or 'mutation'
// $2 - Object  - JSON Data to convert
// $3 - Booelan - Include pagination details
// ----------------------------------------------------

C_TEXT:C284($0; $vt_res; $1; $vt_action)
C_OBJECT:C1216($2; $vo_req)
C_BOOLEAN:C305($3; $vb_pagination)
C_LONGINT:C283($i)

ARRAY TEXT:C222($at_prop; 0)

$vt_action:=$1
$vo_req:=$2
$vb_pagination:=$3
$vt_res:="{ "
//$vt_res:="{ "+$vt_action+" {"

OB GET PROPERTY NAMES:C1232($vo_req; $at_prop)
For ($i; 1; Size of array:C274($at_prop))
	
	$vt_res:=$vt_res+UTIL_JSON_To_GraphQL_R($vo_req[$at_prop{$i}]; $at_prop{$i}; $vb_pagination)
	
End for 

//$vt_res:=$vt_res+"}}"
$vt_res:=$vt_res+"}"

$0:=$vt_res