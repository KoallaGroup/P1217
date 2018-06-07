#include 'protheus.ch'
#include 'parmtype.ch'

User Function GPE10BTN()


Local aRet := {}

aAdd( aRet, { "TELA MVC 1", {|| U_COMP011_MVC() }, "Botao TELA MVC 1", "Botao TELA MVC 1" } )
aAdd( aRet, { "TELA MVC 2", {|| U_COMP011_MVC1() },"Botao TELA MVC 2", "Botao TELA MVC 2" } )

Return  (aRet)