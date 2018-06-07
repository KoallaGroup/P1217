#include 'protheus.ch'
#include 'parmtype.ch'

user function A2CGC() 



local oMdlSA2 := fwModelActive()
local oSa2Mast := oMdlSA2:getModel("SA2MASTER")
//local aAreaCC2 := CC2->(getArea())
local lRet := .t.

/*dbSelectArea("CC2")

if (CC2->(dbSeek(xFilial("CC2") + oSa2Mast:getValue("A2_EST") + oSa2Mast:getValue("A2_COD_MUN"))))
oSa2Mast:loadValue("A2_MUN", CC2->CC2_MUN)





else
msgAlert("Codigo de municipio nao possui desc. de municipio cadastrado")

lRet := .f.
endIf

restArea(aAreaCC2)*/



return .t.
