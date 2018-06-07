#Include 'Protheus.ch'
#Include 'FWMVCDEF.ch'

User Function FINM010() 
Local aParam := PARAMIXB 
Local lRet := .T. 
Local oSubFK1 := '' 
Local cIdPonto := '' 
Local cIdModel := ''

If aParam <> NIL 

oSubFK1 := aParam[1] //Objeto do formul�rio ou do modelo, conforme o caso 
cIdPonto := aParam[2] //ID do local de execu��o do ponto de entrada 
cIdModel := aParam[3] //ID do formul�rio

If cIdPonto == 'FORMPOS' 
If cIdModel == 'FK1DETAIL' 
oSubFK1:SetValue( "FK1_HISTOR", 'PONTO DE ENTRADA EM MVC' ) 
EndIf 
EndIf 
EndIf 

Return lRet