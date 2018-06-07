#include 'protheus.ch'
#include 'parmtype.ch'
#include "totvs.ch"
#include "fwmvcdef.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AGBLSelAprv �Autor  �Saulo Arvelos       � Data �  10/11/15 ���
�������������������������������������������������������������������������͹��
���Desc.     �Seleciona aprovador da compra quando esta for bloqueada     ���
���          �pelo controle de al�adas.                                   ���
���          �Retorna variavel com os emails dos aprovadores selecionados ���
�������������������������������������������������������������������������͹��
���Uso       � Compras                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function AGBLSelAprv()

	Private oMark 
	Private cMailAprv := "" 
    Private aRotina := MenuDef()
    
    
	//estanciamento da classe mark
	oMark := FWMarkBrowse():New()
	
	//tabela que sera utilizada
	oMark:SetAlias( "SAL" )

	//Titulo
	oMark:SetDescription( "Seleciona aprovador para envio do E-mail" )

	//Setando sem�foro, descri��o e campo de mark
	oMark:SetSemaphore(.T.)

	//campo que recebera a marca
	oMark:SetFieldMark("AL_OK")

	//Seta quais campos da tabelas ser�o apresentados no Browse
	oMark:SetOnlyFields( { 'AL_OK', 'AL_USER', 'AL_NOME' } ) 

	//Permite adicionar um filtro na lista de op��es de filtros do Browse
	oMark:AddFilter("Aprovadores",'AL_COD == "000002"',.T.,.T.)

	// Define de que fonte vir�o os botoes deste browse
	oMark:SetMenuDef( 'GPEM040' )

	//Ativa
	oMark:Activate()

Return(cMailAprv)

// ---------------------------------------------------------------------*
// | Func:  MenuDef                                                     |
// | Autor: Saulo Arvelos                                               |
// | Data:  14/02/2017                                                  |
// | Desc:  Cria��o do menu MVC                                         |
// *--------------------------------------------------------------------*

Static Function MenuDef()
	Local aRotina := {}

	//Cria��o das op��es
	ADD OPTION aRotina TITLE 'Processar' ACTION 'U_EnvMail2' OPERATION 2 ACCESS 0
	ADD OPTION aRotina Title 'Pesquisar' Action 'PesqBrw'    OPERATION 1  ACCESS 0 DISABLE MENU
	
Return aRotina

// *---------------------------------------------------------------------*
// | Func:  ModelDef                                                     |
// | Autor: Saulo Arvelos                                                |
// | Data:  14/02/2018                                                   |
// | Desc:  Cria��o do modelo de dados MVC                               |
// *---------------------------------------------------------------------*

Static Function ModelDef()

Return FWLoadModel('SelAprv')

// *---------------------------------------------------------------------*
// | Func:  ViewDef                                                      |
// | Autor: Saulo Arvelos                                                |
// | Data:  14/02/2018                                                   |
// | Desc:  Cria��o da vis�o MVC                                         |
// *---------------------------------------------------------------------*

Static Function ViewDef()

Return FWLoadView('SelAprv')

// *---------------------------------------------------------------------*
// | Func:  EnvMail2                                                     |
// | Autor: Saulo Arvelos                                                |
// | Data:  14/02/2018                                                   |
// | Desc:  Percorre registros e captura e-mail do registros selecionados|
// *---------------------------------------------------------------------*
User Function EnvMail2()

	Local _nCont := 0
	Local aArea    := GetArea()
	Local cMarca   := oMark:Mark()
	Local lInverte := oMark:IsInvert()

	SAL->(DbGoTop())

	While !SAL->(EoF())
		iF	oMark:IsMark(cMarca)
			_nCont ++
		
			If _nCont > 1
				cMailAprv += ";"
				cMailAprv += UsrRetMail(AL_USER)// Se mais de um registros selecionado concatena os demais registros  
			Else
				cMailAprv := UsrRetMail(AL_USER)
			Endif	
			
		Endif
		DbSkip()
	EndDo

		MsgAlert(cValToChar(_nCont) + " Registro selecionado(s)")

	//Restaurando �rea armazenada
	RestArea(aArea)

Return	