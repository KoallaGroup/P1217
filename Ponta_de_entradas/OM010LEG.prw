#include 'protheus.ch'

User Function OM010LEG()

Local aLegenda := aClone(PARAMIXB)

Alert ("Passou pelo aLegenda")


Aadd(aLegenda,{"BR_AMARELO","Promo��o VIP"}) //Ativa promo��o VIP

Return(aCores)