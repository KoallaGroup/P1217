#include 'protheus.ch'
#include 'parmtype.ch'

user function M461SER()
Alert ("Passou pelo ponto de entrada - M461SER")


IF(SC9->C9_PEDIDO =='000020')
cSerie := "H"

cNumero := "000007"

ELSEIF (SC9->C9_PEDIDO =='000021')

cSerie := "I"

cNumero := "000003"

ENDIF
return