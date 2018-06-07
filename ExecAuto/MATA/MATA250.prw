#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "TBICONN.CH"

user function MATA250()
	
Local aVetor := {}          
Local dDataLocal nOpc   := 3 //-Opção de execução da rotina, informado nos parametros quais as opções possiveis

lMsErroAuto := .F.          

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"

dData:=dDataBase

aVetor := {;	
			{"D3_OP"		,"00000501001  "  	,NIL},;
			{"D3_TM"		,"010"				,NIL}}
				
				
MSExecAuto({|x, y| mata250(x, y)},aVetor, nOpc )  


If lMsErroAuto	
		MostraErro()
else
   alert("Inclsuão com sucesso")
		
EndIf

Return