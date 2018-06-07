#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "TBICONN.CH"

user function GPEA020()

Local aCabec   := {}
Local aItens   := {}
Local aLinha   := {}

PRIVATE lMsErroAuto := .F.


PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "GPEA"

//******Primeiro Funcionario ****************************************** //
//-- Inclusao de 2 dependentes para o funcionario da matricula '000002'


aCabec   := {}

aadd(aCabec,{"RA_FILIAL"  ,"01"  ,Nil  })
aadd(aCabec,{"RA_MAT"   ,"000002" ,Nil  })


aItens := {}

aLinha := {}
aadd(aLinha,{"RB_FILIAL"	, "01"   			, Nil })
aadd(aLinha,{"RB_MAT"   	, "000002"   		, Nil })
aadd(aLinha,{"RB_COD"     	, "01"    		, Nil })
aadd(aLinha,{"RB_NOME"   	, "MARIA DA SILVA" 	, Nil })
aadd(aLinha,{"RB_DTNASC" 	, Ctod("01/01/99") 	, Nil })
aadd(aLinha,{"RB_SEXO"  	, "F"    			, Nil })
aadd(aLinha,{"RB_GRAUPAR" 	, "F"    			, Nil })
aadd(aLinha,{"RB_TIPIR"  	, "1"    			, Nil })
aadd(aLinha,{"RB_TIPSF"  	, "1"    			, Nil })
aadd(aLinha,{"RB_LOCNASC" 	, "SP"    		, Nil })


aadd(aItens,aLinha)

aLinha := {}
aadd(aLinha,{"RB_FILIAL"	, "01"    		, Nil })
aadd(aLinha,{"RB_MAT"   	, "000002"   		, Nil })
aadd(aLinha,{"RB_COD"     	, "02"    		, Nil })
aadd(aLinha,{"RB_NOME"   	, "JOÂO MIGUEL" 	, Nil })
aadd(aLinha,{"RB_DTNASC" 	, Ctod("01/01/02") 	, Nil })
aadd(aLinha,{"RB_SEXO"  	, "M"    			, Nil })
aadd(aLinha,{"RB_GRAUPAR"  	, "F"    			, Nil })
aadd(aLinha,{"RB_TIPIR"  	, "1"    			, Nil })
aadd(aLinha,{"RB_TIPSF"  	, "1"    			, Nil })
aadd(aLinha,{"RB_LOCNASC" 	, "SP"    		, Nil })                             


aadd(aItens,aLinha)

U_Envia020(aCabec, aItens)

Return .t.

//*** Segundo Funcionario ******************************************* //

//-- Funcao criada para exemplificar a chamada da execucao da rotina de cadastro de dependentes 
//-- Demonstra-se a inclusao e exclusao de dependentes
USER Function Envia020(aCabec, aItens)

Local nX

//-- Faz chamada a rotina de cadastro de dependentes  para incluir os dependentes (opcao 3)
MSExecAuto({|x,y,k,w,z| GPEA020(x,y,k,w,z)},NIL,aCabec,aItens,3)  //-- Opcao 3 - Inclui registro

//-- Retorno de erro na execução da rotina
If lMsErroAuto 	
    MostraErro()
Else 	

 Alert("Registro(s) Incluído(s) !!!")
 
ENDIF  	

//-- Excluindo o(s) dependente(s)   	For nX:=1 to Len(aItens)    		aLinha:=aItens[nX]  		IF ( lRet:= APMSGYESNO("Deseja eliminar o dependente. Confirmar (S)im / (N)não ? ") )      			//-- Faz chamada a rotina de cadastro de dependentes  para eliminar os dependentes (opcao 5)   			MSExecAuto({|x,y,k,w,z| GPEA020(x,y,k,w,z)},NIL,aCabec,{aLinha},5)  //-- Opcao 5 - Elimina registro   			If lMsErroAuto    				MostraErro()			Else    				Alert("Registro Eliminado !!!")   			Endif   		Endif 	Next nX EndIf
Return(.T.)  

