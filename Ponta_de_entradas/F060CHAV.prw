#include 'protheus.ch'
#include 'parmtype.ch'
#include "rwmake.ch"

user function F060CHAV()
	
Local aChave := ParamIXB[1]
/*Local aChv01 := {}

aadd(aChv01, 'E1_FILIAL')
aadd(aChv01, 'E1_PREFIXO')
aadd(aChv01, 'E1_NUM')
aadd(aChv01, 'E1_PARCELA')
aadd(aChv01, 'E1_TIPO')

// E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
If aChave == aChv01            	// Altera para a chave E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO	*/
aChave := {}
aadd(aChave, 'E1_FILIAL')
aadd(aChave, 'E1_CLIENTE')
aadd(aChave, 'E1_LOJA')
aadd(aChave, 'E1_PREFIXO')
aadd(aChave, 'E1_NUM')
aadd(aChave, 'E1_PARCELA')
aadd(aChave, 'E1_TIPO')

Return aChave
