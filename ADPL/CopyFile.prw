#include 'protheus.ch'
#include 'parmtype.ch'

user function CopyFile()

Local bOK

Conout("Testando a c�pia do arquivo")

bOk := CpyS2T( "\crystal\exemplo.pdf", "C:\TEMP", .F. )

IF(bOk)
	conout("Gravou Corretamente na Fun��o CpyS2T")
else
	conout("N�o gravou, Fun��o CpyS2T")
ENDIF

conout("----------------------------------------")

IF(__CopyFile( "\crystal\teste.pdf", "C:\TEMP"))
	conout("Gravou Corretamente na Fun��o __CopyFile")
else
	conout("N�o gravou, Fun��o __CopyFile")
ENDIF	
	

	
return