#include 'protheus.ch'
#include 'parmtype.ch'

user function M461COR()
	
aCores:=PARAMIXB
aAdd(aCores,{'!(Empty(SC9->C9_BLEST) .And. SC9->C9_BLCRED=="01"  .And. SC9->C9_BLWMS$"05,06,07,  ")','ENABLE'})

alert ("teste M461COR")
RETURN aCores
