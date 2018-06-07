#include 'protheus.ch'
#include 'parmtype.ch'

user function TstAxVisual()

Local cAlias := "SB1"
Local nReg := 3
Local nOpc 
Private CCADASTRO := "MATA010"

AxVisual(cAlias,nReg,nOpc)
	
return