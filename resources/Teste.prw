// #########################################################################################
// Projeto:
// Modulo :
// Fonte  : Teste
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 08/03/17 | TOTVS | Developer Studio | Gerado pelo Assistente de C�digo
// ---------+-------------------+-----------------------------------------------------------

#include "rwmake.ch"

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} novo
Permite a manuten��o de dados armazenados em .

@author    TOTVS | Developer Studio - Gerado pelo Assistente de C�digo
@version   1.xx
@since     8/03/2017
/*/
//------------------------------------------------------------------------------------------
user function novo()
	//--< vari�veis >---------------------------------------------------------------------------
	
	//Indica a permiss�o ou n�o para a opera��o (pode-se utilizar 'ExecBlock')
	local cVldAlt := ".T." // Operacao: ALTERACAO
	local cVldExc := ".T." // Operacao: EXCLUSAO
	
	//trabalho/apoio
	local cAlias
	
	//--< procedimentos >-----------------------------------------------------------------------
	cAlias := ""
	chkFile(cAlias)
	dbSelectArea(cAlias)
	//indices
	dbSetOrder(1)
	axCadastro(cAlias, "Cadastro de . . .", cVldExc, cVldAlt)
	
return
//--< fim de arquivo >----------------------------------------------------------------------
