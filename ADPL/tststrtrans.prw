#include 'protheus.ch'
#include 'parmtype.ch'

user function tststrtrans()

local ctexto
local cTexto1

Conout("Inicio do teste strtrans")


cTexto := "Ser ou n�o Ser, eis a quest�o!"

 

cTexto1 := STRTRAN(cTexto, "Ser", "Programar")

Conout(Ctexto1)

	
return