#include 'protheus.ch'
#include 'parmtype.ch'

user function MT094END()
Local cDocto    := PARAMIXB[1] 
Local cTipo    := PARAMIXB[2]
Local nOpc        := PARAMIXB[3]
Local cFilDoc := PARAMIXB[4]

IF(SC7->C7_CONAPRO='L')
 // Validações do usuário.
alert("Pedido: "+cvaltochar(cDocto)+ "foi APROVADO!")
else

alert("Pedido não foi aprovado")

ENDIF

Return .t.
