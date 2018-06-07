#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "protheus.ch"
User Function Myprinter2()
Local lAdjustToLegacy := .F.
Local lDisableSetup := .T.
Local cLocal := "c:\"
Local oPrinter
Private nLin := 0

/*
oPrinter := FWMSPrinter():New("exemplo.rel", IMP_PDF, lAdjustToLegacy,cLocal, lDisableSetup, , , , , , .F., )

oPrinter:Box(0010,0010, 0795, 0580,"-4")

oTFont := TFont():New('Courier new',,-16,.T.)

oPrinter:SetFont(oTFont)


oPrinter:line(nLin += 30, 0010, nLin += 30, 0580 )

//oPrn:line(nLin += 07, 0010, nLin += 07, 0580 )


oPrinter:Say( nLin, 30, "Linha número 30")


oPrinter:Say( 20, 30, "Teste de Linha:")



oPrinter:line(150, 0010, 150, 0580 )


oPrinter:Setup()
 */

oPrinter := FWMSPrinter():New("Danfe.rel", IMP_PDF, lAdjustToLegacy, , lDisableSetup)// Ordem obrigátoria de configuração do relatório

oPrinter:SetResolution(72)
oPrinter:SetPortrait()
oPrinter:SetPaperSize(DMPAPER_A4) 
oPrinter:SetMargin(60,60,60,60) // nEsquerda, nSuperior, nDireita, nInferior 
oPrinter:cPathPDF := "c:\" // Caso seja utilizada impressão em IMP_PDF

oPrinter:Say( 20, 30, "Teste sem Setup")


oPrinter:Preview()

Return


