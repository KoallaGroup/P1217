#include 'protheus.ch'

User Function OM010COR()

Local aCores:={}
Local aCores := aClone(PARAMIXB)

Alert ("Passou pelo aCores")


Aadd(aCores,{"(Dtos(DA0_DATATE) >= Dtos(dDataBase) .Or. Empty(Dtos(DA0_DATATE))) .And.DA0_ATIVO =='3'","BLUE","Promo��o VIP"}) //Ativa promo��o VIP

Return(aCores)

