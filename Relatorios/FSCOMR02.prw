#Include 'Protheus.ch'
#include 'parmtype.ch'
#INCLUDE "topconn.ch"
//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  FSCOMR02
Relatorio de Reposição de Estoque

@author Victor
@version 1.0
@since 26/02/2014
@return Nil
@obs Sem obs
@sample
..........
Conterá um exemplo de utilização da função.
..........
/*/
//--------------------------------------------------------------------------------------------------------
User Function FSCOMR02()

	Local oReport

	Private cPerg := 'FSCOMR02'
	Private c_DtD := ' '
	Private c_DtA := ' '
	Private c_DscP := ' '
	Private c_QDs := '0'
	Private c_GPDe := ' '
	Private c_GPAte:= ' '
	Private c_Par08 := ' '
	PlSQuery(GQry(),"_Q01")

	DbSelectArea("_Q01")

	ValidPerg(cPerg)


//+------------------------------------------------------------------------+
//|Interface de impressao                                                  |
//+------------------------------------------------------------------------+
	oReport := ReportDef()

	oReport:PrintDialog()

Return



//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReporteDef
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario.

@author Victor
@version 1.0
@since 26/02/2014
@return oReport Objeto do Relatorio.
@obs Sem obs
@sample
..........
Conterá um exemplo de utilização da função.
..........
/*/
//--------------------------------------------------------------------------------------------------------
Static Function ReportDef()

	Local oReport
	LOCAL a_TRB := {}
	Local oSection1
	Local oSection2



	a_TRB := _Q01->(DBSTRUCT())

//+------------------------------------------------------------------------+
//|Criacao do componente de impressao                                      |
//|                                                                        |
//|TReport():New                                                           |
//|ExpC1 : Nome do relatorio                                               |
//|ExpC2 : Titulo                                                          |
//|ExpC3 : Pergunte                                                        |
//|ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  |
//|ExpC5 : Descricao                                                       |
//|                                                                        |
//+------------------------------------------------------------------------+
	oReport := TReport():New("FSCOMR02","Reposição de Estoque",cPerg, {|oReport| ReportPrint(oReport)},/*Descricao do relatório*/)
	oReport:SetLandscape(.F.)   //Define a orientação de página do relatório como paisagem  ou retrato. .F.=Retrato; .T.=Paisagem
	oReport:SetTotalInLine(.F.) //Define se os totalizadores serão impressos em linha ou coluna

	If !Empty(oReport:uParam)
		Pergunte(oReport:uParam,.F.)
	EndIf


//+------------------------------------------------------------------------+
//|Criacao da secao utilizada pelo relatorio                               |
//|                                                                        |
//|TRSection():New                                                         |
//|ExpO1 : Objeto TReport que a secao pertence                             |
//|ExpC2 : Descricao da seçao                                              |
//|ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   |
//|        sera considerada como principal para a seção.                   |
//|ExpA4 : Array com as Ordens do relatório                                |
//|ExpL5 : Carrega campos do SX3 como celulas                              |
//|        Default : False                                                 |
//|ExpL6 : Carrega ordens do Sindex                                        |
//|        Default : False                                                 |
//|                                                                        |
//+------------------------------------------------------------------------+
	oSection1 := TRSection():New(oReport,"Produtos",{"_Q01"})
	oSection1:SetTotalInLine(.F.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	oSection1:SetHeaderPage()

//+------------------------------------------------------------------------+
//|Criacao da celulas da secao do relatorio                                |
//|                                                                        |
//|TRCell():New                                                            |
//|ExpO1 : Objeto TSection que a secao pertence                            |
//|ExpC2 : Nome da celula do relatório. O SX3 será consultado              |
//|ExpC3 : Nome da tabela de referencia da celula                          |
//|ExpC4 : Titulo da celula                                                |
//|        Default : X3Titulo()                                            |
//|ExpC5 : Picture                                                         |
//|        Default : X3_PICTURE                                            |
//|ExpC6 : Tamanho                                                         |
//|        Default : X3_TAMANHO                                            |
//|ExpL7 : Informe se o tamanho esta em pixel                              |
//|        Default : False                                                 |
//|ExpB8 : Bloco de código para impressao.                                 |
//|        Default : ExpC2                                                 |
//|                                                                        |
//+------------------------------------------------------------------------+
	//TRCell():New(/*oSection*/,/*X3_CAMPO*/,/*Tabela*/,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	//TRFunction():New(oSection:Cell(/*X3_CAMPO*/),/* cID */,"COUNT",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)


	TRCell():New(oSection1,"PROD"	,"_Q01","Produto"	,/*Picture*/,			a_TRB[01,3],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"FABRIC"	,"_Q01","Fabric"	,/*Picture*/,			a_TRB[14,3],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"DESCRI"	,"_Q01","Descricao",/*Picture*/,		a_TRB[02,3],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"B1_UM"	,"_Q01","Unid",/*Picture*/,				a_TRB[03,3],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"VUNIT"	,"_Q01","Ult Preço",/*Picture*/,		a_TRB[04,3],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"PVCG"	,"_Q01","P. Cons Grl",/*Picture*/,	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"PVRG"	,"_Q01","P. Rep Grl",/*Pictue*/,	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"PVC02"	,"_Q01","P. Cons 02",/*Picture*/,	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"PVC03"	,"_Q01","P. Cons 03",/*Picture*/,	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"PVR02"	,"_Q01","P. Rep 02",/*Picture*/,	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"QATU02"	,"_Q01","Est. 02",/*Picture*/,		,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"PVR03"	,"_Q01","P. Repos 03",/*Picture*/,	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"QATU03"	,"_Q01","Est. 03",/*Picture*/,		,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"OBS"	,"_Q01","Obs",/*Picture*/,				a_TRB[13,3],/*lPixel*/,/*{|| code-block de impressao }*/)


//TRFunction():New(oSection:Cell("A1_COD"),,"COUNT")

	oSection2 := TRSection():New(oSection1,"Fornecedores",{"SD1","SA2"})
	oSection2:SetTotalInLine(.F.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	//oSection2:SetHeaderPage(.T.)

	//D1_FILIAL, D1_FORNECE, B.A2_NREDUZ, D1_LOJA, A.D1_VUNIT, A.D1_X_CUST , D1_DOC, D1_DTDIGIT
	TRCell():New(oSection2,"D1_FILIAL"		,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"D1_FORNECE"	,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"D1_LOJA"		,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"A2_NREDUZ"		,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"D1_VUNIT"		,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
//	TRCell():New(oSection2,"D1_X_CUST"		,"SD1","Custo c/ Imp.",/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"D1_QUANT"		,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"D1_DOC"			,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"D1_DTDIGIT"	,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)


//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportPrint
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario.

@param oReport Objeto do relatório
@author Victor
@version 1.0
@since 26/02/2014
@return Nil
@obs Sem obs
@sample
..........
Conterá um exemplo de utilização da função.
..........
/*/
//--------------------------------------------------------------------------------------------------------
Static Function ReportPrint(oReport)
	Local n_Reg := 0
	Local Section1 := oReport:Section(1)
	Local Section2 := oReport:Section(1):Section(1)
	Local c_Qry := " "

	_Q01->(DbCloseArea())

	Pergunte(cPerg,.F.)
	c_DtD := DtoS(MV_PAR01)
	c_DtA := DtoS(MV_PAR02)
	c_DscP := Alltrim(MV_PAR03)
	c_QDs := STRZero(MV_PAR04,3)
	c_GPDe := MV_PAR05
	c_GPAte := MV_PAR06

	PlSQuery(GQry(),"_Q01")

	DbSelectArea("_Q01")

//+------------------------------------------------------------------------+
//|Inicio da impressao do fluxo do relatório                               |
//+------------------------------------------------------------------------+
	Count to n_Reg

	oReport:SetMeter(n_Reg)

	DbGoTop()

	While !Eof()
		oReport:IncMeter()

		Section1:Init()
		Section1:PrintLine()
		Section1:Finish()
		IF MV_PAR07 > 0
			c_Qry := "SELECT TOP "+StrZero(MV_PAR07,2)+" A.R_E_C_N_O_ AS RSD1, B.R_E_C_N_O_ AS RSA2 "
			c_Qry += "FROM SD1990 A, SA2990 B "
			c_Qry += "WHERE A.D_E_L_E_T_ = ' '  AND B.D_E_L_E_T_ = ' ' "
			c_Qry += "AND A.D1_FORNECE = B.A2_COD "
			c_Qry += "AND A.D1_LOJA = B.A2_LOJA "
			c_Qry += "AND A.D1_TIPO = 'N' "
			c_Qry += "AND A.D1_FORNECE <> '000022' "
			c_Qry += "AND A.D1_COD = '"+_Q01->PROD+"' "
			c_Qry += "ORDER BY A.D1_DTDIGIT DESC"

			PlSQuery(c_Qry,"_Q02")

			If ! Eof()
				Section2:Init()
				While ! Eof()
					DbSelectArea("SD1")
					DbGoto(_Q02->RSD1)

					DbSelectArea("SA2")
					DbGoto(_Q02->RSA2)

					Section2:PrintLine()
					DbSelectArea("_Q02")
					DbSkip()
				EndDo


				Section2:Finish()
			EndIf
			_Q02->(DbCloseArea())
		Endif
		oReport:Thinline()
		DbSelectArea("_Q01")
		DbSkip()
	EndDo
	_Q01->(DbCloseArea())
Return

Static Function ValidPerg(cPerg)
	Local _sAlias,i,j
	_sAlias := Alias()
	dbSelectArea("SX1")
	dbSetOrder(1)
	cPerg := PADR(cPerg,10) 
	aRegs:={}
	


// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/f3
	AADD(aRegs,{cPerg,"01","Periodo de    ","","","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"02","Periodo ate   ","","","mv_ch2","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"03","Produto       ","","","mv_ch3","C",30,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"04","Previsao Dias ","","","mv_ch4","N",03,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"05","Grupo Prod De ","","","mv_ch5","C",04,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","SBM","","","","",""})
	AADD(aRegs,{cPerg,"06","Grupo Prod Ate","","","mv_ch6","C",04,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","SBM","","","","",""})
	AADD(aRegs,{cPerg,"07","Qtd Fornecedor","","","mv_ch7","N",02,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"08","Considerar Bloqueados ?"	,Space(20),Space(20),"mv_ch8","C",20,0,0,"C","","mv_par08","Não","","","","","Sim","","","","","","","","","","","","","","","","","","","","","","","","","",""})


	For i:=1 to Len(aRegs)
		If !dbSeek(cPerg+aRegs[i,2])
			RecLock("SX1",.T.)
			For j:=1 to FCount()
				FieldPut(j,aRegs[i,j])
			Next
			MsUnlock()
			dbCommit()
		EndIf
	Next
	dbSelectArea(_sAlias)
Return

Static Function GQry()
	Local c_Qry := ""
	Local c_Par08 := CVALTOCHAR(mv_par08)

	c_Qry := "SELECT RTRIM(PRODUTO) AS PROD, SUBSTRING(B1_DESC,1,60) AS DESCRI, B1_UM,  "
	c_Qry += "(SELECT TOP 1 D1_VUNIT "
	c_Qry += "FROM SD1990  "
	c_Qry += "WHERE D_E_L_E_T_ = ' ' "
	c_Qry += "AND D1_TIPO = 'N' "
	c_Qry += "AND D1_FORNECE <> '000022' "
	c_Qry += "AND D1_COD = TAB01.PRODUTO "
	c_Qry += "ORDER BY D1_DTDIGIT DESC) AS VUNIT,  "
	c_Qry += "ROUND(SUM(PREV_C02+PREV_C03),3) AS PVCG, "
	c_Qry += "ROUND(SUM(PREV_R02+PREV_R03),3) AS PVRG, "
	c_Qry += "ROUND(SUM(PREV_C02),3) AS PVC02, "
	c_Qry += "ROUND(SUM(PREV_C03),3) AS PVC03,  "
	c_Qry += "ROUND(SUM(PREV_R02),3) AS PVR02, "
	c_Qry += "ISNULL((SELECT SUM(B2_QATU-B2_RESERVA) FROM SB2990 WHERE D_E_L_E_T_ = ' ' AND B2_FILIAL = '02' AND B2_COD = TAB01.PRODUTO AND B2_LOCAL IN ('01','20')),0) AS QATU02, "
	c_Qry += "ROUND(SUM(PREV_R03),3) AS PVR03, "
	c_Qry += "ISNULL((SELECT SUM(B2_QATU-B2_RESERVA) FROM SB2990 WHERE D_E_L_E_T_ = ' ' AND B2_FILIAL = '03' AND B2_COD = TAB01.PRODUTO AND B2_LOCAL IN ('01','30')),0) AS QATU03, "
	c_Qry += "((CASE WHEN "
	c_Qry += "( "
	c_Qry += "(CASE WHEN SUM(PREV_R02) = 0 THEN ISNULL((SELECT SUM(B2_QATU-B2_RESERVA) FROM SB2990 WHERE D_E_L_E_T_ = ' ' AND B2_FILIAL = '02' AND B2_COD = TAB01.PRODUTO AND B2_LOCAL IN ('01','20')),0) ELSE SUM(PREV_R02) END) < 0 "
	c_Qry += "OR (CASE WHEN SUM(PREV_R03) = 0 THEN ISNULL((SELECT SUM(B2_QATU-B2_RESERVA) FROM SB2990 WHERE D_E_L_E_T_ = ' ' AND B2_FILIAL = '03' AND B2_COD = TAB01.PRODUTO AND B2_LOCAL IN ('01','30')),0) ELSE SUM(PREV_R03) END) < 0 "
	c_Qry += ") "
	c_Qry += "AND ((CASE WHEN SUM(PREV_R02) = 0 THEN ISNULL((SELECT SUM(B2_QATU-B2_RESERVA) FROM SB2990 WHERE D_E_L_E_T_ = ' ' AND B2_FILIAL = '02' AND B2_COD = TAB01.PRODUTO AND B2_LOCAL IN ('01','20')),0) ELSE SUM(PREV_R02) END) "
	c_Qry += "+(CASE WHEN SUM(PREV_R03) = 0 THEN ISNULL((SELECT SUM(B2_QATU-B2_RESERVA) FROM SB2990 WHERE D_E_L_E_T_ = ' ' AND B2_FILIAL = '03' AND B2_COD = TAB01.PRODUTO AND B2_LOCAL IN ('01','30')),0) ELSE SUM(PREV_R03) END)) > 0 "
	c_Qry += "THEN 'Sugestão: Transf. entre Filiais' ELSE '' END)) AS OBS, B1_FABRIC AS FABRIC "
	c_Qry += "FROM ( "
	c_Qry += "SELECT "
	c_Qry += "SL2.L2_FILIAL AS FILIAL, SL2.L2_PRODUTO AS PRODUTO,  "
	c_Qry += "(SUM(CASE WHEN SL2.L2_FILIAL='02' THEN SL2.L2_QUANT ELSE 0 END) / (SELECT DATEDIFF(DAYOFYEAR,'"+ c_DtD +"','"+ c_DtA +"')+1) * "+ c_QDs +") AS PREV_C02 , "
	c_Qry += "(SUM(CASE WHEN SL2.L2_FILIAL='03' THEN SL2.L2_QUANT ELSE 0 END) / (SELECT DATEDIFF(DAYOFYEAR,'"+ c_DtD +"','"+ c_DtA +"')+1) * "+ c_QDs +") AS PREV_C03, "
	c_Qry += "ISNULL((CASE WHEN SL2.L2_FILIAL='02' THEN(SELECT SUM(B2_QATU-B2_RESERVA) FROM SB2990 "
	c_Qry += "WHERE D_E_L_E_T_ = ' '  "
	c_Qry += "AND B2_FILIAL = '02' "
	c_Qry += "AND B2_COD = SL2.L2_PRODUTO "
	c_Qry += "AND B2_LOCAL IN ('01','20'))ELSE 0 END),0) - ((SUM(CASE WHEN SL2.L2_FILIAL='02' THEN SL2.L2_QUANT ELSE 0 END) / (SELECT DATEDIFF(DAYOFYEAR,'"+ c_DtD +"','"+ c_DtA +"')+1) * "+ c_QDs +")) AS PREV_R02, "
	c_Qry += "ISNULL((CASE WHEN SL2.L2_FILIAL='03' THEN(SELECT SUM(B2_QATU-B2_RESERVA) FROM SB2990 "
	c_Qry += "WHERE D_E_L_E_T_ = ' '  "
	c_Qry += "AND B2_FILIAL = '03' "
	c_Qry += "AND B2_COD = SL2.L2_PRODUTO "
	c_Qry += "AND B2_LOCAL IN ('01','30'))ELSE 0 END),0) - ((SUM(CASE WHEN SL2.L2_FILIAL='03' THEN SL2.L2_QUANT ELSE 0 END) / (SELECT DATEDIFF(DAYOFYEAR,'"+ c_DtD +"','"+ c_DtA +"')+1) * "+ c_QDs +")) AS PREV_R03 "
	c_Qry += "FROM SL1990 SL1  "
	c_Qry += "INNER JOIN SL2990 SL2 ON SL1.L1_FILIAL = SL2.L2_FILIAL "
	c_Qry += "AND SL1.L1_NUM = SL2.L2_NUM "
	c_Qry += "WHERE SL1.D_E_L_E_T_ = ' ' "
	c_Qry += "AND SL2.D_E_L_E_T_ = ' ' "
//	c_Qry += "AND L2_X_PDCON = ' ' "
//	c_Qry += "AND CASE WHEN L1_X_CONSG = 'S' THEN ISNULL "
//	c_Qry += "( "
//	c_Qry += "   L1_EMISSAO,L1_EMISNF "
//	c_Qry += ") "
//	c_Qry += "ELSE L1_EMISNF END >='"+ c_DtD +"' "
//	c_Qry += "AND CASE WHEN L1_X_CONSG = 'S' THEN ISNULL "
//	c_Qry += "( "
//	c_Qry += "   L1_EMISSAO,L1_EMISNF "
//	c_Qry += ") "
//	c_Qry += "ELSE L1_EMISNF END <='"+ c_DtA +"' "
	c_Qry += "GROUP BY SL2.L2_FILIAL, SL2.L2_PRODUTO ) AS TAB01, SB1990 A "
	c_Qry += "WHERE A.D_E_L_E_T_ = ' ' "
	c_Qry += "AND B1_COD = TAB01.PRODUTO "
	c_Qry += "AND B1_DESC LIKE '%"+c_DscP+"%' "
	c_Qry += "AND B1_GRUPO BETWEEN '"+c_GPDe+"' AND '"+c_GPAte+"' "
If c_Par08 = "1" // 1- Exibe Bloqueados, 2 - Nao exibe
	c_Qry += "AND B1_MSBLQL <> '1' "
EndIf
	c_Qry += "GROUP BY PRODUTO, B1_DESC, B1_UM,B1_FABRIC "
	c_Qry += "ORDER BY OBS DESC,PRODUTO"
*/
Return c_Qry
