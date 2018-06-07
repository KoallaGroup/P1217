#INCLUDE "PROTHEUS.CH"
#INCLUDE 'FWPrintSetup.ch'
#INCLUDE "RPTDEF.CH"

/*--------------------Teste FWMSPrinter-------------------------*/

User Function TSTFWMS()

Local aArea := Getarea()

Local oFont09  := TFont():New("Courier New", 9, 07, .T., .F.)
Local oFont10N := TFont():New("Times New Roman", 9, 08, .T., .T.)
Local nLargTxt := 900 // largura em pixel para alinhamento da funcao sayalign
Local oPrint
Local lAdjustToLegacy := .F. // Inibe legado de resolução com a TMSPrinter
Local nLin            := 03
Local lNewPage        := .T. // controla pagina nova - salto de pagina
Local cRelatorio		 := "Teste FWMSPrinter"

// Query principal do relatório
GeraDados()

If !TMP->(Eof())
	oPrint := FWMsPrinter():New( cRelatorio, IMP_PDF, lAdjustToLegacy,, .T.,,, "PDF" ) 
	
	oPrint:SetResolution(78) // Tamanho estipulado
	oPrint:SetLandscape()
	oPrint:SetPaperSize(0, 210, 297 ) // Tamanho da folha 
	oPrint:SetMargin(10,10,10,10)
	
	While !TMP->(Eof())
		If lNewpage  // Nova Página - Cabecalho
		   	Cabecalho(@nLin, oPrint, oFont10N, nLargTxt)
		    	
		   	lNewPage := .F.
		Endif
	
		oPrint:SayAlign(nLin, 010, TMP->C5_TPFRETE, oFont09, 400, 200, CLR_BLACK, 0, 0)
		oPrint:SayAlign(nLin, 100, TMP->C5_FILIAL, oFont09, 400, 200, CLR_BLACK, 0, 0)
		oPrint:SayAlign(nLin, 170, TMP->C5_NUM, oFont09, 400, 200, CLR_BLACK, 0, 0)
		oPrint:SayAlign(nLin, 250, AllTrim(TransForm(TMP->C6_VALOR,"@E 9,999,999.99")), oFont09, 400, 200, CLR_BLACK, 0, 0)
		oPrint:SayAlign(nLin, 320, TMP->C5_CLIENTE, oFont09, 400, 200, CLR_BLACK, 0, 0)
		oPrint:SayAlign(nLin, 450, Posicione("SA1",1,xFilial("SA1")+TMP->C5_CLIENTE,"A1_NOME"), oFont09, 400, 200, CLR_BLACK, 0, 0)
		oPrint:SayAlign(nLin, 530, TMP->C5_EMISSAO, oFont09, 400, 200, CLR_BLACK, 0, 0)
		oPrint:SayAlign(nLin, 580, TMP->C5_TIPO, oFont09, 400, 200, CLR_BLACK, 0, 0)
		oPrint:SayAlign(nLin, 640, TMP->C5_CONDPAG, oFont09, 400, 200, CLR_BLACK, 0, 0)
		oPrint:SayAlign(nLin, 750, Posicione("SA2",1,xFilial("SA2")+TMP->C5_VEND1,"A2_NOME"), oFont09, 400, 200, CLR_BLACK, 0, 0)
		
		nLin += 15		
				
		TMP->(DbSkip())
	End
		
	oPrint:Preview()			
Endif
	
TMP->(DbCloseArea())	
RestArea(aArea)

Return



/*--------------------GeraDados-------------------------*/

Static Function GeraDados()

Local aArea 	  := GetArea() 
Local TMP		  := GetNextAlias()
Local cQuery	  := " "
	
// Query para buscar os dados dos pedidos
cQuery:=''
cQuery:= " SELECT CASE C5_TPFRETE WHEN 'C' THEN 'EMITENTE' WHEN 'F' THEN 'DESTINATARIO' WHEN 'T' THEN 'TERCEIROS' ELSE 'SEM FRETE' END C5_TPFRETE, "
cQuery+= " C5_FILIAL, C5_NUM, C6_VALOR, C5_CLIENTE, C5_EMISSAO, C5_TIPO, C5_CONDPAG, C5_VEND1 "
cQuery+= " FROM "+RetSqlName("SC5")+" SC5, "+RetSqlName("SC6")+" SC6 "
cQuery+= " WHERE C5_NUM = C6_NUM "
cQuery+= " ORDER BY C5_EMISSAO "

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),"TMP",.T.,.T.)

RestArea(aArea)

Return


/*--------------------Imprime Cabecalho-------------------------*/

Static Function Cabecalho(nLin, oPrint, oFont10N, nLargTxt)
	oPrint:StartPage() // Inicia uma nova página  
	nLin := 03
			
   	oPrint:Say(nlin, 001, dtoc(dDataBase), oFont10N)
   	oPrint:SayAlign(nLin, 01, dtoc(dDataBase), oFont10N, 400, 200, CLR_BLACK, 1, 0) 
	oPrint:SayAlign(nLin, 01, dtoc(dDataBase), oFont10N, 400, 200, CLR_BLACK, 2, 0) 		
   	nLin += 15
   	
   	oPrint:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1") 
		    	
   	nLin += 12
		    	
   	// Cabecalho
   	oPrint:Say(nlin, 010, "Tipo Frete", oFont10N)
   	oPrint:Say(nlin, 100, "Filial", oFont10N)
   	oPrint:Say(nlin, 170, "Número", oFont10N)
   	oPrint:Say(nlin, 250, "Valor", oFont10N)
   	oPrint:Say(nlin, 320, "Cliente", oFont10N)
   	oPrint:Say(nlin, 450, "N. Cliente", oFont10N)
   	oPrint:Say(nlin, 530, "Emissão", oFont10N)
   	oPrint:Say(nlin, 580, "Tipo", oFont10N)
   	oPrint:Say(nlin, 640, "Cond. Pagamento", oFont10N)
   	oPrint:Say(nlin, 750, "Vendedor", oFont10N)
   	
   	nLin += 12
		    	
   	oPrint:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1") 
		    	
   	nLin += 12
   	
Return