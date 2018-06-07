#include 'protheus.ch'
#include 'parmtype.ch'

Function U_tstTxtW()
  Local lAdjustToLegacy := .F.
  Local lDisableSetup  := .T.
  Local oPrinter
  Local cLocal := "\crystal"
  Local nX
  
 // RpcSetEnv("99","01")
  
  oPrinter := FWMSPrinter():New("TstTxtWidth.rel", IMP_PDF, lAdjustToLegacy,cLocal ,lDisableSetup, , , , , , .F., )
  oPrinter:SetResolution(72)
  oPrinter:SetPortrait()
  oPrinter:SetPaperSize(DMPAPER_A4)
  oPrinter:SetMargin(0,0,0,0)
  oPrinter:lserver	:= .T.
  oPrinter:cPathPDF := "\teste1\" // Caso seja utilizada impressão em IMP_PDF

  oFont1 := TFont():New('Courier new',,-12,.T.)
  
  oPrinter:StartPage()
  
  //nWidht := oPrinter:GetTextWidth( "Teste", oFont1 )
  nWidht := CalcFieldSize("C",,,,"Teste",oFont1)
  oPrinter:Say( 20, 10, "Teste", oFont1 )
  oPrinter:Say( 30, 10 + nWidht, "Teste de nWidht:  " + cvaltochar(nWidht), oFont1 )
  
  oPrinter:EndPage()

  oPrinter:Print()
Return 