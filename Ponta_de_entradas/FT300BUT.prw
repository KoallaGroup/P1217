#include 'protheus.ch'
#include 'parmtype.ch'

User Function FT300BUT()

Local aBut := {}

aAdd(aBut,{"TesteVisual","",{|| MsgAlert("Teste01")},"ViewVisual",,})
aAdd(aBut,{"TesteAltera","",{|| MsgAlert("Teste02")},"ViewAltera",, })
aAdd(aBut,{"TesteFull", "",  {|| MsgAlert("Teste03")},"ViewAltera",, })

Return( aBut )