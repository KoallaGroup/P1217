#include 'protheus.ch'
#include 'parmtype.ch'

user function MULTNATB()

alert("Chamou o PE : MNBCANCEL")

if empty(aColPE[1][1])
lret := .F.
Else
lret :=.T.
Endif

Return lret	
