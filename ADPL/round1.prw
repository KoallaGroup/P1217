#include 'protheus.ch'
#include 'parmtype.ch'

user function round1()
	
Local  nValue := 14.123456789
  conout( Round( nValue, 0 ) ) // Resultado: 14
  conout( Round( nValue, 1 ) ) // Resultado: 14.1
  conout( Round( nValue, 2 ) ) // Resultado: 14.12
  conout( Round( nValue, 3 ) ) // Resultado: 14.123
  
  conout( Round( nValue, 6 ) ) // Resultado: 14.123457
return