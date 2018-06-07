#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "tbiconn.CH"
User Function MyMata120()
Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nY := 0
Local cDoc := ""
Local lOk := .T.
Local cSeek := ""
Local nCount := 0
PRIVATE lMsErroAuto := .F.
PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT" TABLES "SC7"
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//| Abertura do ambiente |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
ConOut(Repl("-",80))
ConOut(PadC("Teste de Inclusao de 1 pedidos de compra com 1 itens cada",80))

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//| Verificacao do ambiente para teste |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("SB1")
dbSetOrder(1)
If !SB1->(MsSeek(xFilial("SB1")+"2    "))
lOk := .F.
ConOut("Cadastrar produto: PA002")
EndIf
dbSelectArea("SF4")
dbSetOrder(1)
If !SF4->(MsSeek(xFilial("SF4")+"001"))
lOk := .F.
ConOut("Cadastrar TES: 001")
EndIf
dbSelectArea("SE4")
dbSetOrder(1)
If !SE4->(MsSeek(xFilial("SE4")+"001"))
lOk := .F.
ConOut("Cadastrar condicao de pagamento: 001")
EndIf
dbSelectArea("SA2")
dbSetOrder(1)
If !SA2->(MsSeek(xFilial("SA2")+"2     "))
lOk := .F.
ConOut("Cadastrar fornecedor: F00000")
EndIf
//If lOk
ConOut("Inicio: "+Time())
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//| Verifica o ultimo documento valido para um fornecedor |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("SC7")
dbSetOrder(1)
MsSeek(xFilial("SC7")+"zzzzzz",.T.)
dbSkip(-1)
cDoc := SC7->C7_NUM
For nY := 1 To 1
aCabec := {}
aItens := {}
	If Empty(cDoc)
	cDoc := StrZero(1,Len(SC7->C7_NUM))
	Else
	cDoc := Soma1(cDoc)
	EndIf
		aadd(aCabec,{"C7_NUM" ,cDoc})
		aadd(aCabec,{"C7_EMISSAO" ,dDataBase})
		aadd(aCabec,{"C7_FORNECE" ,"2     "})
		aadd(aCabec,{"C7_LOJA" ,"01"})
		aadd(aCabec,{"C7_COND" ,"001"})
		aadd(aCabec,{"C7_CONTATO" ,"AUTO"})
//		aadd(aCabec,{"C7_FILENT" ,CriaVar("C7_FILENT")})

/*cSeek:= xFilial("SC3")+"2     "
dbSelectArea("SC3")
dbSetOrder(2)
MsSeek(cSeek)
While SC3->(!Eof()) .And. xFilial("SC3")+SC3->C3_FORNECE+SC3->C3_LOJA == cSeek */


For nX := 1 To 1
    aLinha := {}
    aadd(aLinha,{"C7_PRODUTO" ,"2              ",Nil})
    aadd(aLinha,{"C7_QUANT" ,1 ,Nil})
    aadd(aLinha,{"C7_PRECO" ,294 ,Nil})
    aadd(aLinha,{"C7_TOTAL" ,294 ,Nil})
    aadd(aLinha,{"C7_TES" ,"001" ,Nil})
    aadd(aItens,aLinha)
Next nX
//		aadd(aLinha,{"C7_NUMSC" ,SC3->C3_NUM ,Nil})
//aadd(aLinha,{"C7_ITEMSC" ,SC3->C3_ITEM ,Nil})
//aadd(aItens,aLinha)
//SC3->(dbSkip())
nCount++
//Enddo
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//| Teste de Inclusao |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If nCount > 0
	MATA120(1,aCabec,aItens,3)

		If !lMsErroAuto
			ConOut("Incluido com sucesso! "+cDoc)
		Else
			ConOut("Erro na inclusao!")
			MostraErro()
		EndIf
	Else
		ConOut("AutorizaГЦo nЦo incluida!")
	EndIF
Next nY

//ENDIF
	ConOut("Fim : "+Time())
Return

/*
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//| Teste de Alteracao |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("SC7")
dbSetOrder(1)
MsSeek(xFilial("SC7")+cDoc)
//C7_FILIAL+C7_NUM+C7_ITEM+C7_SEQUEN
aCabec := {}
aItens := {}
aadd(aCabec,{"C7_NUM" ,SC7->C7_NUM})
aadd(aCabec,{"C7_EMISSAO" ,SC7->C7_EMISSAO})
aadd(aCabec,{"C7_FORNECE" ,SC7->C7_FORNECE})
aadd(aCabec,{"C7_LOJA" ,SC7->C7_LOJA})
aadd(aCabec,{"C7_COND" ,SC7->C7_COND})
aadd(aCabec,{"C7_CONTATO" ,SC7->C7_CONTATO})
aadd(aCabec,{"C7_FILENT" ,SC7->C7_FILENT})
aLinha := {}
aadd(aLinha,{"C7_ITEM" ,SC7->C7_ITEM ,Nil})
aadd(aLinha,{"C7_PRODUTO" ,SC7->C7_PRODUTO ,Nil})
aadd(aLinha,{"C7_QUANT" ,3 ,Nil})
aadd(aLinha,{"C7_PRECO" ,SC7->C7_PRECO ,Nil})
aadd(aLinha,{"C7_TOTAL" ,3*SC7->C7_PRECO ,Nil})
aadd(aLinha,{"C7_NUMSC" ,SC7->C7_NUMSC ,Nil})
aadd(aLinha,{"C7_ITEMSC" ,SC7->C7_ITEMSC ,Nil})
aadd(aLinha,{"C7_REC_WT" ,SC7->(RECNO()) ,Nil})
aadd(aItens,aLinha)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//| Teste de alteracao |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
ConOut(PadC("Teste de alteracao",80))
ConOut("Inicio: "+Time())
MATA120(2,aCabec,aItens,4)
If !lMsErroAuto
ConOut("Alteracao com sucesso! "+cDoc)
Else
ConOut("Erro na Alteracao!")
EndIf
ConOut("Fim : "+Time())
ConOut(Repl("-",80))

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//| Teste de exclusao |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("SC7")
dbSetOrder(1)
MsSeek(xFilial("SC7")+cDoc)
aCabec := {}
aItens := {}
aadd(aCabec,{"C7_NUM" ,SC7->C7_NUM})
aadd(aCabec,{"C7_EMISSAO" ,SC7->C7_EMISSAO})
aadd(aCabec,{"C7_FORNECE" ,SC7->C7_FORNECE})
aadd(aCabec,{"C7_LOJA" ,SC7->C7_LOJA})
aadd(aCabec,{"C7_COND" ,SC7->C7_COND})
aadd(aCabec,{"C7_CONTATO" ,SC7->C7_CONTATO})
aadd(aCabec,{"C7_FILENT" ,SC7->C7_FILENT})
aLinha := {}
aadd(aLinha,{"C7_ITEM" ,SC7->C7_ITEM ,Nil})
aadd(aLinha,{"C7_PRODUTO" ,SC7->C7_PRODUTO ,Nil})
aadd(aLinha,{"C7_QUANT" ,SC7->C7_QUANT ,Nil})
aadd(aLinha,{"C7_PRECO" ,SC7->C7_PRECO ,Nil})
aadd(aLinha,{"C7_NUMSC" ,SC7->C7_NUMSC ,Nil})
aadd(aLinha,{"C7_ITEMSC" ,SC7->C7_ITEMSC ,Nil})
aadd(aLinha,{"C7_REC_WT" ,SC7->(RECNO()) ,Nil})
aadd(aItens,aLinha)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//| Teste de Exclusao |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
ConOut(PadC("Teste de exclusao",80))
ConOut("Inicio: "+Time())
MATA120(2,aCabec,aItens,5)
If !lMsErroAuto
ConOut("Exclusao com sucesso! "+cDoc)
Else
ConOut("Erro na exclusao!")
EndIf
ConOut("Fim : "+Time())
ConOut(Repl("-",80))
EndIf */
//RESET ENVIRONMENT
