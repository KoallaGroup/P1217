#include 'protheus.ch'
#include 'parmtype.ch'

user function CM010LOK()
	
Local lRet := ParamIxb[1]// Valida��es do usu�rio para inclus�o ou altera��o do produto na Tabela de Pre�os do Fornecedor


alert("Passou pelo CM010LOK")

Return (lRet)