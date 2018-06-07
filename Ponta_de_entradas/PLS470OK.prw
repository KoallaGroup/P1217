#Include 'Protheus.ch'

User Function PLS470OK()

Local cOpc  := paramixb[1]
Local dData := paramixb[2]
Local lRet := .T.

alert("Passou pelo ponto PSL470OK")

If cOpc == "I"    
//Tratamento para inclusao
ElseIf cOpc == "EL"        
//Tramento para exclusao do lote
ElseIf cOpc == "ET"        
//Tratamento para exclusao do titulo
EndIf

Return(lRet)

