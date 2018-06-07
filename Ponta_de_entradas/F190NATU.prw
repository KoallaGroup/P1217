#include 'protheus.ch'
#include 'parmtype.ch'

user function F190NATU()

Local _lRet    := .F.
Local cNatureza := PARAMIXB[1]

If empty(alltrim(cNatureza))
 _lRet := .F.
 Alert("Campo em branco, vou deixar passar")
EndIf

Return _lRet


	
