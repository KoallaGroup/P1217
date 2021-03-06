#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "TBICONN.CH"

user function MATA110()
	
Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nX := 0
Local nY := 0
Local cDoc := ""
Local cNumSC:= '000014'
Local lOk := .T. 
Private lMsHelpAuto := .T.
PRIVATE lMsErroAuto := .F.

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//| Abertura do ambiente |
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

ConOut(Repl("-",80))
ConOut(PadC(OemToAnsi("Teste de Aproa豫o"),80))

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM" TABLES "SC1","SB1"

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//| Verificacao do ambiente para teste |
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸Db

//Posiciona SC1
SC1->(dbSetOrder(1))
SC1->(dbSeek(xFilial("SC1")+cNumSC))

If lOk 


	ConOut(OemToAnsi("Inicio: ")+Time()) 


		
	aItens := {} 
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴� 
	
	//| Verifica numero da SC | 
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴� 
	
	cDoc := GetSXENum("SC1","C1_NUM") 
	
	SC1->(dbSetOrder(1)) 
	
	While SC1->(dbSeek(xFilial("SC1")+cDoc)) 
	ConfirmSX8() 
	cDoc := GetSXENum("SC1","C1_NUM") 
	EndDo 
	
	aadd(aCabec,{"C1_NUM" ,cDoc}) 
	aadd(aCabec,{"C1_SOLICIT","Administrador"}) 
	aadd(aCabec,{"C1_EMISSAO",dDataBase}) 
	
    aadd(aLinha,{"C1_ITEM"      ,'0001',Nil})
    aadd(aLinha,{"C1_PRODUTO"   ,'02             ',Nil})
    aadd(aLinha,{"C1_APROV"     ,'L',Nil})
	aadd(aItens,aLinha) 	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커 
	//| Teste de Inclusao | 
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 
	
	MSExecAuto({|x,y| mata110(x,y)},aCabec,aItens,7) 
	
	If lMsErroAuto	
		MostraErro()
	else
   alert("Funcion�rio inclu�do com sucesso.")
		
   EndIf
	
	
	ConOut(OemToAnsi("Fim : ")+Time())

EndIf


Return(.T.)