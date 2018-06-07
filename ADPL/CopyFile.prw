#include 'protheus.ch'
#include 'parmtype.ch'

user function CopyFile()

Local bOK

Conout("Testando a cópia do arquivo")

bOk := CpyS2T( "\crystal\exemplo.pdf", "C:\TEMP", .F. )

IF(bOk)
	conout("Gravou Corretamente na Função CpyS2T")
else
	conout("Nâo gravou, Função CpyS2T")
ENDIF

conout("----------------------------------------")

IF(__CopyFile( "\crystal\teste.pdf", "C:\TEMP"))
	conout("Gravou Corretamente na Função __CopyFile")
else
	conout("Nâo gravou, Função __CopyFile")
ENDIF	
	

	
return