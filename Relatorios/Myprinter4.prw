#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "protheus.ch"
User Function printer4()
Local lAdjustToLegacy := .F.
Local lDisableSetup := .T.
Local cLocal := "\SPOOL"
Local nLargPag
Local oPrinter
Private nLin := 0
Private nWidht



  oPrinter := FWMSPrinter():New("exemplo 2.rel", IMP_SPOOL , lAdjustToLegacy,cLocal, lDisableSetup, , , , , , .F., )
  oPrinter:SetResolution(72)
  oPrinter:SetPortrait()
  oPrinter:SetPaperSize(DMPAPER_A4)
  oPrinter:SetMargin(0,0,0,0)
  oPrinter:lserver	:= .T.
  oPrinter:cPathPDF := "\teste1\" // Caso seja utilizada impressão em IMP_PDF

  oFont1 := TFont():New('Arial',,-12,.T.)
  
  oPrinter:StartPage()
  
 /* nLargPag:= oPrinter:nHorzSize()
  
  oPrinter:Line(130,0010,150,nLargPag) */
  
  
  oPrinter:line(150, 0010, 150, 0580 )
  
  
  //nWidht := oPrinter:GetTextWidth( "Teste", oFont1 )
  nWidht := CalcFieldSize("C",,,,"Teste",oFont1)
  oPrinter:Say( 20, 10, "Teste", oFont1 )
  oPrinter:Say( 30, 10+ nWidht, "Teste de nWidht:  " + cvaltochar(nWidht), oFont1 )
  
  oPrinter:EndPage()

  oPrinter:Print()

	

if oPrinter:nModalResult == PD_OK
oPrinter:Preview()
EndIf
Return