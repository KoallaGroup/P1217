#include 'protheus.ch'
#include 'parmtype.ch'


user function MT241EAI()
Local lRet := .F.
Local aCab := PARAMIXB[1]
local atotitem := PARAMIXB[2]

conOut("Passou MT241EAI")

Return {aCab, atotitem}