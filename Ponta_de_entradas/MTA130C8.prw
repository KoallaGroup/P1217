#include 'protheus.ch'
#include 'parmtype.ch'

User Function MTA131C8()

Local oModFor := PARAMIXB[1]

//Customizações do usuario
oModFor:LoadValue("C8_CONTATO","TSTPE - "+oModFor:GetValue("C8_FORNECE"))


alert("Passou pelo PE MTA131C8")
Return