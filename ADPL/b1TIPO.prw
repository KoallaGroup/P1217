#include 'protheus.ch'
#include 'parmtype.ch'

user function b1TIPO()

LOCAL LRET:=.F.

IF ALTERA
	SB1->B1_TIPO=="PA"
		LRET:=.T.
		ENDIF

RETURN LRET
