#include 'protheus.ch'
#include 'parmtype.ch'
#include 'TBICONN.ch'

user function GPEA090()

Local aCabe := {}
Local aItens := {}
Local aItensFinal := {}

PRIVATE lMsErroAuto := .F.

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "GPEA"

ACabec:= {}
 aadd(aCabec, {"RA_FILIAL","01", Nil})
 aadd(aCabec, {"RA_MAT","880001", Nil})
 
aItens := {}
	aadd(aItens, {"RC_FILIAL","01", Nil})
	aadd(aItens, {"RC_MAT","880001", Nil})
	aadd(aItens, {"RC_PD","001", Nil})
	aadd(aItens, {"RC_TIPO1","V", Nil})
	aadd(aItens, {"RC_HORAS",100, Nil})
	aadd(aItens, {"RC_VALOR",3500, Nil})
	aadd(aItens, {"RC_DATA",Stod('20180221'), Nil})
	aadd(aItens, {"RC_CC","0000000101", Nil})
	aadd(aItens, {"RC_PARCELA","01", Nil})
  
msExecAuto({|x,y,k,w| GPEA090(x,y,k,w)},4,aCabec,aItens,4)

If lMsErroAuto	
		MostraErro()
else
   alert("Funcionário incluído com sucesso.")
		
EndIf
 
  	
return