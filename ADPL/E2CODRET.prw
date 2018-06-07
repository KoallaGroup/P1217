#include 'protheus.ch'
#include 'parmtype.ch'

user function E2CODRET()

IF isincallstack('FINA290')

return .t.

ElseIF M->E2_DIRF=="1"


return .t.

else

return .f.

endif

//IIF(isincallstack('FINA290'), .t. ,IF(M->E2_DIRF=="1", .t.))
	
//return