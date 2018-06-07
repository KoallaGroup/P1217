#include 'protheus.ch'
#include 'parmtype.ch'

user function M410lDel()

local nPRoc

If !Procname(4) == "{|| Self:DelOk()}" 

alert ("passou pelo M410del")	

EndIf

return .F.