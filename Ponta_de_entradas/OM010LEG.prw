#include 'protheus.ch'

User Function OM010LEG()

Local aLegenda := aClone(PARAMIXB)

Alert ("Passou pelo aLegenda")


Aadd(aLegenda,{"BR_AMARELO","Promoção VIP"}) //Ativa promoção VIP

Return(aCores)