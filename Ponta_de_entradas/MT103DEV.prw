#include 'protheus.ch'
#include 'parmtype.ch'

user function MT103DEV()
	
Local dDtDe := PARAMIXB[1]
Local dDtAte := PARAMIXB[2]
Local cQuery := ""
// Customização do cliente

Alert("Passou pelo PE MT103DEV")
cQuery := " SELECT * "
cQuery += "   FROM " + RetSqlName("SF2")
cQuery += "   WHERE F2_FILIAL  = '" + xFilial("SF2") + "' "
cQuery += "     AND F2_EMISSAO BETWEEN '" + DtoS(dDtDe) + "' AND '" + DtoS(dDtAte) + "' "
cQuery += "     AND F2_SERIE='1  '"


Return cQuery