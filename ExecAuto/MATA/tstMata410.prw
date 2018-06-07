#include 'protheus.ch'
#include 'parmtype.ch'

user function tstMata410()

Local cNumPedido := "000002"


U_MATA410alt(cNumPedido)

startjob("U_MATA410exc(cNumPedido)",getenvserver(),.T.,)


	
return