#include 'protheus.ch'
#include 'parmtype.ch'


User Function FI040ROT()

Local aRotina := {PARAMIXB[2],PARAMIXB[3],PARAMIXB[4],PARAMIXB[5],PARAMIXB[6]}

Alert('Ponto de Entrada: FI040ROT'); 

aAdd( aRotina, {"Novo Menu", "fuction", 0, 7}) 


Return aRotina