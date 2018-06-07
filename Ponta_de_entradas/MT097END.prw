#Include 'Protheus.ch'

User Function MT097END()

Return

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

User Function MT097END
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao>  : Para fins de necessidade do usu·rio
				LOCALIZA«√O : Function A097LIBERA - FunÁ„o da Dialog de liberaÁ„o e bloqueio dos documentos com alÁada, A097SUPERI - FunÁ„o da Dialog 
				de liberaÁ„o e bloqueio dos documentos com alÁada pelo superior e A097TRANSF FunÁ„o respons·vel pela transferÍncia do registro de 
				bloqueio para aprovaÁ„o do Superior.  
				EM QUE PONTO : O ponto se encontra no fim das funÁıes A097LIBERA, A097SUPERI e A097TRANSF , passa como parametros o Numero do Documento, 
				Tipo, OpÁ„o executada (nOpc) e a Filial do Documento e n„o envia retorno, usado conforme necessidades do usuario para diversos fins.
<Autor>      : Herick Ribeiro
<Data>       : 16/12/2015
<Parametros> : Nenhum
<Retorno>    : Nil
<Processo>   : Compras
<Rotina>     : MT097END
<Tipo>         (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,Especificas ) : P
<Obs>        : OTRS #2013102310001886 ó Workflow de AprovaÁ„o de Pedido de Compras no Protheus
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao>  : 
<Autor>      : 
<Data>       : 
<Parametros> : 
<Obs>        : 
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹ 
*/

	/*
	ParamIXB = {cDocto,cTipo,nOpc,cFilDoc} onde :
	cDocto == Numero do Documento
	cTipo == Tipo do Documento "PC" "AE" "CP"
	
	Quando o ponto È acionado pela rotina de LiberaÁ„o e Superior:
	nOpc == 1 --> Cancela
	nOpc == 2 --> Libera
	nOpc == 3 --> Bloqueia
	
	Quando o ponto È acionado pela rotina de Transf. Superior
	nOpc == 1 --> Transfere
	nOpc == 2 --> Cancela
	
	Obs.: Para esta rotina, caso n„o exista o superior cadastrado, a vari·vel ser·
	enviada como Nil. Deve ser tratado no ponto de entrada.
	
	cFilDoc == Filial do Documento
	*/

	Local cDocto    	:= PARAMIXB[1]
	Local cTipoDoc  	:= PARAMIXB[2]
	Local nOpcao    	:= PARAMIXB[3]
	Local cFilDoc   	:= PARAMIXB[4]
	Local cProxNivel	:= ""

	If GetNewPar("MV_XWFPC",.F.)
		If cTipoDoc == "PC"	
			If nOpcao == 2 //Libera
				ConOut("ACESSO PELO SISTEMA - ENVIANDO PARA O PROXIMO NIVEL DE APROVACAO")
				U_MPEPCENV(cProxNivel,cFilDoc,ALLTRIM(cDocto),IIF(AprovAnt(cFilDoc,ALLTRIM(cDocto)),4,3))
				ConOut("ACESSO PELO SISTEMA - AVISANDO COMPRADOR")
				U_MPEPCAVC(cFilDoc,ALLTRIM(cDocto),IIF(AprovAnt(cFilDoc,ALLTRIM(cDocto)),"ALT","INC"),SCR->CR_APROV,"EA") //Em AprovaÁ„o
			ElseIf nOpcao == 3 //Bloqueia
				ConOut("ACESSO PELO SISTEMA - BLOQUEANDO PEDIDO DE COMPRA")
				ConOut("ACESSO PELO SISTEMA - AVISANDO COMPRADOR")
				U_MPEPCAVC(cFilDoc,ALLTRIM(cDocto),IIF(AprovAnt(cFilDoc,ALLTRIM(cDocto)),"ALT","INC"),SCR->CR_APROV,"N") //Rejeitada
			Endif
		Endif
	Endif
 
Return

Static Function AprovAnt(cFilPC,cNumPC)
/*/f/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
<Descricao> : Retorna se houve AprovaÁ„o Anterior no Documento
<Autor> : Herick Ribeiro
<Data> : 23/12/2013
<Parametros> : N˙mero do Pedido de Compra
<Retorno> : LÛgico
<Processo> : Compras
<Rotina> : Miscelanea
<Tipo> (Menu,Trigger,Validacao,Ponto de Entrada,Genericas,EspecIficas ) : E
<Obs> :
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
*/

	
	Local aArea  	:= GetArea()
	Local cQuery 	:= ""
	Local cQry   	:= GetNextAlias()
	Local lRet	 	:= .F.
	Local cNumDoc	:= cNumPC + SPACE(TamSX3("CR_NUM")[1] - LEN(cNumPC))

	cQuery := "SELECT SCR.CR_USER, SCR.R_E_C_N_O_ AS SCRRECNO, SCR.CR_APROV " + CRLF
	cQuery += "FROM " + RetSQLName("SCR") + " SCR " + CRLF
	cQuery += "WHERE SCR.D_E_L_E_T_ = '*' " + CRLF
	cQuery += "	AND SCR.CR_FILIAL = '" + cFilPC + "' " + CRLF
	cQuery += "	AND SCR.CR_NUM = '" + cNumDoc +  "' " + CRLF
	
	alert( "Passou pelo ponot MT097END")
	TcQuery cQuery Alias (cQry) New
	dbSelectArea((cQry))
	If !Eof()	
		lRet := .T.	
	Endif
	dbSelectArea((cQry))
	dbCloseArea()
 
	RestArea(aArea)

Return lRet