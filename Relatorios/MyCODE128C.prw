//#include 'protheus.ch'
//#include 'parmtype.ch'
//#Include "RPTDEF.CH"
//#INCLUDE "TBICONN.CH"
//
//user function MyCODE128C()
//
//Local oPrinter
//
//
//PREPARE ENVIRONMENT EMPRESA "T1" FILIAL "01"
//
//oPrinter      := FWMSPrinter():New('teste',6,.F.,,.T.,,,,,.F.)
//
//oPrinter:Setup()
//oPrinter:setDevice(IMP_PDF)
//oPrinter:cPathPDF :="C:\"
//oPrinter:Say(10,0,"Teste para Code128C")
//oPrinter:Code128c(500, 10, '1234567', 50)
//oPrinter:EndPage()
//oPrinter:Preview()
//
//FreeObj(oPrinter)
//
//oPrinter := Nil
//RESET ENVIRONMENT
//
//	
//return


#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "protheus.ch"
User Function MyCod128()
Local lAdjustToLegacy := .F.
Local lDisableSetup := .T.
Local cLocal := "\spool"
Local cCodEAN :=      "123456789012"
Local oPrinter
oPrinter := FWMSPrinter():New("exemplo.rel", IMP_PDF, lAdjustToLegacy,cLocal, lDisableSetup, , , , , , .F., )
oPrinter:Say( 150, 30, "Código de barras CODE128:")
oPrinter:FWMSBAR("EAN13" /*cTypeBar*/,5/*nRow*/ ,1/*nCol*/ ,cCodEAN  /*cCode*/,oPrinter/*oPrint*/,/*lCheck*/,/*Color*/,/*lHorz*/, /*nWidth*/,/*nHeigth*/,/*lBanner*/,/*cFont*/,/*cMode*/,.F./*lPrint*/,/*nPFWidth*/,/*nPFHeigth*/,/*lCmtr2Pix*/)
oPrinter:Code128c(170/*nRow*/ ,30/*nCol*/, "123456789011010"/*cCode*/,1/*nWidth*/,50/*nHeigth*/,.T./*lSay*/,,400)

oPrinter:Setup()
if oPrinter:nModalResult == PD_OK
oPrinter:Preview()
EndIf
Return