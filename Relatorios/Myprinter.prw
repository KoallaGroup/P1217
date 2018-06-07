#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "protheus.ch"
User Function Myprinter()
Local lAdjustToLegacy := .F.
Local lDisableSetup := .T.
Local cLocal := "\crystal"
Local oPrinter
Private nLin := 0
Private nWidht



oPrinter := FWMSPrinter():New("exemplo 2.rel", IMP_PDF, lAdjustToLegacy,cLocal, lDisableSetup, , , , , , .F., )

oTFont := TFont():New('Courier new',,16,.T.)

oPrinter:SetFont(oTFont)
 

//oSetup        := FWPrintSetup():New (PD_ISTOTVSPRINTER,'teste')

oPrinter:Box(0010,0010, 0795, 0580,"-4")


/*oSetup:SetPropert(PD_PRINTTYPE   , 6)
oSetup:SetPropert(PD_ORIENTATION , 1)
oSetup:SetPropert(PD_DESTINATION , 1)
oSetup:SetPropert(PD_MARGIN      , {20,20,20,20})



oSetup:SetUserParms({|| Pergunte("MTR797", .T.)}) */
                                                                                                                
oPrinter:line(nLin += 30, 0010, nLin, 0580 )

//oPrn:line(nLin += 07, 0010, nLin += 07, 0580 )


/*oPrinter:SayAlign( nLin, 0, "Centralizado",,, , , 2, 0 )

oPrinter:SayAlign( 40, 0, "Direita",,, , , 1, 1 )

oPrinter:SayAlign( 20, 30, "Teste de Linha:") */

nWidht := oPrinter:GetTextWidth( "Teste", oTFont)

oPrinter:Say( 20, 10, "Teste de Linha:  "+cvaltochar(nWidht))

oPrinter:Say( 50, nWidht, "Teste de Linha:  "+cvaltochar(nWidht))

oPrinter:line(150, 0010, 150, 0580 )


//oPrinter:Setup()



//oPrinter:cPathPDF := "\crystal"
oPrinter:Print()
oPrinter:EndPage()
	
//CpyS2T('\crystal\exemplo.pdf',"C:\Users\rodrigo.gsoares.SP01\Desktop",.T.) //
//oSetup:end()

if oPrinter:nModalResult == PD_OK
oPrinter:Preview()
EndIf
Return