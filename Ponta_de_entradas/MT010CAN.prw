#include 'protheus.ch'
#include 'parmtype.ch'

user function MT010CAN()


Local nOpc := ParamIxb[1]

//Inclusão / Alteração de produtos

  IF(nOpc == 1)
  alert("Função executada OK.")
  ELSEIF(nOpc == 3)
  alert("Função Cancelada.")
  ENDIF
  
  
  

return