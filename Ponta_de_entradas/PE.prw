#include 'protheus.ch'
#include 'parmtype.ch'

User Function GPE10BTN()Return {'S4WB005N',{||MsgStop('GPE10BTN')},'Botao GPE10BTN','Btn GPE10BTN'}Exemplo 2: Adicionar mais de um botão na barra de ferramentas:User Function GPE10BTN() Local aRet := {}aAdd( aRet, { "S4WB005N", {|| U_teste001() }, "Botao GPE10BTN", "Btn GPE10BTN" } )aAdd( aRet, { "S4WB005N2", {|| U_teste001() }, "Botao GPE10BTN2", "Btn GPE10BTN2" } )Return  (aRet)