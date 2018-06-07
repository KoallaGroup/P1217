#include 'protheus.ch'
#include 'parmtype.ch'

user function CM010LOK()
	
Local lRet := ParamIxb[1]// Validações do usuário para inclusão ou alteração do produto na Tabela de Preços do Fornecedor


alert("Passou pelo CM010LOK")

Return (lRet)