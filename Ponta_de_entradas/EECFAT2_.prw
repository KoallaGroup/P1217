#include 'protheus.ch'
#include 'parmtype.ch'

User Function EECFAT2()

Local cParam:= ""

IF Type("ParamIXB") == "C"
cParam:= PARAMIXB
Else
cParam:= PARAMIXB[1]
Endif

IF cParam == "VALID_FATU"
msginfo("Entrou no ponto de entrada 'VALID_FATU'") 
lPeRet := .F.
ENDIF

IF cParam == "PE_GRVCAPA"

aAdd(aCab,{"C5_CLIENTE","Teste Cliente",nil})  

lPeRet := .F.
ENDIF

Return Nil