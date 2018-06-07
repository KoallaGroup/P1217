#include 'protheus.ch'
#include 'parmtype.ch'

user function MA630BUT()

Local nOpcao  := PARAMIXB[1] //Opção escolhida (Visualização, Inclusão, Alteração ou Exclusão

Local aBotoes := aClone(PARAMIXB[2]) //Array com botões caso exista

aAdd(aBotoes,{"TesteVisual","",{|| MsgAlert("Teste01")},"ViewVisual",,})


Return(aClone(aBotoes))