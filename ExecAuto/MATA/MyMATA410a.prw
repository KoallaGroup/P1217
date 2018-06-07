#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"


User Function MyM410a()

Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nX     := 0
Local nY     := 0
Local cDoc   := "9997D"
Local cDoc1   := ""
Local lOk    := .T.
 
PRIVATE lMsErroAuto := .F.
//****************************************************************
//* Abertura do ambiente
//****************************************************************
ConOut(Repl("-",80))
ConOut(PadC("Teste de Inclusao de 1 pedido de venda  com 2 itens cada",80))
PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT" TABLES "SC5","SC6","SA1","SA2","SB1","SB2","SF4"

//****************************************************************
//* Verificacao do ambiente para teste 
//****************************************************************
dbSelectArea("SB1")
dbSetOrder(1)
If !SB1->(MsSeek(xFilial("SB1")+"1"))
    lOk := .F.
    ConOut("Cadastrar produto: 1")
EndIf
dbSelectArea("SF4")
dbSetOrder(1)
If !SF4->(MsSeek(xFilial("SF4")+"520"))
    lOk := .F.
    ConOut("Cadastrar TES: 520")
EndIf
dbSelectArea("SE4")
dbSetOrder(1)
If !SE4->(MsSeek(xFilial("SE4")+"001"))
    lOk := .F.
    ConOut("Cadastrar condicao de pagamento: 001")
EndIf
If !SB1->(MsSeek(xFilial("SB1")+"2"))
    lOk := .F.
    ConOut("Cadastrar produto: 2")
EndIf
dbSelectArea("SA1")
dbSetOrder(1)
If !SA1->(MsSeek(xFilial("SA1")+"2"))
    lOk := .F.
    ConOut("Cadastrar cliente: 2")
EndIf

If lOk
	ConOut("Inicio: "+Time())
    For nY := 1 To 1
		aCabec := {}
	    aItens := {}
	    cDoc1 := cDoc+cvaltochar(4)
	    RollBAckSx8()
	    aadd(aCabec,{"C5_NUM"   ,cDoc1,Nil})
	    aadd(aCabec,{"C5_TIPO","N",Nil})
	    aadd(aCabec,{"C5_CLIENTE","2",Nil})
	    aadd(aCabec,{"C5_LOJACLI","1",Nil})
	    aadd(aCabec,{"C5_LOJAENT","1",Nil})
	    aadd(aCabec,{"C5_CONDPAG","001",Nil})
	    aAdd(aCabec,{"C5_DESC1"	,10	, Nil})
	    aadd(aCabec,{"C5_MENNOTA","Base de Cálculo Reduzida Conforme Decreto Nº 9.764 de 30/12/1999. Essa Fatura nao quita debitos anteriores. Apos o vencimento, pagavel somente nas agencias do Banco do Brasil. Apos vencimento, juros e multas serao cobrados na proxima fatura. -CORTTEX",Nil})
	    If cPaisLoc == "PTG"
	        aadd(aCabec,{"C5_DECLEXP","TESTE",Nil})
	    Endif
	    For nX := 1 To 1
	        aLinha := {}
	        aadd(aLinha,{"C6_ITEM",StrZero(nX,2),Nil})
	        aadd(aLinha,{"C6_PRODUTO","2              ",Nil})
	        aadd(aLinha,{"C6_QTDVEN",2,Nil})
//	        aadd(aLinha,{"C6_PRCVEN",100,Nil})
//	        aadd(aLinha,{"C6_PRUNIT",100,Nil})
//	        aadd(aLinha,{"C6_VALOR",200,Nil})
	        aadd(aLinha,{"C6_LOCAL",'1 ',Nil})
	        aadd(aLinha,{"C6_TES","520",Nil})
	        aadd(aLinha,{"C6_CC",'1.2      ',Nil})
	        aadd(aLinha,{"C6_QTDLIB",2,Nil})
//	        aadd(aLinha,{"C6_LOTECTL",'00001     ',Nil})
	        aadd(aItens,aLinha)
	    Next nX 
	    ConOut(PadC("Teste de Inclusão",80))
	    ConOut("Inicio: "+Time())
//	    MATA410(aCabec,aItens,3)
	    MSExecAuto({|x,y,z| mata410(x,y,z)},aCabec,aItens,3)
	    ConOut("Fim  : "+Time())
	    ConOut(Repl("-",80))  
		If lMsErroAuto
	 		Conout("Erro na Inclusão ")
	 		Mostraerro()
	 	Else
	 		Conout("Incluido com sucesso :"+cvaltochar(cDoc1))
		Endif
		
	 Next nY
	 ConOut("Fim  : "+Time())
Endif


Return

