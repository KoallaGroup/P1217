#include 'protheus.ch'
#include 'parmtype.ch'

user function EDAPPBUT()

Local aBut := PARAMIXB 
IF SUBSTRING(SM0->M0_CGC,1,8)$("46394094/43372119/00881843/03141998") 
aBut[7] := .F. 
ENDIF 
Return aBut