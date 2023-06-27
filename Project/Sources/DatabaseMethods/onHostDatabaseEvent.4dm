C_LONGINT:C283($1)
If ($1=On before host database startup:K74:3)
	Use (Storage:C1525)
		Storage:C1525.keys:=New shared object:C1526
		Storage:C1525.auth:=New shared object:C1526
		Storage:C1525.const:=New shared object:C1526
		Use (Storage:C1525.const)
			Storage:C1525.const.prodURL:="https://api.merchants.zalando.com/"
			Storage:C1525.const.sandboxURL:="https://api-sandbox.merchants.zalando.com/"
			Storage:C1525.const.baseURL:="https://api-sandbox.merchants.zalando.com/"
		End use 
	End use 
End if 