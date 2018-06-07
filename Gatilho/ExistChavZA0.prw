#include 'protheus.ch'
#include 'parmtype.ch'

user function ExistChavZA0()


IF ExistChav("CC2", M->ZA0_EST + M->ZA0_CIDADE)    

Alert("Encontrou")

return .t.
Else

Alert("Não encontrou")

	
return 

Endif



user function ExistCpoZA0()


IF ExistCpo("CC2", M->ZA0_EST + M->ZA0_CIDADE)    

Alert("Encontrou")

return .t.
Else

Alert("Não encontrou")

	
return 

Endif