#include "protheus.ch"
#include "totvs.ch"
#include "apwebsrv.ch"

//WSSTRUCT Stru010 //EXEMPLO DE WS COM EXECAUTO Omsa010
    
WSSERVICE TESTE_MATA010
   
   	WSDATA 	ccod        AS string
	WSDATA 	cRet          AS string
    
	WSMETHOD 	incmata010
    
ENDWSSERVICE


WSMETHOD incmata010 WSRECEIVE ccod WSSEND cRet WSSERVICE TESTE_MATA010 

	Local aVetor := {}
    Private lAutoErrNoFile := .T.
    
	private lMsErroAuto := .F.

//PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "EST"

 
	aVetor:= {{"B1_COD"         ,::ccod	     ,NIL},;
		{"B1_DESC"        ,"PRODUTO TESTE - Via webservice" ,NIL},;
		{"B1_TIPO"    	,"PA"            ,Nil},;
		{"B1_UM"      	,"CC"            ,Nil},;
		{"B1_LOCPAD"  	,"1"            ,Nil},;
		{"B1_PICM"    	,0               ,Nil},;
		{"B1_IPI"     	,0               ,Nil},;
		{"B1_CONTRAT" 	,"N"             ,Nil},;
		{"B1_LOCALIZ" 	,"N"             ,Nil}}
		       
		       
//		{"B1_GRUPO",  	,"0001"			, NIL},;
		       
	MSExecAuto({|x,y| Mata010(x,y)},aVetor,3)


if lMsErroAuto
	aLog := GetAutoGRLog()
	::cRet := "erro"
	for i := 1 to len(aLog)
		::cRet += aLog[i]
	next i
else
	::cRet := "ok"
endIf 
