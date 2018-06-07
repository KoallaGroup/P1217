#include "protheus.ch"
#include "protheus.ch"
#include "FWPrintSetup.ch"
#include "tbiconn.ch"

//#DEFINE IMP_SPOOL

User Function TstFonte()

Local lAdjustToLegacy := .F.
Local lDisableSetup  := .T.
Local oPrinter
//Local cLocal := "W:\tstpdf"

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"

/*courier new - arial - arial black - times new roman - andale mono*/

oTFont 	:= TFont():New('Courier new',,-30,.T.,.T.,,,,,.T.,.T.)
oTFont1 	:= TFont():New('Courier new',,-16,.T.,.T.,,,,,.T.,.T.)
oTFont2 	:= TFont():New('Arial',,-16,.T.)
oTFont3 	:= TFont():New('Arial Black',,-16,.T.)
oTFont4 	:= TFont():New('Times New Roman',,-16,.T.)
oTFont6 	:= TFont():New('Andale Mono',,-16,.T.)
oTFont7 	:= TFont():New('Arial Narrow',,-16,.T.)



oPrinter := FWMSPrinter():New("exemplo.rel", 6, lAdjustToLegacy, , lDisableSetup, , , , , , .F., )

oPrinter:CPATHPDF := "\system\"

oPrinter:StartPage()
oPrinter:Say(030, 010, "TESTES DAS FONTES"	,	oTFont)
oPrinter:Say(060, 010, "FONTE COURIER NEW"	,	oTFont1)
oPrinter:Say(090, 010, "FONTE ARIAL"	,	oTFont2)
oPrinter:Say(120, 010, "FONTE ARIAL BLACK"	,	oTFont3)
oPrinter:Say(150, 010, "FONTE TIMES NEW ROMAN"	,	oTFont4)
oPrinter:Say(180, 010, "FONTE ANDALE MONO"	,	oTFont6)
oPrinter:Say(210, 010, "FONTE Arial Narrow"	,	oTFont7)
oPrinter:EndPage()

oPrinter:Setup()


oPrinter:Preview()

//RESET ENVIRONMENT

Return