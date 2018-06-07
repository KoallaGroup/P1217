#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "RWMAKE.CH" 
#INCLUDE "TBICONN.CH"


user function miMATA140()

Local cDoc 
Local cDoc2
Local nOpc := 0 
private aCabec:= {}
private aItens:= {}
private aLinha:= {}
Private lMsErroAuto := .F.

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "ATF"

cDoc := '17'

 For nx := 1 to 5000
 
 
cDoc2 := cDoc + cvaltochar(nx)
aCabec := 	{	{'F1_TIPO'	,'N'		,NIL},;
				{'F1_FORMUL','S'		,NIL},;
				{'F1_DOC'	,cDoc2	,NIL},;		
				{'F1_SERIE','CC '		,NIL},;		
				{'F1_EMISSAO',dDataBase	,NIL},;		
				{'F1_FORNECE','1     '	,NIL},;		
				{'F1_LOJA'	,'01'		,NIL},;
				{'F1_ESPECIE'	,'NF'		,NIL},;			
				{'F1_COND','BOL'		,NIL} }				
				
 aLinha := {}
	        aadd(aLinha,{"D1_ITEM","0001",Nil})
	        aadd(aLinha,{"D1_COD","2              ",Nil})
	        aadd(aLinha,{"D1_UM",'CC',Nil})
	        aadd(aLinha,{"D1_QUANT",1,Nil})
	        aadd(aLinha,{"D1_VUNIT",100,Nil})
	        aadd(aLinha,{"D1_TOTAL",100,Nil})
	        aadd(aLinha,{"D1_LOCAL",'1 ',Nil})
	        aadd(aLinha,{"D1_CC",'1.2      ',Nil})
//	        aadd(aLinha,{"D1_CLASFIS",' 90',Nil})
	        aadd(aLinha,{"D1_PEDIDO",'000410',Nil})
	        aadd(aLinha,{"D1_ITEMPC",'0001',Nil})
	        aadd(aItens,aLinha)
/*
 aLinha := {}
 			aadd(aLinha,{"D1_ITEM","0002",Nil})
	        aadd(aLinha,{"D1_COD","6              ",Nil})
	        aadd(aLinha,{"D1_UM",'CC',Nil})
	        aadd(aLinha,{"D1_QUANT",1,Nil})
	        aadd(aLinha,{"D1_VUNIT",100,Nil})
	        aadd(aLinha,{"D1_TOTAL",100,Nil})
	        aadd(aLinha,{"D1_LOCAL",'1 ',Nil})
	        aadd(aLinha,{"D1_CC",'1.2      ',Nil})
	        aadd(aItens,aLinha) */

// asort(aItens, , , { | x,y | x[1][2] < y[1][2] })
 
 
 nOpc := 3 

MSExecAuto({|x,y,z| MATA140(x,y,z)}, aCabec, aItens, nOpc)     

		If !lMsErroAuto		
		ConOut("Incluido com sucesso! "+cvaltochar(cDoc2))		
		Else		
		ConOut("Erro na Alteração!")
		Mostraerro()		
		
		EndIf
Next		
Reset ENVIRONMENT	
return

				//{'D1_ITEMPC',''			,NIL},;		
				
				//				{'D1_PEDIDO','000009'			,NIL},;
				//{'D1_ITEMPC','02'			,NIL},;		