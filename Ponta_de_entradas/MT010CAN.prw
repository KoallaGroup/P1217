#include 'protheus.ch'
#include 'parmtype.ch'

user function MT010CAN()


Local nOpc := ParamIxb[1]

//Inclus�o / Altera��o de produtos

  IF(nOpc == 1)
  alert("Fun��o executada OK.")
  ELSEIF(nOpc == 3)
  alert("Fun��o Cancelada.")
  ENDIF
  
  
  

return