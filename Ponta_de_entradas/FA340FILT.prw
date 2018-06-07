#include 'protheus.ch'
#include 'parmtype.ch'

user function FA340FILT()

Local nRec := PARAMIXB	
 
IF !EOF()     // Verifica se a área de trabalho não está no final de arquivo
          MsgInfo("Você está no cliente: " + __SUBS->E2_NUM)
ENDIF


	If __SUBS->E2_NUM = "41       " 

	conout("falso")
	Return .f. 

	Else 

	conout("verdadeiro")
	return .t.

	endif
	


	
