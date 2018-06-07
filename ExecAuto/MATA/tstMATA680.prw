#include 'protheus.ch'
#include 'parmtype.ch'

user function tstMATA680()

Local aMAta680 :={}
Local nOpc := 3 //inclusão
PRIVATE lMsErroAuto := .F.

aadd(aMata680,{"H6_OP", "00001101001" ,NIL})
aadd(aMata680,{"H6_PRODUTO", "2              " ,NIL})
aadd(aMata680,{"H6_DTAPONT", dDatabase ,NIL})
aadd(aMata680,{"H6_DATAINI", dDatabase ,NIL})
aadd(aMata680,{"H6_DATAFIN", dDatabase ,NIL})
aadd(aMata680,{"H6_LOCAL", dDatabase ,NIL})


MsExecAuto({|x,y|MATA680(x,y)},aMata680,nOpc)

	IF lMsErroAuto   
		Mostraerro() 
		Alert("Nao foi possivel efetuar o apontamento!")
		lMsErroAuto := .F.
	ELSE    
		Alert("Apontado!!!")
	ENDIF

Return Nil
	
