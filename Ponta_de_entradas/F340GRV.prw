#include 'protheus.ch'
#include 'parmtype.ch'

User Function F340GRV()

Local nOpcA := paramixb[1] 
If nOpcA == 1 
Alert("Entrei no F340GRV e nOpcA = " + AllTrim(Str(nOpcA)) + " ent�o irei fazer as grava��es necess�rias.") 
// u_sendmail() 
ElseIf nOpcA == 0 
MsgAlert("Cancelado - teste F340GRV") 
EndIf

Return