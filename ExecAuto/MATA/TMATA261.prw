/*------------------------------------------------------------------*\
| DESCRIÇÃO: Esta rotina possibilita a inclusão/estorno de           |
| transferência de vários itens entre armazéns de forma automática   |
|--------------------------------------------------------------------|
| LINK: http://tdn.totvs.com/pages/releaseview.action?pageId=6089268 |
\*------------------------------------------------------------------*/

#Include "totvs.ch"
#Include "tbiconn.ch"

User Function TMATA261()
	Local nOpc   := 3
	Local aAuto	 := {}
	Local aItens := {}
	Local aArea  := {}

	Local nCount      := 0
	Local cProd	    := "PRDT0001"
	Local cDescri   := ""
	Local lContinue := .T.

	Private lMsErroAuto := .F.
	Private lMsHelpAuto := .T.

	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "EST" TABLES "SB1", "SD3"
		aArea := GetArea()

		GetEnvInfo("MATA261.PRX")

		DbSelectArea("SB1")
		DbSetOrder(1)

		AAdd(aAuto, {"TRM300019", dDataBase})	// Nº DOC E DATA

		While (lContinue == .T.)
			If SB1->(MsSeek(xFilial("SB1") + cProd))
				cProd   := B1_COD
				cDescri	:= B1_DESC
			EndIf

			/* ORIGEM */
			AAdd(aItens, cProd)				// D3_COD
			AAdd(aItens, cDescri)			// D3_DESCRI
			AAdd(aItens, "UN")				// D3_UM
			AAdd(aItens, "01")				// D3_LOCAL
			AAdd(aItens, "RUA BRAZ LEME")	// D3_LOCALIZ

			/* DESTINO */
			AAdd(aItens, cProd)				// D3_COD
			AAdd(aItens, cDescri)			// D3_DESCRI
			AAdd(aItens, "UN")				// D3_UM
			AAdd(aItens, "02")				// D3_LOCAL
			AAdd(aItens, "RUA DOS JABUTIS")	// D3_LOCALIZ

			AAdd(aItens, "")				// D3_NUMSERI
			AAdd(aItens, "")				// D3_LOTECTL
			AAdd(aItens, "")				// D3_NUMLOTE
			AAdd(aItens, dDataBase)		    // D3_DTVALID
			AAdd(aItens, 0)				    // D3_POTENCI
			AAdd(aItens, 11)				// D3_QUANT
			AAdd(aItens, 0)				    // D3_QTSEGUM
			AAdd(aItens, "")				// D3_ESTORNO
			AAdd(aItens, "")				// D3_NUMSEQ
			AAdd(aItens, "")				// D3_LOTECTL
			AAdd(aItens, dDataBase)		    // D3_DTVALID
			AAdd(aItens, "")				// D3_ITEMGRD
			AAdd(aItens, "")				// D3_OBSERVA

			AAdd(aAuto, aItens)

			cProd := "PRDT0003"

			aItens := {}
			++nCount

			If (nCount == 2)
				lContinue := .F.
			EndIf
		End

		MsExecAuto({|x, y| MATA261(x, y)}, aAuto, nOpc)

		If (lMsErroAuto == .T.)
			MostraErro()
			ConOut(Repl("-", 80))
			ConOut(PadC("Teste MATA261 finalizado com erro!", 80))
			ConOut(PadC("Fim: " + Time(), 80))
			ConOut(Repl("-", 80))
		Else
			ConOut(Repl("-", 80))
			ConOut(PadC("Teste MATA261 finalizado com sucesso!", 80))
			ConOut(PadC("Fim: " + Time(), 80))
			ConOut(Repl("-", 80))
		EndIf

		DbCloseArea("SB1")

		RestArea(aArea)
	RESET ENVIRONMENT
Return (NIL)

/*------------------------------------------------------------------*\
| DESCRIÇÃO: Esta função tem como objetivo retornar informações do   |
| ambiente e rotina sem a necessidade de abertura do SmartClient     |
|--------------------------------------------------------------------|
| AUTOR: Guilherme Bigois         |        MODIFICADO EM: 23/05/2018 |
\*------------------------------------------------------------------*/

Static Function GetEnvInfo(cRoutine)
	Local aRPO := {}
    Default cRoutine := ""

    aRPO := GetApoInfo(cRoutine)

    If (!Empty(aRPO))
        ConOut(Repl("-", 80))
        ConOut(PadC("Routine: " + aRPO[1], 80))
        ConOut(PadC("Date: " + DToC(aRPO[4]) + " " + aRPO[5], 80))
        ConOut(Repl("-", 80))
        ConOut(PadC("SmartClient: " + GetBuild(.T.), 80))
        ConOut(PadC("AppServer: " + GetBuild(.F.), 80))
        ConOut(PadC("DbAccess: " + TCAPIBuild() + "/MSSQL" , 80))
		ConOut(Repl("-", 80))
        ConOut(PadC("Started at: " + Time(), 80))
        ConOut(Repl("-", 80))
    Else
        ConOut(Repl("-", 80))
        ConOut(PadC("An error occurred while searching routine data with GetEnvInfo()", 80))
        ConOut(Repl("-", 80))
    EndIf
Return NIL
