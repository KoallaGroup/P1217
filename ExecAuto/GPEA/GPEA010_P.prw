#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "TBICONN.CH"

//Esta rotina tem a finalidade de efetuar o lançamento automático de funcionários
//através do mecanismo de rotina automática.
//Nesse exemplo, a chamada da função U_GP010AUT deve ser realizada
//a partir do menu, como demonstrado no extrato de um arquivo (*.XNU) qualquer:
/*  ... Parte anterior do menu ....                                                                       	        
Rotina Auto		Rotina Auto		Rotina Auto        
U_GP010AUT		1		xxxxxxxxxx		07		0	 	
... Continuacao do menu ...*/

user function GPEA010()

Local aCabec   := {}                                               		
PRIVATE lMsErroAuto := .F.
//### Primeiro Funcionario ######################################### //
//-- Inclusão de 1 funcionário da matricula '880001'

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "GPEA"


//Faz processo de Inclusão.

aCabec   := {}
	aadd(aCabec,{"RA_FILIAL" 		,"01 "								,Nil		})
	aadd(aCabec,{"RA_MAT" 			,"99999"							,Nil		})
	aadd(aCabec,{'RA_NOME'			,'FUNCIONARIO ROTINA AUTOMATICA'	,Nil		})
	aadd(aCabec,{'RA_SEXO'			,'F'								,Nil		})
	aadd(aCabec,{'RA_ESTCIVI'		,'C'								,Nil		})
	aadd(aCabec,{'RA_NATURAL'		,'SP'								,Nil		})
	aadd(aCabec,{'RA_NACIONA'		,'10'								,Nil		})
	aadd(aCabec,{'RA_NACIONC'		,'00230'							,Nil		})
	aadd(aCabec,{'RA_NASC'			,Stod('19731215')					,Nil		})
	aadd(aCabec,{'RA_RACACOR'		,'1'								,Nil		})
	aadd(aCabec,{'RA_CC'			,'1.2      '						,Nil		})
	aadd(aCabec,{'RA_ADMISSA'		,Stod('20180109')					,Nil		})
	aadd(aCabec,{'RA_OPCAO'			,Stod('20180109')					,Nil		})
	aadd(aCabec,{'RA_BCDPFGT'		,'34100'							,Nil		})
	aadd(aCabec,{'RA_CTDPFGT'		,'222285'							,Nil		})
	aadd(aCabec,{'RA_HRSMES'		,220 								,Nil		})
	aadd(aCabec,{'RA_HRSEMAN'		,44 								,Nil		})
	aadd(aCabec,{'RA_CODFUNC'		,'ENFER'							,Nil		})
	aadd(aCabec,{'RA_CATFUNC'		,'M'								,Nil		})
	aadd(aCabec,{'RA_TIPOPGT'		,'M'								,Nil		})
	aadd(aCabec,{'RA_SALARIO'		,3172.27							,Nil		})
	aadd(aCabec,{'RA_TIPOADM'		,'9B'								,Nil		})
	aadd(aCabec,{'RA_VIEMRAI'		,'10'								,Nil		})
	aadd(aCabec,{'RA_FORGRAD'		,'ANALISTA'							,Nil		})
	aadd(aCabec,{'RA_PGCTSIN'		,'D'			     				,Nil		})
	aadd(aCabec,{'RA_SINDICA'		,'01'			    				,Nil		})
	aadd(aCabec,{'RA_HRSDIA'		,10  			    				,Nil		})
	aadd(aCabec,{'RA_GRINRAI'		,'50'								,Nil		})
	aadd(aCabec,{'RA_HOPARC'		,'1'								,Nil		})
	aadd(aCabec,{'RA_COMPSAB'		,'1'								,Nil		})
	aadd(aCabec,{'RA_NUMCP'			,'1234567'							,Nil		})
	aadd(aCabec,{'RA_SERCP'			,'150'								,Nil		})
	aadd(aCabec,{'RA_TNOTRAB'		,'MAT'								,Nil		})
	aadd(aCabec,{'RA_ADTPOSE'		,'***N**'							,Nil		})
	aadd(aCabec,{'RA_PROCES'		,'00003'							,Nil		})

	U_Envia(aCabec)

Return(.T.)

USER Function Envia(aCabec)

Local nX  
//-- Faz a chamada da rotina de cadastro de funcionários (opção 3) 


msExecAuto({|x,y,k,w| GPEA010(x,y,k,w)},,,aCabec,3)

//-- Opcao 3 - Inclusao registro
//-- Retorno de erro na execução da rotina
If lMsErroAuto	
		MostraErro()
else
   alert("Funcionário incluído com sucesso.")
		
EndIf

Return(.T.)