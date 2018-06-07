#include "protheus.ch"

User Function F450OWN()



Local cString := ""

Alert("Passou pelo PE F450OWN")

#IFDEF TOP // Ambiente em TOPCONNECT

cString := "E1_FILIAL = '" + xFilial("SE1") + "' AND " 
cString += "E1_VENCREA >= '" + DTOS(dVenIni450) + "' AND " 
cString += "E1_VENCREA <= '" + DTOS(dVenFim450) + "' AND "

// Se nao considera titulos transferidos, filtra (exibe) apenas os titulos que estao em carteira.
If mv_par03 == 2

cString += "E1_SITUACA IN('0','F','G') AND "

Endif 
cString += "E1_MOEDA = " + Alltrim(Str(nMoeda,2)) + " AND "
cString += "E1_SALDO > 0 "

#ELSE // Ambiente sem TOPCONNECT

cString := 'E1_FILIAL=="' + cFilial+ '".And.' 
cString += 'DTOS(E1_VENCREA)>="' + DTOS(dVenIni450) + '".And.'
cString += 'DTOS(E1_VENCREA)<="' + DTOS(dVenFim450) + '".And.'

// Se nao considera titulos transferidos, filtra (exibe) apenas os titulos que estao em carteira.
If mv_par03 == 2

cString += 'E1_SITUACA$"0FG".And.'

Endif 
cString += 'E1_MOEDA=' + Alltrim(Str(nMoeda,2)) + '.And.'
cString += 'E1_SALDO >0'

#ENDIF
Return( cString )