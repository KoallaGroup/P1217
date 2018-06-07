#include 'protheus.ch'
#include 'parmtype.ch'

user function MT103FDV()


	
Local nRec := PARAMIXB
	
alert("Passou pelo PE MT103FDV")

	If !D2_SERIE = "1  " 

	conout("falso")
	Return .f. 

	Else 

	conout("verdadeiro")
	return .t.

	endif