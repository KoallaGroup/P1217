#include 'protheus.ch'
#include 'parmtype.ch'

user function descend()

  DbSelectArea("SE1")
  //Depois, DESCEND() pode ser utilizado para fazer uma pesquisa (SEEK) no �ndice descendente:
  DbSEEK(DESCEND(DTOS(dFindDate)))
  
  