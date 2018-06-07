#Include 'Protheus.ch'
#Include 'Protheus.ch'
#include "tbiconn.ch"

User Function MATA250() 

Local aVetor        

Local dData

Local nOpc   := 3 //-Opção de execução da rotina, informado nos parametros quais as opções possiveis
      
prepare environment empresa "99" filial "01" modulo "est"

conout("Mata250 - TESTE 01")

lMsErroAuto := .F. 

aVetor := {}

dData:=dDataBase

aVetor := {  {"D3_OP"		,"OP002801001   "  	,NIL},;
			 {"D3_COD"		,"P00000000000001"  	,NIL},;
			 {"D3_QUANT"		,30  	,NIL},;
			 {"D3_PARCTOT"	, "P"					,NIL},;
			 {"D3_TM"		,"01 "				,NIL}}
			                                               	
							
							
MSExecAuto({|x, y| mata250(x, y)},aVetor, nOpc )  

If lMsErroAuto
	CONOUT("Erro")
	mostraerro()
Else
	//CONOUT("Incluido com sucesso")
	CONOUT("Incluido com sucesso")
Endif

conout("Mata250 - TESTE 02")

lMsErroAuto := .F. 

aVetor := {}

dData:=dDataBase

aVetor := {  {"D3_OP"		,"OP002801001   "  	,NIL},;
			 {"D3_COD"		,"P00000000000001"  	,NIL},;
			 {"D3_QUANT"		,30  	,NIL},;
			 {"D3_PARCTOT"	, "P"					,NIL},;
			 {"D3_TM"		,"01 "				,NIL},;
			 {"D3_QTMAIOR"	, 30                   ,NIL}}                                                     	
							
							
MSExecAuto({|x, y| mata250(x, y)},aVetor, nOpc )  

If lMsErroAuto
	CONOUT("Erro")
	mostraerro()
Else
	//CONOUT("Incluido com sucesso")
	CONOUT("Incluido com sucesso")
Endif

conout("Mata250 - TESTE 03")

lMsErroAuto := .F. 

aVetor := {}

dData:=dDataBase

aVetor := {  {"D3_OP"		,"OP002801001   "  	,NIL},;
			 {"D3_COD"		,"P00000000000001"  	,NIL},;
			 {"D3_QUANT"		,30  	,NIL},;
			 {"D3_PARCTOT"	, "P"					,NIL},;
			 {"D3_TM"		,"01 "				,NIL},;
			 {"D3_QTMAIOR"	, 30                   ,NIL}}                                                       	
							
							
MSExecAuto({|x, y| mata250(x, y)},aVetor, nOpc )  

If lMsErroAuto
	CONOUT("Erro")
	mostraerro()
Else
	//CONOUT("Incluido com sucesso")
	CONOUT("Incluido com sucesso")
Endif


Return  