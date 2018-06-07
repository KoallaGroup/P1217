#include 'protheus.ch'
#include 'parmtype.ch'

user function OM200QRY()



Local cQuery     := PARAMIXB[1]
Local aArrayTipo := PARAMIXB[2] 
Local aArrayMod := PARAMIXB[3] 
Local cTipo      := ""
Local nX         := 0


alert("PE OM200QRY")



//-- Carrega String com tipos de cargas selecionados pelo usuário.
For nX := 1 To Len(aArrayTipo)	
If aArrayTipo[nX,1]		
cTipo += aArrayTipo[nX,2]+"/"	
EndIf
Next nXMsgAlert(cTipo)
//-- processo especifico...

Return cQuery