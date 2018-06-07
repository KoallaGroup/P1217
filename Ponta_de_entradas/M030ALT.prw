#include 'protheus.ch'
#include 'parmtype.ch'

user function M030ALT()

Reclock("SA1", .f.)

alert("Passou pelo PE MT030ALT")

Msunlock()
	
return .t.