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


aCabec   := {}

aadd(aCabec,{"RA_FILIAL" 		,"01 "								,Nil		})
aadd(aCabec,{"RA_MAT" 			,"880008"							,Nil		})
aadd(aCabec,{'RA_NOME'			,'FUNCIONARIO 3 ROTINA AUTOMATICA'	,Nil		})
aadd(aCabec,{'RA_CIC'			,'34601881897					'	,Nil		})
aadd(aCabec,{'RA_TIPEND'		,'2'								,Nil		})
aadd(aCabec,{'RA_LOGRPT'		,'R'								,Nil		})
aadd(aCabec,{'RA_LOGRDSC'		,'RUA TESTE 3 ROTINA AUTOMATICA'	,Nil		})
aadd(aCabec,{'RA_ESTADO'		,'PA'	,Nil		})
aadd(aCabec,{'RA_CEP'		,'02262020'	,Nil		})
aadd(aCabec,{'RA_CODMUN'		,'00305'	,Nil		})
aadd(aCabec,{'RA_UFCP'		,'PA'	,Nil		})
aadd(aCabec,{'RA_RACACOR'		,'1'								,Nil		})
aadd(aCabec,{'RA_SEXO'			,'F'								,Nil		})
aadd(aCabec,{'RA_ESTCIVI'		,'C'								,Nil		})
aadd(aCabec,{'RA_CLASEST'		,'01'								,Nil		})
aadd(aCabec,{'RA_NATURAL'		,'PA'								,Nil		})
aadd(aCabec,{'RA_CPAISOR'		,'00230'							,Nil		})
aadd(aCabec,{'RA_NACIONA'		,'20'								,Nil		})
aadd(aCabec,{'RA_NACIONC'		,'00230'							,Nil		})
aadd(aCabec,{'RA_CATEFD'		,'101'								,Nil		})
aadd(aCabec,{'RA_NASC'			,Stod('19731215')					,Nil		})
aadd(aCabec,{'RA_CC'			,'1.2      '						,Nil		})
aadd(aCabec,{'RA_ADMISSA'		,Stod('20080505')					,Nil		})
aadd(aCabec,{'RA_OPCAO'			,Stod('20080505')					,Nil		})
aadd(aCabec,{'RA_BCDPFGT'		,'34100'							,Nil		})
aadd(aCabec,{'RA_CTDPFGT'		,'222285'							,Nil		})
aadd(aCabec,{'RA_HRSMES'		,220 								,Nil		})
aadd(aCabec,{'RA_HRSEMAN'		,44 								,Nil		})
aadd(aCabec,{'RA_CODFUNC'		,'ENFER'							,Nil		})
aadd(aCabec,{'RA_CATFUNC'		,'M'								,Nil		})
aadd(aCabec,{'RA_TIPOPGT'		,'M'								,Nil		})
aadd(aCabec,{'RA_TIPOADM'		,'9A'								,Nil		})
aadd(aCabec,{'RA_PROCES'		,'00003'							,Nil		})
aadd(aCabec,{'RA_VIEMRAI'		,'10'								,Nil		})
aadd(aCabec,{'RA_GRINRAI'		,'55'								,Nil		})
aadd(aCabec,{'RA_HOPARC'		,'1'								,Nil		})
aadd(aCabec,{'RA_COMPSAB'		,'1'								,Nil		})
aadd(aCabec,{'RA_NUMCP'			,'1234567'							,Nil		})
aadd(aCabec,{'RA_SERCP'			,'150'								,Nil		})
aadd(aCabec,{'RA_TNOTRAB'		,'MAT'								,Nil		})
aadd(aCabec,{'RA_ADTPOSE'		,'***N**'							,Nil		})
aadd(aCabec,{'RA_LOGRTP'		,'AV  '							,Nil		})
aadd(aCabec,{'RA_FILHOBR'		,'1'							,Nil		})
aadd(aCabec,{'RA_CASADBR'		,'1'							,Nil		})
aadd(aCabec,{'RA_DATCHEG'		,Stod('20150101')							,Nil		})
aadd(aCabec,{'RA_LOGRDSC'		,'BRAZ LEME'							,Nil		})
aadd(aCabec,{'RA_LOGRNUM'		,'125'							,Nil		})
aadd(aCabec,{'RA_TIPENDE'		,'1'							,Nil		})
aadd(aCabec,{'RA_SEQTURN'		,'01'							,Nil		})
aadd(aCabec,{'RA_REGRA'		,'01'							,Nil		})
aadd(aCabec,{'RA_CARGO'		,'ENFER'							,Nil		})
aadd(aCabec,{'RA_SINDICA'		,'01'							,Nil		})


U_Envia(aCabec)

Return(.T.)

//-- Função criada para exemplificar a chamada da execução da rotina de cadastro de funcionários  

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