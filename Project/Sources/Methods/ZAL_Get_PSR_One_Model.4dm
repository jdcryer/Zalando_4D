//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 08/01/21, 11:27:34
// ----------------------------------------------------
// Method: ZAL_Get_PSR_One_Model
// Description
// Gets the Product Status Report for one product_model
// Used to determine the validation status of new products
// Parameters
// $0 - Object - API Response
// $1 - String - Product_Model code (Our Style)
// ----------------------------------------------------

C_OBJECT:C1216($0)
C_TEXT:C284($1)

C_OBJECT:C1216($vo_request)

$vo_request:=New object:C1471("psr"; New object:C1471("children"; New collection:C1472))

$vo_model:=New object:C1471("product_models"; New object:C1471("args"; New object:C1471("input"; New object:C1471); "fields"; New collection:C1472; "children"; New collection:C1472))
$vo_model.product_models.args.input.merchant_ids:=New collection:C1472(Storage:C1525.keys.merchantId)
$vo_model.product_models.args.input.season_codes:=New collection:C1472()
$vo_model.product_models.args.input.brand_codes:=New collection:C1472()
$vo_model.product_models.args.input.country_codes:=New collection:C1472()

$vo_model.product_models.args.input.search_value:=$1
$vo_model.product_models.args.input.limit:=10

$vo_shortDesc:=New object:C1471("short_description"; New object:C1471("fields"; New collection:C1472("en")))
$vo_desc:=New object:C1471("description"; New object:C1471("fields"; New collection:C1472("en")))
$vo_offerStatus:=New object:C1471("offer_status"; New object:C1471("fields"; New collection:C1472("status_detail_code"; "status_cluster"); "children"; New collection:C1472($vo_shortDesc)))
$vo_offers:=New object:C1471("offers"; New object:C1471("children"; New collection:C1472($vo_offerStatus)))
$vo_status:=New object:C1471("status"; New object:C1471("fields"; New collection:C1472("status_detail_code"; "status_cluster"); "children"; New collection:C1472($vo_desc; $vo_shortDesc)))
$vo_simple:=New object:C1471("product_simples"; New object:C1471("fields"; New collection:C1472("ean"; "merchant_product_simple_id"); "children"; New collection:C1472($vo_status)))
$vo_config:=New object:C1471("product_configs"; New object:C1471("fields"; New collection:C1472("merchant_product_config_id"); "children"; New collection:C1472($vo_simple)))
$vo_model.product_models.children.push(New object:C1471("items"; New object:C1471("children"; New collection:C1472($vo_config))))
$vo_request.psr.children.push($vo_model)

$0:=ZAL_Make_GraphQL_Request($vo_request)
