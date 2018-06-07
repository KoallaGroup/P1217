#include "protheus.ch"

user function MA131KEY() 

local cRet := ""
local cKey := PARAMIXB[1]

conout("Ponto de entrada MA130KEY executado")

cKey += " + C1_NUM"

return cKey