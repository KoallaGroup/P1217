#include 'protheus.ch'
#include 'parmtype.ch'

user function tstPCORETSLD()

//programa para retornar os saldos do exemplo descrito
Local aSaldoCubo
Local dDataLocal 
nX
Local cChave     := "1000        345      PR"
Local cCodCubo   := "01"
dData := CtoD("31/01/08")

aSaldoCubo := PcoRetSld(cCodCubo, cChave, dData)

Conout("Saldo Cubo em 31/01/08 - Crédito Moeda 1 ===> "+Transform(aSaldoCubo[1,1], "@E 999,999,999.99"))//Saldo Cubo em 31/01/08 - Crédito Moeda 1 ===> 200,00

Conout("Saldo Cubo em 31/01/08 - Débito Moeda 1 ===>  "+Transform(aSaldoCubo[2,1], "@E 999,999,999.99"))//Saldo Cubo em 31/01/08 - Débito Moeda 1 ===>  0,00 
	
return aSaldoCubo