#include 'protheus.ch'
#include 'parmtype.ch'

User Function WFPE007()
Local cHTML := ""
Local plSuccess := ParamIXB1 
Local pcMessage := ParamIXB2 
Local pcProcessID := ParamIXB3

If ( plSuccess )

// Mensagem em formato HTML para sucesso no processamento.

cHTML += 'Processamento executado com sucesso!' 

cHTML += '<br>'

cHTML += pcMessage

Else

//Mensagem em formato HTML para falha no processamento.

cHTML += 'Falha no processamento!'

cHTML += '<br>' 

cHTML += pcMessage

EndIf

Return cHTML
	