//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 20/06/23, 10:49:43
// ----------------------------------------------------
// Method: ZAL_Get_Announced_Item_Set
// Description
// 
//
// Parameters
// $0 - Object - API Response
// $1 - String - Shipment UUID
// $2 - String - Item Set UUID
// ----------------------------------------------------

#DECLARE($vt_shipmentUUID : Text; $vt_itemSetUUID : Text)->$vo_res : Object

var $vt_url : Text

$vt_url:="/zfs/shipping-notices/"+$vt_shipmentUUID+"/announced-item-sets/"+$vt_itemSetUUID

$vo_res:=ZAL_Make_Request($vt_url; HTTP GET method:K71:1)
