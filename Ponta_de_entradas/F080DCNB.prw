#include 'protheus.ch'
#include 'parmtype.ch'

User Function F080DCNB()

Local aDisableFields := {}

alert("Passou pelo  PE F080CNB")

aAdd(aDisableFields, 'MULTA' )
aAdd(aDisableFields, 'DESCONTO' )
aAdd(aDisableFields, 'JUROS' )
aAdd(aDisableFields, 'DATABAIXA' )

Return(aDisableFields)