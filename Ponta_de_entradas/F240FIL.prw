#include 'protheus.ch'
#include 'parmtype.ch'

user function F240FIL()


IF msgyesno("Deseja Filtrar por RPA?", "F240FIL")
	cRetorno := "E2_TIPO == 'RPA'"
	
ENDIF



Return(cRetorno)
