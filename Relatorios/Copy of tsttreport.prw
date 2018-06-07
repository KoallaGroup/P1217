#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

User Function RCOMR02() 

local oReport
local cPerg := 'RCOMR01'
local cAlias := getNextAlias()

oReport := reportDef(cAlias, cPerg)
oReport:PrintDialog()

return

Static Function ReportPrint(oReport,cAlias)
Local oSecao1 := oReport:Section(1)

oSecao1:BeginQuery()

BeginSQL Alias cAlias
select E1_NUM, E1_VALOR from SE1990
EndSQL

oSecao1:EndQuery()
oReport:SetMeter((cAlias)->(RecCount()))
oSecao1:Print() 

return

Static Function ReportDef(cAlias)

local cTitle   := "Relatório de Conta Corrente"
local cHelp   := "Permite gerar relatório de Conta Corrente de Fornecedores"
local oReport
local oSection1
local cPosit    := "E1_VALOR > 100" 

oReport := TReport():New('RCOMR02',cTitle,cAlias,{|oReport|ReportPrint(oReport,cAlias)},cHelp)

//Primeira seção
oSection1 := TRSection():New(oReport,"Conta Corrente",{cAlias}) 

oCell:= TRCell():New(oSection1,"E1_VALOR", cAlias, "Número")

aAdd(oSection1:Cell("E1_VALOR"):aFormatCond, {cPosit,,CLR_GREEN})

Return(oReport)


//IF(IsNumeric(SE1->E1_VALOR),SE1->E1_VALOR > 1000, .f. )

