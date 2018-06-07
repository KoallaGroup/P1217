#include 'protheus.ch'
#include 'parmtype.ch'

User Function MT120F()

Local cPedido  :=  PARAMIXB
dBselectArea('SC7')
dbSetOrder(1)
dbSeek(cPedido)


//alert("Passou pelo MT120F")

dBselectArea('SCR')
dbSetOrder(1)
 IF dbSeek('01'+'PC'+SUBSTR(cPedido,3))
  alert("Encontrou SRC")
  
 ENDIF
 alert("Passou pelo PE")


Return 