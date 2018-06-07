#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"



/*BEGINDOC
//����������������������������������������������������Ŀ
//�Exemplo de relatorio usando tReport com uma Section
//������������������������������������������������������
ENDDOC*/


User Function RCOMR02() 

local oReport
local cPerg  := 'RCOMR01'
local cAlias := getNextAlias()

//criaSx1(cPerg)
//Pergunte(cPerg, .F.)

oReport := reportDef(cAlias, cPerg)
oReport:printDialog()

return
        
//+-----------------------------------------------------------------------------------------------+
//! Rotina para montagem dos dados do relat�rio.                                  !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportPrint(oReport,cAlias)
              
local oSecao1 := oReport:Section(1)

oSecao1:BeginQuery()

BeginSQL Alias cAlias
 
select E1_NUM, E1_VALOR  from SE1990
 
EndSQL

oSecao1:EndQuery()
oReport:SetMeter((cAlias)->(RecCount()))
oSecao1:Print() 

return

//+-----------------------------------------------------------------------------------------------+
//! Fun��o para cria��o da estrutura do relat�rio.                                                !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportDef(cAlias)

local cTitle  := "Relat�rio de Conta Corrente"
local cHelp   := "Permite gerar relat�rio de Conta Corrente de Fornecedores"
local oReport
local oSection1
local�cPosit����:=�"E1_VALOR > 100"�

oReport�:=�TReport():New('RCOMR02',cTitle,cAlias,{|oReport|ReportPrint(oReport,cAlias)},cHelp)

//Primeira se��o
oSection1�:=�TRSection():New(oReport,"Conta Corrente",{cAlias})�

ocell2:= TRCell():New(oSection1,"E1_NUM", cAlias, "N�mero")
ocell:= TRCell():New(oSection1,"E1_VALOR", cAlias, "Valor")

oReport:SkipLine()
oReport:PrintText("TESTE",oReport:Row(),3)

aAdd(oSection1:Cell("E1_VALOR"):aFormatCond, {"E1_VALOR > 100 .and. E1_VALOR < 1000"�,,CLR_GREEN})
aAdd(oSection1:Cell("E1_VALOR"):aFormatCond, {"E1_VALOR >= 1000"�,,CLR_RED})


oSection2�:=�TRSection():New(oReport,"Sess�o 2",{cAlias})�

//oSay:= TSay():New(01,01,{||'Texto para exibi��o'},oDlg,,oFont,,,,.T.,CLR_RED,CLR_WHITE,200,20)

//FWSayColor( oSay, "#FF0000" )

oReport:oSection2:PrintText("TESTE",1,1)

Return(oReport)

