#include 'protheus.ch'
#include 'parmtype.ch'

user function SE5FI080()

 Local aRest := PARAMIXB
 
   RecLock('SE5',.F.)
   If SE5->E5_TIPODOC == 'NF' // Desconto
      SE5->E5_HISTOR := RTrim(SE5->E5_HISTOR) + ' - Desconto'
   ElseIf SE5->E5_TIPODOC == 'JR' // Juros
      SE5->E5_HISTOR := RTrim(SE5->E5_HISTOR) + ' - Juros'
   ElseIf SE5->E5_TIPODOC == 'MT' // Multa
      SE5->E5_HISTOR := RTrim(SE5->E5_HISTOR) + ' - Multa'
   ElseIf SE5->E5_TIPODOC == 'CM' // Correcao Monetaria
      SE5->E5_HISTOR := RTrim(SE5->E5_HISTOR) + ' - Correcao'
   ElseIf SE5->E5_TIPODOC == 'IS' // Imposto Substituicao
      SE5->E5_HISTOR := RTrim(SE5->E5_HISTOR) + ' - Imposto Substituicao'
   ElseIf SE5->E5_TIPODOC $ 'VL/BA' // Valor Pagamento
      SE5->E5_HISTOR := RTrim(SE5->E5_HISTOR) + ' - Valor Pagamento'
   EndIf
   SE5->(MsUnlock())
   
   
   Return
