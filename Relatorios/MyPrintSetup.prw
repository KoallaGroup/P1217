#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "protheus.ch"

User Function MyPrintSetup()

//Local lRetAux        := .T.
Local oDANFE        := Nil    //objeto da classe FwMsPrinter
Local oSetup        := Nil    //objeto da classe FwPrintSetup
Local nFlags        := 0    //indica quais opcoes estarao disponiveis na configuracao da impressao
Local nDestination    := 1    //SERVER
Local nOrientation    := 1    //PORTRAIT
Local nPrintType    := 6    //PDF
Local cLocal := "\spool"
Local cPathInServer := "/crystal/"
Private nLin := 0


nFlags := PD_ISTOTVSPRINTER + PD_DISABLEPAPERSIZE + PD_DISABLEPREVIEW + PD_DISABLEMARGIN // indica quais opcoes estarao disponiveis

oSetup := FWPrintSetup():New(nFlags, "DANFE")

oSetup:SetPropert(PD_PRINTTYPE   , nPrintType)
oSetup:SetPropert(PD_ORIENTATION , nOrientation)
oSetup:SetPropert(PD_DESTINATION , nDestination)
oSetup:SetPropert(PD_MARGIN      , {60,60,60,60})
oSetup:SetPropert(PD_PAPERSIZE   , 2)
oSetup:CQTDCOPIA := "01"

oSetup:SetUserParms({|| Pergunte("MTR797", .T.)}) //Pergunta do SX1

//
// FWMsPrinter
//
oPrinter := FWMSPrinter():New("exemplo.rel", IMP_PDF, .F. /*lAdjustToLegacy*/, cLocal, .T.)

oPrinter:SetCopies( Val(oSetup:CQTDCOPIA) )

oPrinter:line(nLin += 30, 0010, nLin, 0580 )

//oPrn:line(nLin += 07, 0010, nLin += 07, 0580 )


oPrinter:Say( nLin, 30, "Linha número 30")


oPrinter:Say( 20, 30, "Teste de Linha:")



oPrinter:line(150, 0010, 150, 0580 )


// Interface para o usuario configurar os parametros de impressao
oSetup:Activate() == PD_OK


oPrinter:Preview()


Return