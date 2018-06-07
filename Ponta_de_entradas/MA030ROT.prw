#include 'protheus.ch'
#include 'parmtype.ch'

user function MA030ROT()

aRetorno := {}

AAdd( aRetorno, { "TESTE", "U_TESTEMA030ROT", 2, 0 } )

Return( aRetorno )

user function TESTEMA030ROT

alert("passou pelo MA030ROT")

return	