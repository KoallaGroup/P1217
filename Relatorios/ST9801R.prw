#INCLUDE "TOPCONN.CH"
#INCLUDE "tbiconn.ch"
#include "TbiCode.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "RPTDEF.CH"

//==================================================================================================//
//	Programa: ST98R01	|	Autor: Luis Paulo									|	Data: 19/01/2017//
//==================================================================================================//
//	Descrição: Relatório de chamados									    		  				//
//																									//
//==================================================================================================//
User Function ST98R01(_nRecno)
Local 		aRet 		:= {}
Local 		_cTimeF
Local 		_cHour
Local 		_cMin
Local 		_cSecs
Private 	nRecno		:= _nRecno


_cTime := Time() // Resultado: 10:37:17
_cHour := SubStr( _cTime, 1, 2 ) // Resultado: 10
_cMin  := SubStr( _cTime, 4, 2 ) // Resultado: 37
_cSecs := SubStr( _cTime, 7, 2 ) // Resultado: 17
_cTimeF	:=_cHour+_cMin+_cSecs

/* Cria Objeto de Impressao */
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define que a impressao deve ser PAISAGEM³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
0 - Tamanho customizavel pelo usuario, informado em nHeight/nWidth. Aplicavel apenas em impressoes do tipo PDF.
1 - Letter   	216mm x 279mm  637 x 823
3 - Tabloid  	279mm x 432mm  823 x 1275
7 - Executive 	184mm x 267mm  543 x 788
8 - A3     		297mm x 420mm  876 x 1240
9 - A4     		210mm x 297mm  620 x 876
*/

lAdjustToLegacy := .F.   //.F.- COMPATIBILIDADE COM A CLASSE TMSPRINTER
lDisableSetup  	:= .F.
lViewPDF		:= .T.
cFilename 		:= "Orcamentos Especiais"+DTOS(DATE())+_cTimeF
cImp			:= IMP_PDF // IMP_SPOOL

oPrn := FWMSPrinter():New(cFilename,cImp,lAdjustToLegacy,,lDisableSetup,,,,,,,lViewPDF,)
//oPrn:SetResolution(78)
//oPrn:SetLandscape() // ou
oPrn:SetPortrait()
//oPrn:SetPaperSize(DMPAPER_A4)
oPrn:SetPaperSize(9)
oPrn:SetMargin(10,10,10,10) // nEsquerda, nSuperior, nDireita, nInferior
oPrn:cPathPDF := "C:\TEMP\" // Caso seja utilizada impressão em IMP_PDF

If oPrn:nModalResult == PD_OK

	Processa({|| ImpcAlias()}, "Imprimindo Chamado") //Chama a Funcao ImpcAlias
Else
	oPrn:Cancel()
	If oPrn:Canceled()
		RETURN .T.
	Endif
EndIf

Return


/* --- ImprimeDados ------------------------------------------------------------------------------- */
Static Function ImpcAlias()
Local 	nLin2	:= 0010
Local	nLin3	:= 0580
Local 	aImgs	:= {}
Local 	nX		:= 0
Local 	cDir	:= GetSrvProfString ("ROOTPATH","D:\Totvs\Protheus11\Teste\Ambiente\teste\dirdoc\webshop\chamados\")
Local 	aRet	:= {}
Local	cEnd	:= SuperGetMv("ST_ENDNWEB", .F., "http://novowebshop.hospedagemdesites.ws/",)

/*fontes*/
Private	oFont05
Private oFont05n
Private oFont06
Private oFont06n
Private oFont07
Private oFont07n
Private oFont08
Private oFont08n
Private oFont09
Private oFont09n
Private oFont10
Private oFont10n
Private oFont11
Private oFont11n
Private oFont12
Private oFont12n
Private oFont13
Private oFont13n
Private oFont14
Private oFont14n
Private oFont15
Private oFont15n
Private oFont16
Private oFont16n
Private oFont17
Private oFont17n
Private oFont18
Private oFont18n
Private	_nF			:= 1
Private nPag		:= 0
Private	nLin		:= 0

NFonte(_nF)			//carrega as fontes

If Buscar1()		//Chama a funcao para montar a query do relatorio
		MsgAlert("DADOS NÃO DISPONÍVEIS!!!")
	Else
		DbSelectArea("cAlias1")
		cAlias1->(DBGOTOP())

		ProcRegua(0)

		oPrn:StartPage()

		oPrn:Box(0010,0010, 0795, 0580,"-4") //Cria borda no relatorio

		nLin	:= Cabec()	//IMPRIME kABECALHO PADRAO E RETORNA A POSIÇÃO DA LINHA

		IncProc()

		oPrn:line(nLin += 07, 0010, nLin += 07, 0580 )
		oPrn:line(nLin += 01, 0010, nLin += 01, 0580 )
		oPrn:SayAlign (nLin += 02	, 0010	, "DADOS DA REVENDA E PEDIDO:" 		,oFont11n,00150,,,0,)
		oPrn:line(nLin += 05, 0010, nLin += 05, 0580 )
		oPrn:SayAlign (nLin += 05	, 0010	, "Nome da revenda:" 				,oFont10n,00080,,,0,)
		oPrn:SayAlign (nLin 		, 0080	, Alltrim(cAlias1->CODREV) + " - " + Alltrim(cAlias1->DESCREV),oFont10,00150,,,0,)
		oPrn:SayAlign (nLin 		, 0480	, "Código:" 				, oFont10n	,00030,,,0,)
		oPrn:SayAlign (nLin 		, 0515	, Alltrim(cAlias1->CODLAU)	, oFont10	,00030,,,0,)
		oPrn:SayAlign (nLin += 12	, 0010	, "Nr. Pedido:"				, oFont10n	,00050,,,0,)
		oPrn:SayAlign (nLin 		, 0053	, Alltrim(cAlias1->PEDIDO)	, oFont10	,00050,,,0,)
		oPrn:SayAlign (nLin 		, 0210	, "Dt Pedido:" 				, oFont10n	,00040,,,0,)
		oPrn:SayAlign (nLin 		, 0260	, dtoc(stod(cAlias1->EMISSAPD)), oFont10	,00030,,,0,)
		oPrn:SayAlign (nLin 		, 0470	, "Nf Original:"			, oFont10n	,00045,,,0,)
		oPrn:SayAlign (nLin 		, 0515	, Alltrim(cAlias1->NF)		, oFont10	,00050,,,0,)
		//oPrn:line(nLin += 07, 0010, nLin += 07, 0580 )

		oPrn:line(nLin += 15, 0010, nLin += 15, 0580 )
		oPrn:line(nLin += 01, 0010, nLin += 01, 0580 )
		oPrn:SayAlign (nLin += 02	, 0010	, "DADOS O PRODUTO:" 		, oFont11n,00150,,,0,)
		oPrn:line(nLin += 05, 0010, nLin += 05, 0580 )

		aRet	:= Buscar2(Alltrim(cAlias1->NUMORC),Alltrim(cAlias1->CODPRO)) //Busca a cor e o tecido da Z05

		oPrn:SayAlign (nLin += 05	, 0010	, "Descrição do Produto"	, oFont10n	,00150,,,0,)
		oPrn:SayAlign (nLin 		, 0360	, "Cor estrutura" 			, oFont10n	,00050,,,0,)
		oPrn:SayAlign (nLin 		, 0500	, "Tecido e cor"			, oFont10n	,00050,,,0,)
		oPrn:SayAlign (nLin += 10	, 0010	, Alltrim(cAlias1->CODPRO) + ' - '+ Alltrim(cAlias1->DESCPRO), oFont10	,00350,,,0,)
		oPrn:SayAlign (nLin 		, 0360	, Alltrim(aRet[1][2])		, oFont10	,00150,,,0,)
		oPrn:SayAlign (nLin 		, 0500	, Alltrim(aRet[2][2])		, oFont10	,00150,,,0,)
		//oPrn:line(nLin += 07, 0010, nLin += 07, 0580 )

		oPrn:line(nLin += 15, 0010, nLin += 15, 0580 )
		oPrn:line(nLin += 01, 0010, nLin += 01, 0580 )
		oPrn:SayAlign (nLin += 02	, 0010	, "DESCRIÇÃO DO PROBLEMA ENCONTRADO", oFont11n	,00550,,,0,)
		oPrn:SayAlign (nLin += 10	, 0010	, "(Dados fornecidos pelo cliente/revenda/consultor e descritos pelo pós vendas.)", oFont08n	,00550,,,0,)
		oPrn:line(nLin += 05, 0010, nLin += 05, 0580 )
		oPrn:SayAlign (nLin += 05	, 0010	, Alltrim(cAlias1->ASSUNTO) + ' - '+ Alltrim(cAlias1->DESOCO)	, oFont10	,00450,,,0,)
		//oPrn:line(nLin += 05, 0010, nLin += 05, 0580 )

		oPrn:line(nLin += 10, 0010, nLin += 10, 0580 )
		oPrn:line(nLin += 01, 0010, nLin += 01, 0580 )
		oPrn:SayAlign (nLin += 02	, 0010	, "DADOS DA ANÁLISE TÉCNICA", oFont11n	,00550,,,0,)
		oPrn:SayAlign (nLin += 10	, 0010	, "(Descrição detalhada das falhas apresentadas, dos testes aplicados, com inserção de imagens, desenhos e comentários.(preenchido pela área técnica responsável))", oFont08n	,00570,,,0,)
		oPrn:line(nLin += 05, 0010, nLin += 05, 0580 )

		If !Empty(cAlias1->AVATEC)  //Se o movimento é igual a receber

			nMemoQtd	:= Len(Alltrim(cAlias1->AVATEC))	//Pega a qtd de caracteres
			If nMemoQtd > 168								//Inicia os calculos para saber a qtd de linhas

					nMemoLin	:= nMemoQtd/168
					If int(nMemoLin) < nMemoLin
							nMemoLin := ((int(nMemoLin))+1)
					EndIf

				Else
					nMemoLin	:= 1
			EndIF

			For nX	:= 1 To nMemoLin					//inicia a impressão das linhas

				If nx > 4	//Somente 3 linhas
					Exit
				EndIf

				If nX == 1
						nVar1	:= 1
						nVar2	:= 168
					Else
						nVar1	+= 168
				EndIf

				If nX == 1
						oPrn:say(nLin += 0007 , 0010, SUBSTR(ALLTRIM(cValtoChar(cAlias1->AVATEC)),nVar1,nVar2) , oFont08,,,)
					Else
						oPrn:say(nLin += 0007 , 0010, SUBSTR(ALLTRIM(cValtoChar(cAlias1->AVATEC)),nVar1,nVar2) , oFont08,,,)
				EndIf

			Next

		EndIF

		//oPrn:line(nLin += 05, 0010, nLin += 05, 0580 )

		oPrn:line(nLin += 10, 0010, nLin += 10, 0580 )
		oPrn:line(nLin += 01, 0010, nLin += 01, 0580 )
		oPrn:SayAlign (nLin += 02	,0010, "ORIGEM DA FALHA"	, oFont11n	,00550,,,0,)

		//Primeiro bloco
		oPrn:Box(nLin += 15			,0012, (nLin) + 10, 0022,"-2")
		oPrn:SayAlign (nLin 		,0025, "Stobag"				, oFont10n	,00050,,,0,)

		If Alltrim(cAlias1->ORIFALHA) == '000001'
			oPrn:SayAlign (nLin ,0013, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin 				,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "Back Office"		, oFont10n	,00050,,,0,)

		If Alltrim(cAlias1->FALHA) == '000001'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf


		oPrn:Box(nLin 				,0320, (nLin) + 10, 0330,"-2")
		oPrn:SayAlign (nLin			,0333, "Fundição"			, oFont10n	,00050,,,0,)
		If Alltrim(cAlias1->SETOR) == '20308'
			oPrn:SayAlign (nLin ,0321, "X"	, oFont10	,00050,,,0,)
		EndIf


		oPrn:Box(nLin += 15			,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "Falha de projeto"	, oFont10n	,00100,,,0,)
		If Alltrim(cAlias1->FALHA) == '000002'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf


		oPrn:Box(nLin 				,0320, (nLin) + 10, 0330,"-2")
		oPrn:SayAlign (nLin			,0333, "Comissionamento"	, oFont10n	,00100,,,0,)
		If Alltrim(cAlias1->SETOR) == '2030208'
			oPrn:SayAlign (nLin ,0321, "X"	, oFont10	,00050,,,0,)
		EndIf


		oPrn:Box(nLin += 15			,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "Falha de producao"	, oFont10n	,00100,,,0,)
		If Alltrim(cAlias1->FALHA) == '000003'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin 				,0320, (nLin) + 10, 0330,"-2")
		oPrn:SayAlign (nLin			,0333, "Pintura"			, oFont10n	,00050,,,0,)
		If Alltrim(cAlias1->SETOR) == '10202'
			oPrn:SayAlign (nLin ,0321, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin += 15			,0320, (nLin) + 10, 0330,"-2")
		oPrn:SayAlign (nLin			,0333, "Costura"			, oFont10n	,00050,,,0,)
		If Alltrim(cAlias1->SETOR) == '10301'
			oPrn:SayAlign (nLin ,0321, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin += 15			,0320, (nLin) + 10, 0330,"-2")
		oPrn:SayAlign (nLin			,0333, "Montagem"			, oFont10n	,00050,,,0,)
		If Alltrim(cAlias1->SETOR) == '10303'
			oPrn:SayAlign (nLin ,0321, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin += 15			,0320, (nLin) + 10, 0330,"-2")
		oPrn:SayAlign (nLin			,0333, "Embalagem"			, oFont10n	,00050,,,0,)
		If Alltrim(cAlias1->SETOR) == '1030377777777'
			oPrn:SayAlign (nLin ,0321, "X"	, oFont10	,00050,,,0,)
		EndIf

		//Fim do primeiro bloco
		nLin += 12

		//Segundo bloco
		oPrn:Box(nLin += 15			,0012, (nLin) + 10, 0022,"-2")
		oPrn:SayAlign (nLin 		,0025, "Transporte"					, oFont10n	,00050,,,0,)
		If Alltrim(cAlias1->ORIFALHA) == '000002'
			oPrn:SayAlign (nLin ,0013, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin 				,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "Avaria"			, oFont10n	,00050,,,0,)
		If Alltrim(cAlias1->FALHA) == '000005'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin += 15			,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "Falha na Entrega"			, oFont10n	,00100,,,0,)
		If Alltrim(cAlias1->FALHA) == '000006'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin += 15			,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "Entrega incompleta"			, oFont10n	,00100,,,0,)
		If Alltrim(cAlias1->FALHA) == '000007'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf

		//Fim do segundo bloco
		nLin += 12

		//Terceiro bloco
		oPrn:Box(nLin += 15			,0012, (nLin) + 10, 0022,"-2")
		oPrn:SayAlign (nLin 		,0025, "Revenda"							, oFont10n	,00050,,,0,)
		If Alltrim(cAlias1->ORIFALHA) == '000003'
			oPrn:SayAlign (nLin ,0013, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin 				,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "Falha na especificação do produto"	, oFont10n	,00150,,,0,)
		If Alltrim(cAlias1->FALHA) == '000008'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin += 15			,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "Falha na digitação do produto"		, oFont10n	,00150,,,0,)
		If Alltrim(cAlias1->FALHA) == '000009'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin += 15			,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "Falha na instalação"				, oFont10n	,00100,,,0,)
		If Alltrim(cAlias1->FALHA) == '000010'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf

		//Fim do terceiro bloco
		nLin += 12

		//Quarto bloco
		oPrn:Box(nLin += 15			,0012, (nLin) + 10, 0022,"-2")
		oPrn:SayAlign (nLin 		,0025, "Cliente Final"								, oFont10n	,00050,,,0,)
		If Alltrim(cAlias1->ORIFALHA) == '000004'
			oPrn:SayAlign (nLin ,0013, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin 				,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "Manuseio incorreto"							, oFont10n	,00100,,,0,)
		If Alltrim(cAlias1->FALHA) == '000011'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin += 15			,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "Falha ou falta de manutenção preventiva"	, oFont10n	,00150,,,0,)
		If Alltrim(cAlias1->FALHA) == '000012'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin += 15			,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "Descuido com produto(ex: não recolheu com vento/chuva)"	, oFont10n	,00200,,,0,)
		If Alltrim(cAlias1->FALHA) == '000013'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf

		//Fim do quarto bloco
		nLin += 17


		//Quinto bloco
		oPrn:SayAlign (nLin			,0012, "Procede Garantia?"			, oFont10n,00100,,,0,)
		oPrn:Box(nLin 				,0100, (nLin) + 10, 0110,"-2")
		oPrn:SayAlign (nLin 		,0112, "SIM"						, oFont10n,00050,,,0,)
		If Alltrim(cAlias1->CONCGAR) == '1'
			oPrn:SayAlign (nLin ,0113, "X"	, oFont10	,00050,,,0,)
		EndIf

		oPrn:Box(nLin 				,0150, (nLin) + 10, 0160,"-2")
		oPrn:SayAlign (nLin			,0163, "NÃO"						, oFont10n,00050,,,0,)
		If Alltrim(cAlias1->CONCGAR) == '2'
			oPrn:SayAlign (nLin ,0151, "X"	, oFont10	,00050,,,0,)
		EndIf

		//Fim do quinto bloco

		oPrn:line(nLin += 10, 0010, nLin += 10, 0580 )
		oPrn:line(nLin += 01, 0010, nLin += 01, 0580 )
		oPrn:SayAlign (nLin += 02	, 0010	, "CONCLUSÃO TÉCNICA", oFont11n	,00550,,,0,)
		oPrn:SayAlign (nLin += 10	, 0010	, "(Sugestão da ação a ser tomada para conserto da avaria. Aguarda conclusão do laudo. Acordo dep. comercial e revenda ou cliente final.)", oFont08n	,00550,,,0,)
		oPrn:line(nLin += 05, 0010, nLin += 05, 0580 )

		If !Empty(cAlias1->LAUMOTIV)  //Se o movimento é igual a receber

			nMemoQtd	:= Len(Alltrim(cAlias1->LAUMOTIV))	//Pega a qtd de caracteres
			If nMemoQtd > 168								//Inicia os calculos para saber a qtd de linhas

					nMemoLin	:= nMemoQtd/168
					If int(nMemoLin) < nMemoLin
							nMemoLin := ((int(nMemoLin))+1)
					EndIf

				Else
					nMemoLin	:= 1
			EndIF

			For nX	:= 1 To nMemoLin					//inicia a impressão das linhas

				If nx > 4	//Somente 3 linhas
					Exit
				EndIf

				If nX == 1
						nVar1	:= 1
						nVar2	:= 168
					Else
						nVar1	+= 168
				EndIf

				If nX == 1
						oPrn:say(nLin += 0007 , 0010, SUBSTR(ALLTRIM(cValtoChar(cAlias1->LAUMOTIV)),nVar1,nVar2) , oFont08,,,)
					Else
						oPrn:say(nLin += 0007 , 0010, SUBSTR(ALLTRIM(cValtoChar(cAlias1->LAUMOTIV)),nVar1,nVar2) , oFont08,,,)
				EndIf

			Next

		EndIF

		oPrn:SayAlign (nLin += 15	, 0010	, "Análise:" 				, oFont10n	,00042,,,0,)
		oPrn:SayAlign (nLin 		, 0042	, Alltrim(cAlias1->NMRESP) 	, oFont10	,00200,,,0,)
		oPrn:SayAlign (nLin 		, 0250	, "Revisão:" 				, oFont10n	,00037,,,0,)
		oPrn:SayAlign (nLin 		, 0287	, Alltrim(cAlias1->NMRESP)	, oFont10	,00200,,,0,)
		oPrn:SayAlign (nLin 		, 0490	, "Data:" 					, oFont10n	,00022,,,0,)
		oPrn:SayAlign (nLin 		, 0512	, DTOC((STOD(cAlias1->DTLAUDO)))	, oFont10	,00050,,,0,)
		oPrn:line(nLin += 05, 0010, nLin += 05, 0580 )

		oPrn:line(nLin += 07, 0010, nLin += 07, 0580 )
		oPrn:line(nLin += 01, 0010, nLin += 01, 0580 )

		oPrn:SayAlign (nLin += 02	, 0010	, "NEGOCIACAO COMERCIAL", oFont11n	,00550,,,0,)
		oPrn:SayAlign (nLin += 10	, 0010	, "(Descrição da ação a ser tomada para conserto da avaria)", oFont08n	,00550,,,0,)
		oPrn:line(nLin += 05, 0010, nLin += 05, 0580 )

		If !Empty(cAlias1->RETCLI)  //Se o movimento é igual a receber

			nMemoQtd	:= Len(Alltrim(cAlias1->RETCLI))	//Pega a qtd de caracteres
			If nMemoQtd > 168								//Inicia os calculos para saber a qtd de linhas

					nMemoLin	:= nMemoQtd/168
					If int(nMemoLin) < nMemoLin
							nMemoLin := ((int(nMemoLin))+1)
					EndIf

				Else
					nMemoLin	:= 1
			EndIF

			For nX	:= 1 To nMemoLin					//inicia a impressão das linhas

				If nx > 4	//Somente 3 linhas
					Exit
				EndIf

				If nX == 1
						nVar1	:= 1
						nVar2	:= 168
					Else
						nVar1	+= 168
				EndIf

				If nX == 1
						oPrn:say(nLin += 0007 , 0010, SUBSTR(ALLTRIM(cValtoChar(cAlias1->RETCLI)),nVar1,nVar2) , oFont08,,,)
					Else
						oPrn:say(nLin += 0007 , 0010, SUBSTR(ALLTRIM(cValtoChar(cAlias1->RETCLI)),nVar1,nVar2) , oFont08,,,)
				EndIf

			Next

		EndIF

		oPrn:line(nLin += 10, 0010, nLin += 10, 0580 )
		oPrn:line(nLin += 01, 0010, nLin += 01, 0580 )

		nLin := 0785
		oPrn:SayAlign (nLin 		, 0010	, "Responsável:" 			, oFont10n	,00065,,,0,)
		oPrn:SayAlign (nLin 		, 0065	, Alltrim(cAlias1->NMRESP) 	, oFont10	,00300,,,0,)
		oPrn:SayAlign (nLin 		, 0490	, "Data:" 					, oFont10n	,00022,,,0,)
		oPrn:SayAlign (nLin 		, 0512	, DTOC((STOD(cAlias1->DTLAUDO))), oFont10	,00050,,,0,)

		nLin := 0800
		oPrn:SayAlign (nLin += 06	, 0010	, "Stobag do Brasil" 				, oFont06n	,00050,,,0,)
		oPrn:SayAlign (nLin += 06	, 0010	, "Endereço:" 						, oFont06n	,00040,,,0,)
		oPrn:SayAlign (nLin 		, 0040	, "Rua Rafael Puchetti, 1.110, Braga, São José dos Pinhais - PR - BR - Cep(83020-330)" 			, oFont06	,00470,,,0,)
		oPrn:SayAlign (nLin += 06	, 0010	, "Telefones:" 						, oFont06n	,00040,,,0,)
		oPrn:SayAlign (nLin 		, 0040	, "0800 709 9080 | +55 41 2105 9000" 			, oFont06	,00470,,,0,)
		oPrn:SayAlign (nLin += 06	, 0010	, "www.stobag.com.br | stobag@stobag.com.br"	, oFont06n	,00400,,,0,)

EndIf


If !Empty(cAlias1->XIMGSS) .AND. MsgYesNo("Existe um documento anexado a este chamado, você deseja visualiza-lo?")

		winexec("C:\Program Files\Internet Explorer\IEXPLORE.EXE " + cEnd + Alltrim(cAlias1->XIMGSS),1)

		oPrn:EndPage()
		oPrn:Preview()		//preview
	Else
		oPrn:EndPage()
		oPrn:Preview()		//preview

EndIf


/* Antiga forma que imprimia até 6 fotos no chamado
If !Empty(cAlias1->XIMGSS)

		oPrn:EndPage()
		oPrn:StartPage()

		oPrn:Box(0010,0010, 0795, 0580,"-4") //Cria borda no relatorio
		nLin	:= Cabec()

		aImgs := StrTokArr(Alltrim(cAlias1->XIMGSS), "|")

		oPrn:SayAlign (nLin += 02	, 0010	, "ANEXOS", oFont11n	,00550,,,0,)
		oPrn:SayAlign (nLin += 10	, 0010	, "(Imagens utilizadas para auxiliar a análise)", oFont08n	,00550,,,0,)
		oPrn:line(nLin += 05, 0010, nLin += 05, 0580 )


		For nX := 1 To Len(aImgs)

			If nX == 1
					oPrn:SayBitMap( nLin += 0015	, 0020, "\\DESENVOLVIMENTO\chamados\" + Alltrim(aImgs[nX]), 250, 150)

				ElseIf nX == 2
					oPrn:SayBitMap( nLin 			, 0300, "\\DESENVOLVIMENTO\chamados\" + Alltrim(aImgs[nX]), 250, 150)

				ElseIf nX == 3
					oPrn:SayBitMap( nLin += 200		, 0020, "\\DESENVOLVIMENTO\chamados\" + Alltrim(aImgs[nX]), 250, 150)

				ElseIf nX == 4
					oPrn:SayBitMap( nLin 			, 0300, "\\DESENVOLVIMENTO\chamados\" + Alltrim(aImgs[nX]), 250, 150)

				ElseIf nX == 5
					oPrn:SayBitMap( nLin += 200		, 0020, "\\DESENVOLVIMENTO\chamados\" + Alltrim(aImgs[nX]), 250, 150)

				ElseIf nX == 6
					oPrn:SayBitMap( nLin 			, 0300, "\\DESENVOLVIMENTO\chamados\" + Alltrim(aImgs[nX]), 250, 150)
				Else

			EndIf

		Next


		nLin := 0800
		oPrn:SayAlign (nLin += 06	, 0010	, "Stobag do Brasil" 				, oFont06n	,00050,,,0,)
		oPrn:SayAlign (nLin += 06	, 0010	, "Endereço:" 						, oFont06n	,00040,,,0,)
		oPrn:SayAlign (nLin 		, 0040	, "Rua Rafael Puchetti, 1.110, Braga, São José dos Pinhais - PR - BR - Cep(83020-330)" 			, oFont06	,00470,,,0,)
		oPrn:SayAlign (nLin += 06	, 0010	, "Telefones:" 						, oFont06n	,00040,,,0,)
		oPrn:SayAlign (nLin 		, 0040	, "0800 709 9080 | +55 41 2105 9000" 			, oFont06	,00470,,,0,)
		oPrn:SayAlign (nLin += 06	, 0010	, "www.stobag.com.br | stobag@stobag.com.br"	, oFont06n	,00400,,,0,)

		oPrn:EndPage()
		oPrn:Preview()
	Else
		oPrn:EndPage()
		oPrn:Preview()		//preview
EndIf
*/

cAlias1->(DBCloseArea())
Return()

/* --- MontaDados ------------------------------------------------------------------------------- */
Static Function Buscar1() //Relatorio 2
Local 	cCRLF		:= CRLF
Local 	cSql1		:= ""
Local 	_cComp1
Local 	_cComp2
Local 	_cCompf
Private cAlias1		:= GetNextAlias()

/* Cria Query */
If Select("cAlias1") <> 0
	DBSelectArea("cAlias1")
	cAlias1->(DBCloseArea())
Endif

cSql1 :="SELECT	SD2.D2_DOC AS NF,
cSql1 +="		SD2.D2_PEDIDO AS PEDIDO,(SELECT C5_EMISSAO FROM SC5010 WHERE C5_FILIAL = '' AND C5_NUM = SD2.D2_PEDIDO AND D_E_L_E_T_='') AS EMISSAPD, "+cCRLF
cSql1 +="		ISNULL(CONVERT(VARCHAR(4096),CONVERT(VARBINARY(4096),SZT.ZT_MOTIVO)),'')  AS LAUMOTIV, "+cCRLF
cSql1 +="		SZT.ZT_ORIFAL AS ORIFALHA,SZT.ZT_DESCOFA AS DESCOFA,	"+cCRLF
cSql1 +="		SZT.ZT_FALHA AS FALHA,SZT.ZT_DESCFAL AS DESCFAL,		"+cCRLF
cSql1 +="		SZT.ZT_CC AS SETOR, SZT.ZT_CCDESC AS CCDESC,SZT.ZT_NUM AS CODLAU,"+cCRLF
cSql1 +="		SZT.ZT_CODRESP AS CODRESP,SZT.ZT_NOMRESP AS NMRESP,		"+cCRLF
cSql1 +="		SZT.ZT_DATAINI AS DTLAUDO,								"+cCRLF
cSql1 +="		ISNULL(CONVERT(VARCHAR(4096),CONVERT(VARBINARY(4096),SZT.ZT_ATECNIC)),'') AS AVATEC, "+cCRLF
cSql1 +="		ZC1.ZC1_PROGAR AS PROGARANT,	"+cCRLF
cSql1 +="		ZC1.ZC1_DTENC AS DTENCCHA,ZC1.ZC1_CODIGO AS CODIGO, ZC1.ZC1_CODPRO AS CODPRO,ZC1.ZC1_DESPRO AS DESCPRO,ZC1.ZC1_DESASS AS ASSUNTO, "+cCRLF
cSql1 +="		ZC1.ZC1_DESOCO AS DESOCO,ZC1.ZC1_CODREV AS CODREV,ZC1.ZC1_NOMREV AS DESCREV,ZC1.ZC1_CC AS CC, ZC1.ZC1_CCDESC AS CCDESC, "+cCRLF
cSql1 +="		ISNULL(CONVERT(VARCHAR(4096),CONVERT(VARBINARY(4096),ZC1.ZC1_OBSENC)),'')  AS CHAOBSEN,ZC1.ZC1_GCONCE AS CONCGAR,	"+cCRLF
cSql1 +="		ISNULL(CONVERT(VARCHAR(4096),CONVERT(VARBINARY(4096),ZC1.ZC1_RETCLI)),'')  AS RETCLI,ZC1.ZC1_ARQ AS XIMGSS,ZC1_WSP_ID,	"+cCRLF
cSql1 +="		(SELECT TOP 1  C6_NUMORC FROM SC6010 WHERE C6_FILIAL = '' AND C6_NUM = SD2.D2_PEDIDO AND C6_PRODUTO = ZC1.ZC1_CODPRO AND D_E_L_E_T_='') AS NUMORC 	"+cCRLF
cSql1 +="FROM ZC1010 ZC1 "+cCRLF
cSql1 +="LEFT JOIN SD2010 SD2	ON ZC1.ZC1_NUMNF = SD2.D2_DOC AND ZC1.ZC1_CODPRO = SD2.D2_COD AND SD2.D_E_L_E_T_='' AND SD2.D2_FILIAL = '01' "+cCRLF
cSql1 +="LEFT JOIN SZT010 SZT	ON ZC1.ZC1_FILIAL = SZT.ZT_FILIAL AND ZC1.ZC1_CODLAU = SZT.ZT_NUM AND SZT.D_E_L_E_T_ = '' "+cCRLF
cSql1 +="WHERE ZC1.R_E_C_N_O_ = '"+ cValToChar(nRecno) +"'"+cCRLF

//C6_CORESTR,
CONOUT(cSql1)

TCQuery cSql1 NEW ALIAS 'cAlias1'		//depois que a Query é montada é utilizado a função TCQUERY criando uma tabela temporária com o resultado da pesquisa.

DBSelectArea("cAlias1")
cAlias1->(DBGoTop())

Return cAlias1->(EOF())


Static Function NFonte(_nF)
	Private	_nFonte	:= _nF

	If 	_nFonte == 1
		oFont05 	:= TFont():New("Arial"			,05,05,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont05n	:= TFont():New("Arial"			,05,05,,.T.,,,,.T.,.F.)
		oFont06 	:= TFont():New("Arial"			,06,06,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont06n	:= TFont():New("Arial"			,06,06,,.T.,,,,.T.,.F.)
		oFont07 	:= TFont():New("Arial"			,07,07,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont07n	:= TFont():New("Arial"			,07,07,,.T.,,,,.T.,.F.)
		oFont08 	:= TFont():New("Arial"			,08,08,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont08n	:= TFont():New("Arial"			,08,08,,.T.,,,,.T.,.F.)
		oFont10 	:= TFont():New("Arial"			,10,10,,.F.,,,,.T.,.F.)
		oFont10n	:= TFont():New("Arial"			,10,10,,.T.,,,,.T.,.F.)
		oFont11 	:= TFont():New("Arial"			,11,11,,.F.,,,,.T.,.F.)
		oFont11n	:= TFont():New("Arial"			,11,11,,.T.,,,,.T.,.F.)
		oFont12 	:= TFont():New("Arial"			,12,12,,.F.,,,,.T.,.F.)
		oFont12n	:= TFont():New("Arial"			,12,12,,.T.,,,,.T.,.F.)
		oFont13 	:= TFont():New("Arial"			,13,13,,.F.,,,,.T.,.F.)
		oFont13n	:= TFont():New("Arial"			,13,13,,.T.,,,,.T.,.F.)
		oFont14		:= TFont():New("Arial"			,14,14,,.F.,,,,.T.,.F.)
		oFont14n	:= TFont():New("Arial"			,14,14,,.T.,,,,.T.,.F.)
		oFont15		:= TFont():New("Arial"			,15,15,,.F.,,,,.T.,.F.)
		oFont15n	:= TFont():New("Arial"			,15,15,,.T.,,,,.T.,.F.)
		oFont16		:= TFont():New("Arial"			,16,16,,.F.,,,,.T.,.F.)
		oFont16n	:= TFont():New("Arial"			,16,16,,.T.,,,,.T.,.F.)
		oFont17		:= TFont():New("Arial"			,17,17,,.F.,,,,.T.,.F.)
		oFont17n	:= TFont():New("Arial"			,17,17,,.T.,,,,.T.,.F.)
		oFont18		:= TFont():New("Arial"			,18,18,,.F.,,,,.T.,.F.)
		oFont18n	:= TFont():New("Arial"			,18,18,,.T.,,,,.T.,.F.)

	ElseIf _nFonte == 2
		oFont05 	:= TFont():New("Times New Roman"			,05,05,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont05n	:= TFont():New("Times New Roman"			,05,05,,.T.,,,,.T.,.F.)
		oFont06 	:= TFont():New("Times New Roman"			,06,06,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont06n	:= TFont():New("Times New Roman"			,06,06,,.T.,,,,.T.,.F.)
		oFont07 	:= TFont():New("Times New Roman"			,07,07,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont07n	:= TFont():New("Times New Roman"			,07,07,,.T.,,,,.T.,.F.)
		oFont08 	:= TFont():New("Times New Roman"			,08,08,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont08n	:= TFont():New("Times New Roman"			,08,08,,.T.,,,,.T.,.F.)
		oFont10 	:= TFont():New("Times New Roman"			,10,10,,.F.,,,,.T.,.F.)
		oFont10n	:= TFont():New("Times New Roman"			,10,10,,.T.,,,,.T.,.F.)
		oFont11 	:= TFont():New("Times New Roman"			,11,11,,.F.,,,,.T.,.F.)
		oFont11n	:= TFont():New("Times New Roman"			,11,11,,.T.,,,,.T.,.F.)
		oFont12 	:= TFont():New("Times New Roman"			,12,12,,.F.,,,,.T.,.F.)
		oFont12n	:= TFont():New("Times New Roman"			,12,12,,.T.,,,,.T.,.F.)
		oFont13 	:= TFont():New("Times New Roman"			,13,13,,.F.,,,,.T.,.F.)
		oFont13n	:= TFont():New("Times New Roman"			,13,13,,.T.,,,,.T.,.F.)
		oFont14		:= TFont():New("Times New Roman"			,14,14,,.F.,,,,.T.,.F.)
		oFont14n	:= TFont():New("Times New Roman"			,14,14,,.T.,,,,.T.,.F.)
		oFont15		:= TFont():New("Times New Roman"			,15,15,,.F.,,,,.T.,.F.)
		oFont15n	:= TFont():New("Times New Roman"			,15,15,,.T.,,,,.T.,.F.)
		oFont16		:= TFont():New("Times New Roman"			,16,16,,.F.,,,,.T.,.F.)
		oFont16n	:= TFont():New("Times New Roman"			,16,16,,.T.,,,,.T.,.F.)
		oFont17		:= TFont():New("Times New Roman"			,17,17,,.F.,,,,.T.,.F.)
		oFont17n	:= TFont():New("Times New Roman"			,17,17,,.T.,,,,.T.,.F.)
		oFont18		:= TFont():New("Times New Roman"			,18,18,,.F.,,,,.T.,.F.)
		oFont18n	:= TFont():New("Times New Roman"			,18,18,,.T.,,,,.T.,.F.)

	ElseIf _nFonte == 3
		oFont05 	:= TFont():New("Calibri"			,05,05,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont05n	:= TFont():New("Calibri"			,05,05,,.T.,,,,.T.,.F.)
		oFont06 	:= TFont():New("Calibri"			,06,06,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont06n	:= TFont():New("Calibri"			,06,06,,.T.,,,,.T.,.F.)
		oFont07 	:= TFont():New("Calibri"			,07,07,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont07n	:= TFont():New("Calibri"			,07,07,,.T.,,,,.T.,.F.)
		oFont08 	:= TFont():New("Calibri"			,08,08,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont08n	:= TFont():New("Calibri"			,08,08,,.T.,,,,.T.,.F.)
		oFont10 	:= TFont():New("Calibri"			,10,10,,.F.,,,,.T.,.F.)
		oFont10n	:= TFont():New("Calibri"			,10,10,,.T.,,,,.T.,.F.)
		oFont11 	:= TFont():New("Calibri"			,11,11,,.F.,,,,.T.,.F.)
		oFont11n	:= TFont():New("Calibri"			,11,11,,.T.,,,,.T.,.F.)
		oFont12 	:= TFont():New("Calibri"			,12,12,,.F.,,,,.T.,.F.)
		oFont12n	:= TFont():New("Calibri"			,12,12,,.T.,,,,.T.,.F.)
		oFont13 	:= TFont():New("Calibri"			,13,13,,.F.,,,,.T.,.F.)
		oFont13n	:= TFont():New("Calibri"			,13,13,,.T.,,,,.T.,.F.)
		oFont14		:= TFont():New("Calibri"			,14,14,,.F.,,,,.T.,.F.)
		oFont14n	:= TFont():New("Calibri"			,14,14,,.T.,,,,.T.,.F.)
		oFont15		:= TFont():New("Calibri"			,15,15,,.F.,,,,.T.,.F.)
		oFont15n	:= TFont():New("Calibri"			,15,15,,.T.,,,,.T.,.F.)
		oFont16		:= TFont():New("Calibri"			,16,16,,.F.,,,,.T.,.F.)
		oFont16n	:= TFont():New("Calibri"			,16,16,,.T.,,,,.T.,.F.)
		oFont17		:= TFont():New("Calibri"			,17,17,,.F.,,,,.T.,.F.)
		oFont17n	:= TFont():New("Calibri"			,17,17,,.T.,,,,.T.,.F.)
		oFont18		:= TFont():New("Calibri"			,18,18,,.F.,,,,.T.,.F.)
		oFont18n	:= TFont():New("Calibri"			,18,18,,.T.,,,,.T.,.F.)

	ElseIf _nFonte == 4
		oFont05 	:= TFont():New("Verdana"			,05,05,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont05n	:= TFont():New("Verdana"			,05,05,,.T.,,,,.T.,.F.)
		oFont06 	:= TFont():New("Verdana"			,06,06,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont06n	:= TFont():New("Verdana"			,06,06,,.T.,,,,.T.,.F.)
		oFont07 	:= TFont():New("Verdana"			,07,07,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont07n	:= TFont():New("Verdana"			,07,07,,.T.,,,,.T.,.F.)
		oFont08 	:= TFont():New("Verdana"			,08,08,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont08n	:= TFont():New("Verdana"			,08,08,,.T.,,,,.T.,.F.)
		oFont10 	:= TFont():New("Verdana"			,10,10,,.F.,,,,.T.,.F.)
		oFont10n	:= TFont():New("Verdana"			,10,10,,.T.,,,,.T.,.F.)
		oFont11 	:= TFont():New("Verdana"			,11,11,,.F.,,,,.T.,.F.)
		oFont11n	:= TFont():New("Verdana"			,11,11,,.T.,,,,.T.,.F.)
		oFont12 	:= TFont():New("Verdana"			,12,12,,.F.,,,,.T.,.F.)
		oFont12n	:= TFont():New("Verdana"			,12,12,,.T.,,,,.T.,.F.)
		oFont13 	:= TFont():New("Verdana"			,13,13,,.F.,,,,.T.,.F.)
		oFont13n	:= TFont():New("Verdana"			,13,13,,.T.,,,,.T.,.F.)
		oFont14		:= TFont():New("Verdana"			,14,14,,.F.,,,,.T.,.F.)
		oFont14n	:= TFont():New("Verdana"			,14,14,,.T.,,,,.T.,.F.)
		oFont15		:= TFont():New("Verdana"			,15,15,,.F.,,,,.T.,.F.)
		oFont15n	:= TFont():New("Verdana"			,15,15,,.T.,,,,.T.,.F.)
		oFont16		:= TFont():New("Verdana"			,16,16,,.F.,,,,.T.,.F.)
		oFont16n	:= TFont():New("Verdana"			,16,16,,.T.,,,,.T.,.F.)
		oFont17		:= TFont():New("Verdana"			,17,17,,.F.,,,,.T.,.F.)
		oFont17n	:= TFont():New("Verdana"			,17,17,,.T.,,,,.T.,.F.)
		oFont18		:= TFont():New("Verdana"			,18,18,,.F.,,,,.T.,.F.)
		oFont18n	:= TFont():New("Verdana"			,18,18,,.T.,,,,.T.,.F.)

	ElseIf _nFonte == 5
		oFont05 	:= TFont():New("Tahoma"			,05,05,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont05n	:= TFont():New("Tahoma"			,05,05,,.T.,,,,.T.,.F.)
		oFont06 	:= TFont():New("Tahoma"			,06,06,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont06n	:= TFont():New("Tahoma"			,06,06,,.T.,,,,.T.,.F.)
		oFont07 	:= TFont():New("Tahoma"			,07,07,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont07n	:= TFont():New("Tahoma"			,07,07,,.T.,,,,.T.,.F.)
		oFont08 	:= TFont():New("Tahoma"			,08,08,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont08n	:= TFont():New("Tahoma"			,08,08,,.T.,,,,.T.,.F.)
		oFont10 	:= TFont():New("Tahoma"			,10,10,,.F.,,,,.T.,.F.)
		oFont10n	:= TFont():New("Tahoma"			,10,10,,.T.,,,,.T.,.F.)
		oFont11 	:= TFont():New("Tahoma"			,11,11,,.F.,,,,.T.,.F.)
		oFont11n	:= TFont():New("Tahoma"			,11,11,,.T.,,,,.T.,.F.)
		oFont12 	:= TFont():New("Tahoma"			,12,12,,.F.,,,,.T.,.F.)
		oFont12n	:= TFont():New("Tahoma"			,12,12,,.T.,,,,.T.,.F.)
		oFont13 	:= TFont():New("Tahoma"			,13,13,,.F.,,,,.T.,.F.)
		oFont13n	:= TFont():New("Tahoma"			,13,13,,.T.,,,,.T.,.F.)
		oFont14		:= TFont():New("Tahoma"			,14,14,,.F.,,,,.T.,.F.)
		oFont14n	:= TFont():New("Tahoma"			,14,14,,.T.,,,,.T.,.F.)
		oFont15		:= TFont():New("Tahoma"			,15,15,,.F.,,,,.T.,.F.)
		oFont15n	:= TFont():New("Tahoma"			,15,15,,.T.,,,,.T.,.F.)
		oFont16		:= TFont():New("Tahoma"			,16,16,,.F.,,,,.T.,.F.)
		oFont16n	:= TFont():New("Tahoma"			,16,16,,.T.,,,,.T.,.F.)
		oFont17		:= TFont():New("Tahoma"			,17,17,,.F.,,,,.T.,.F.)
		oFont17n	:= TFont():New("Tahoma"			,17,17,,.T.,,,,.T.,.F.)
		oFont18		:= TFont():New("Tahoma"			,18,18,,.F.,,,,.T.,.F.)
		oFont18n	:= TFont():New("Tahoma"			,18,18,,.T.,,,,.T.,.F.)

	Else
		oFont05 	:= TFont():New("Courier New"			,05,05,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont05n	:= TFont():New("Courier New"			,05,05,,.T.,,,,.T.,.F.)
		oFont06 	:= TFont():New("Courier New"			,06,06,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont06n	:= TFont():New("Courier New"			,06,06,,.T.,,,,.T.,.F.)
		oFont07 	:= TFont():New("Courier New"			,07,07,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont07n	:= TFont():New("Courier New"			,07,07,,.T.,,,,.T.,.F.)
		oFont08 	:= TFont():New("Courier New"			,08,08,,.F.,,,,.T.,.F.)		//Configura as fontes
		oFont08n	:= TFont():New("Courier New"			,08,08,,.T.,,,,.T.,.F.)
		oFont10 	:= TFont():New("Courier New"			,10,10,,.F.,,,,.T.,.F.)
		oFont10n	:= TFont():New("Courier New"			,10,10,,.T.,,,,.T.,.F.)
		oFont11 	:= TFont():New("Courier New"			,11,11,,.F.,,,,.T.,.F.)
		oFont11n	:= TFont():New("Courier New"			,11,11,,.T.,,,,.T.,.F.)
		oFont12 	:= TFont():New("Courier New"			,12,12,,.F.,,,,.T.,.F.)
		oFont12n	:= TFont():New("Courier New"			,12,12,,.T.,,,,.T.,.F.)
		oFont13 	:= TFont():New("Courier New"			,13,13,,.F.,,,,.T.,.F.)
		oFont13n	:= TFont():New("Courier New"			,13,13,,.T.,,,,.T.,.F.)
		oFont14		:= TFont():New("Courier New"			,14,14,,.F.,,,,.T.,.F.)
		oFont14n	:= TFont():New("Courier New"			,14,14,,.T.,,,,.T.,.F.)
		oFont15		:= TFont():New("Courier New"			,15,15,,.F.,,,,.T.,.F.)
		oFont15n	:= TFont():New("Courier New"			,15,15,,.T.,,,,.T.,.F.)
		oFont16		:= TFont():New("Courier New"			,16,16,,.F.,,,,.T.,.F.)
		oFont16n	:= TFont():New("Courier New"			,16,16,,.T.,,,,.T.,.F.)
		oFont17		:= TFont():New("Courier New"			,17,17,,.F.,,,,.T.,.F.)
		oFont17n	:= TFont():New("Courier New"			,17,17,,.T.,,,,.T.,.F.)
		oFont18		:= TFont():New("Courier New"			,18,18,,.F.,,,,.T.,.F.)
		oFont18n	:= TFont():New("Courier New"			,18,18,,.T.,,,,.T.,.F.)

	EndIf

Return

/*CABECALHO */
Static Function Cabec()
Local	nLin1		:= 0010
Local 	nLin2		:= 0580
Local 	nLin3		:= 0010
Local 	nLin7		:= nLin2 - (nLin3)
Local 	aRet		:= Array(5,0)

cLogotipo := "lgrl0111.bmp"
oPrn:SayBitMap( nLin1 += 0005	, 0480, cLogotipo, 85, 34)
oPrn:SayAlign ( nLin1 += 0005	, 0015	, "REGISTRO DE OCORRÊNCIA"	 , oFont18n,nLin7,,,0,)

oPrn:line(nLin1 += 20, nLin3, nLin1 += 10, nLin2 )

nLin1 += 05

Return(nLin1)



Static Function Buscar2(cNumOrc,cProd)
Local cCRLF		:= CRLF
Local Z05DADOS 	:= GetNextAlias()
Local cQry		:= ""
Local aRet		:= {}
Local aTecido	:= {}
Local aCor		:= {}

cQry:="SELECT * 						"+cCRLF
cQry+="FROM Z05010						"+cCRLF
cQry+="WHERE	Z05_NUMORC = '"+ Alltrim(cNumOrc) 	+"' "+cCRLF
cQry+="		AND Z05_PRODUT = '"+ Alltrim(cProd) 	+"'	"+cCRLF
cQry+="		AND D_E_L_E_T_ = ''			"+cCRLF
cQry+="		AND Z05_IDENT IN ('TECIDO    ','CORTECIDO ')

//Conout(cQry)

TCQuery cQry NEW ALIAS 'Z05DADOS'

DBSelectArea("Z05DADOS")
Z05DADOS->(DBGoTop())

nPGVen := 0

While !Z05DADOS->(Eof())

	If Alltrim(Z05DADOS->Z05_IDENT) == 'TECIDO'
		AAdd( aTecido, Alltrim(Z05DADOS->Z05_IDENT))
		AAdd( aTecido, Alltrim(Z05DADOS->Z05_VALOR))
		AAdd( aRet, aTecido)
	EndIf

	If Alltrim(Z05DADOS->Z05_IDENT) == 'CORTECIDO'
		AAdd( aCor, Alltrim(Z05DADOS->Z05_IDENT))
		AAdd( aCor, Alltrim(Z05DADOS->Z05_VALOR))

		AAdd( aRet, aCor)
	EndIf

	Z05DADOS->(DbSkip())
EndDo

If Empty(Z05DADOS->Z05_IDENT)
	AAdd( aTecido, 'TECIDO')
	AAdd( aTecido, 'NÃO ESPECIFICADO')
	AAdd( aRet, aTecido)

	AAdd( aCor, 'CORTECIDO')
	AAdd( aCor, 'NÃO ESPECIFICADO')

	AAdd( aRet, aCor)

EndIf

Z05DADOS->(DbCloseArea())

Return(aRet)


