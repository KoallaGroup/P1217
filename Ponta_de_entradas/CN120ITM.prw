#include 'protheus.ch'
#include 'parmtype.ch'

user function CN120ITM()



Local ExpA1 := PARAMIXB[1]
Local ExpA2 := PARAMIXB[2]

Local ExpC1 := PARAMIXB[3]

//Valida��es do usu�rio.
Alert("Passou pelo PE CN120ITM")


Return {ExpA1,ExpA2}