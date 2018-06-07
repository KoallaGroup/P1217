#Include 'Protheus.ch'
#include "tbiconn.ch"

User Function m2MATA103()




Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nX     := 0
Local nY     := 0
Local cDoc   := ""
Local lOk    := .T.         
//Private lMsHelpAuto := .T.PRIVATE 
lMsErroAuto := .F.

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//| Abertura do ambiente                                         |
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

ConOut(Repl("-",80))
ConOut(PadC(OemToAnsi("Teste de Inclusao de 2 documentos de entrada com 2 itens cada"),80))

//PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM" TABLES "SF1","SD1","SA1","SA2","SB1","SB2","SF4"
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//| Verificacao do ambiente para teste                           |
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸Db

DbSelectArea("SB1")
DbSetOrder(1)
If !SB1->(MsSeek(xFilial("SB1")+"2"))	
lOk := .F.	
ConOut(OemToAnsi("Cadastrar produto: 2"))
EndIf
DbSelectArea("SF4")
DbSetOrder(1)
If !SF4->(MsSeek(xFilial("SF4")+"101"))	
lOk := .F.	
ConOut(OemToAnsi("Cadastrar TES: 101"))
EndIf
DbSelectArea("SE4")
DbSetOrder(1)
If !SE4->(MsSeek(xFilial("SE4")+"001"))	
lOk := .F.	
ConOut(OemToAnsi("Cadastrar condicao de pagamento: 001"))
EndIf
If !SB1->(MsSeek(xFilial("SB1")+"1"))	
lOk := .F.	
ConOut(OemToAnsi("Cadastrar produto: 1"))
EndIf
DbSelectArea("SA2")
DbSetOrder(1)
If !SA2->(MsSeek(xFilial("SA2")+"1     "))	
lOk := .F.	
ConOut(OemToAnsi("Cadastrar fornecedor: 1"))
EndIf
If lOk	
ConOut(OemToAnsi("Inicio: ")+Time())	
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//| Verifica o ultimo documento valido para um fornecedor        |	
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸	
DbSelectArea("SF1")	
DbSetOrder(2)	
MsSeek(xFilial("SF1")+"01",.T.)	
dbSkip(-1)	
cDoc := "400000027"
For nY := 1 To 1		
aCabec := {}		
aItens := {}		
If Empty(cDoc)			
cDoc := StrZero(1,Len(SD1->D1_DOC))		
Else			
cDoc := Soma1(cDoc)		
EndIf

conout(cDoc+" NF")		
aadd(aCabec,{"F1_TIPO"   ,"N"})		
aadd(aCabec,{"F1_FORMUL" ,"N"})		
aadd(aCabec,{"F1_DOC"    ,(cDoc)})		
aadd(aCabec,{"F1_SERIE"  ,"UNI"})		
aadd(aCabec,{"F1_EMISSAO",dDataBase})		
aadd(aCabec,{"F1_FORNECE","1     "})		
aadd(aCabec,{"F1_LOJA"   ,"01"})		
aadd(aCabec,{"F1_ESPECIE","NFE"})		
aadd(aCabec,{"F1_COND","001"})		
aadd(aCabec,{"F1_DESPESA"   ,10})				
//aadd(aCabec,{"E2_NATUREZ","NAT01"})		
For nX := 1 To 1			
aLinha := {}			
aadd(aLinha,{"D1_COD"  ,"2",Nil})			
aadd(aLinha,{"D1_QUANT",2,Nil})			
aadd(aLinha,{"D1_VUNIT",100,Nil})			
aadd(aLinha,{"D1_TOTAL",200,Nil})			
aadd(aLinha,{"D1_TES","101",Nil})			
aadd(aLinha,{"D1_CONTA","3.1.1               ",Nil})	
aadd(aItens,aLinha)		
Next nX		


BEGIN TRANSACTION 
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커		
//| Teste de Inclusao                                            |
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//MSExecAuto({|x,y,z,w| MATA103( x, y, z, w )},aCabec,aCabec, 3,.t.)
MSExecAuto({|x,y,z,w| MATA103( x, y, z, w )}, aCabec, aItens, 3, .T.)		
If !lMsErroAuto			
ConOut(OemToAnsi("Incluido com sucesso! ")+cDoc)		
Else
Mostraerro()			
ConOut(OemToAnsi("Erro na inclusao!"))		
EndIf	

END TRANSACTION

Next nY	
ConOut(OemToAnsi("Fim  : ")+Time())
EndIf
//RESET ENVIRONMENT



Return(.T.)



