#include 'protheus.ch'
#include 'parmtype.ch'

user function MA410COR()

Local aCores  := {}//PARAMIXB

Alert("MA410COR")

//aAdd(aCores , {"C5_TESTE == 'C'", "BLACK", "Teste 01"})// Nova condição
aAdd(aCores , {"Empty(C5_LIBEROK).And.Empty(C5_NOTA) .And. Empty(C5_BLQ)", "GREEN", "Pedido em Aberto"})
aAdd(aCores , {"!Empty(C5_NOTA).Or.C5_LIBEROK=='E' .And. Empty(C5_BLQ)", "GREEN", "Pedido em Aberto"})
aAdd(aCores , {"!Empty(C5_LIBEROK).And.Empty(C5_NOTA).And. Empty(C5_BLQ)", "BR_AMARELO", "Pedido Liberado"})
aAdd(aCores , {"C5_BLQ == '1'", "BR_AZUL", "Pedido Bloqueado por Regra"})
aAdd(aCores , {"C5_BLQ == '2'", "BR_LARANJA", "Pedido Bloqueado por Verba"})

Return aCores