If (Not:C34(Is compiled mode:C492))
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
	ZAL_SET_KEYS("3cccf2c4a75209a3238268426af23421"; "8777d8a4-1b78-4ec6-acc9-5d9a1e448aba"; "00393e49-f873-4b7c-a158-b02a056e1ed4")
End if 
