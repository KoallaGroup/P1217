#include 'protheus.ch'
#include 'parmtype.ch'

user function tlret()

Local oGet2
Local nGet2 := 0

Local cTitulo := 'Digitar teste'
Local lHasButton := .T.

DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 080,300 PIXEL

oGet2 := TGet():New( 020, 009, { | u | If( PCount() == 0, nGet2, nGet2 := u ) },oDlg, ;
060, 010, "@E 999.99",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"nGet2",,,,lHasButton  )


oTButton1 := TButton():New( 18, 100, "Gravar",oDlg,{||GrvTstZb0()}, 40,10,,,.F.,.T.,.F.,,.F.,,,.F. ) 



ACTIVATE MSDIALOG oDlg CENTERED
	
return nGet2

Static Function GrvTstZb0()

If MsgYesNo("Deseja gravar informação?")

Else
	RollBackSX8()
EndIf

return