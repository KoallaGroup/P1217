#include 'protheus.ch'
#include 'parmtype.ch'

user function MT097APR()

If Procname(24) == "{||FWPreExecute('Libera��o de Dctos', 'MATA094()', 1, '02', 'xxxxxxxxxx') }"  // Aqui indica que a chamada de pilha 4 n�o � igual a primeira chamada do ponto  ou seja.. s� ir� passar pelo alert 1 vez.

alert ("passou pelo MT097APR")    

EndIf

return .F.