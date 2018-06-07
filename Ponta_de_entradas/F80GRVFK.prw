#Include "Totvs.ch"
#Include "RwMake.ch"
#Include "TopConn.ch"
#Include "tbiconn.ch"
#Include "FwMvcDef.ch"
#Include "Protheus.ch"
/*/{Protheus.doc} F080GRVFK
Ponto de entrada na baixa automatica no retorno CNAB,permitindo copiar o histórico existente no título
tabela(SE2 - Contas a pagar) para o campo E5_HISTOR
@Return		Nil
@Author		CoachingTech
@Version	001
@Since		03/12/2013
@Obs		03/12/2013 - Edmilson Dias Santos	- Construção Inicial
 			22/11/2017 - CoachingTech			- Fonte Alterado por causa da Migração Protheus12
 												- Programa fonte anterior: SE5FI080 (Descontinuado)
/*/
User function F80GRVFK()

Local oObj := ParamIxb[1] 
Local nOpc := ParamIxb[2]

Local cHistMov := ""

If nOpc == 1 //Baixa 
	cHistMov := "Teste"
	oObj:SetValue( "FK5_HISTOR" , cHistMov )
Else // Valores Assesórios

	If nOpc == 2 // Desconto
		cHistMov := RTrim(cHistMov) + ' - Desconto'
	ElseIf nOpc == 3 // Juros
		cHistMov := RTrim(cHistMov) + ' - Juros'
	ElseIf nOpc == 4 // Multa
		cHistMov := RTrim(cHistMov) + ' - Multa'
	ElseIf nOpc == 5 // Correcao Monetaria
		cHistMov := RTrim(cHistMov) + ' - Correcao'
	ElseIf nOpc == 6 // Imposto Substituicao
		cHistMov := RTrim(cHistMov) + ' - Imposto Substituicao'
	EndIf
	
	oObj:SetValue( "FK6_HISTOR" , cHistMov )

Endif

Return oObj