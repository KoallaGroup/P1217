#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"

User Function TstIntegX()
  
	Local aHeader := {}
	
	Private lMsErroAuto := .F. 
	Private lMsHelpAuto := .T.

	//DbSelectArea("SB1")
	//DbGoTop()

	
	aAdd(aHeader, {"B1_COD", "TESTE 13", Nil})
	aAdd(aHeader, {"B1_DESC", "teste", Nil})
	aAdd(aHeader, {"B1_TIPO", "PA", Nil})
	aAdd(aHeader, {"B1_UM", "CC", Nil})
	aAdd(aHeader, {"B1_PESBRU", 4, Nil})
	aAdd(aHeader, {"B1_PESO", 3, Nil})
	aAdd(aHeader, {"B1_LOCPAD", "1", Nil})
	aAdd(aHeader, {"B1_FABRIC", "0", Nil})
	aAdd(aHeader, {"B1_TIPOCQ", "Q", Nil})
	aAdd(aHeader, {"B1_ESPECIF", "teste 1", Nil})
	aAdd(aHeader, {"B1_DESC_GI", "teste 2", Nil})
	aAdd(aHeader, {"B1_DESC_I", "teste 3", Nil})
	aAdd(aHeader, {"B1_CONV", 0, Nil})
	aAdd(aHeader, {"B1_TIPCONV", "M", Nil})
	aadd(aHeader, {"B1_PE", 12 , Nil })
	aAdd(aHeader, {"B1_IMPORT", "N", Nil})
	aAdd(aHeader, {"B1_QB", 0, Nil})
	aAdd(aHeader, {"B1_CONTRAT", "N", Nil})
	aAdd(aHeader, {"B1_NUMCQPR", 0, Nil})
	aAdd(aHeader, {"B1_QE", 0, Nil})
	aAdd(aHeader, {"B1_IPI", 0, Nil})
	aAdd(aHeader, {"B1_INSS", "N", Nil})
	aAdd(aHeader, {"B1_PIS", "2", Nil})
	aAdd(aHeader, {"B1_COFINS", "2", Nil})
	aAdd(aHeader, {"B1_CSLL", "2", Nil})
		
	ConOut("Cadastro de Produto")
	
	aHeader := FWVetByDic(aHeader, "SB1")
	
	nModulo := 2
	
	MSExecAuto({|x,y| Mata010(x,y)}, aHeader, 3)
	
	If lMsErroAuto   
		MostraErro()
	Else   
		ConOut("Cadastro de Produto -> Ok")
	Endif	 
   
Return "tst_ok"