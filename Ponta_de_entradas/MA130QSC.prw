#include "protheus.ch"

function MA130QSC()

local cFinal 	:= ""
local bQuebra 	:= PARAMIXB[1]
local cRet 		:= ""
local cAval		:= ""

conout("Ponto de entrada MA130QSC executado")

cRet := GetCbSource(bQuebra) 

for x:= 1 to len(cRet)
	cAval := Substr(cRet,x,1)
	if cAval == '{' .or. cAval == '|' .or. cAval == '}'
		loop
	else
		cFinal += cAval
	endIf
next x
      
cFinal += " + C1_NUM"

return {||&(cFinal)}