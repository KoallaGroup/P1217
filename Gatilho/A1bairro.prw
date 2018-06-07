#include 'protheus.ch'
#include 'parmtype.ch'

user function A1bairro()


Local cRet := M->A1_BAIRRO
Local cRet2 := M->A1_BAIRROC

IF EMPTY(cRet2)

return cRet

Else

Return (cRet2)

EndIF