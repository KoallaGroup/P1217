#include 'protheus.ch'
#include 'parmtype.ch'

user function MA630BUT()

Local nOpcao  := PARAMIXB[1] //Op��o escolhida (Visualiza��o, Inclus�o, Altera��o ou Exclus�o

Local aBotoes := aClone(PARAMIXB[2]) //Array com bot�es caso exista

aAdd(aBotoes,{"TesteVisual","",{|| MsgAlert("Teste01")},"ViewVisual",,})


Return(aClone(aBotoes))