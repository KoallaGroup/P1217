#include 'protheus.ch'
#include 'parmtype.ch'

user function TstSaldTit()
local nSaldo

dbSelectArea('SE2')
dbsetorder(1)

dbSeek(xFilial('SE2')+"TST"+"000000001",.f.)//PREFIXO+NUM


//nSaldo := SaldoTit(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_NATUREZ,"P",SE2->E2_FORNECE,1,,,SE2->E2_LOJA,,0/*nTxMoeda*/)
nSaldo := Saldotit(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_NATUREZ,"P",SE2->E2_FORNECE,1,SE2->E2_EMISSAO,MV_PAR03,SE2->E2_LOJA,SE2->E2_FILIAL,.T.,,1)

Alert(nSaldo)

dbSeek(xFilial('SE2')+"UNI"+"300000001",.f.)//PREFIXO+NUM

nSaldo := SaldoTit(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_NATUREZ,"P",SE2->E2_FORNECE,1,,,SE2->E2_LOJA,,0/*nTxMoeda*/)
Alert(nSaldo)




Return