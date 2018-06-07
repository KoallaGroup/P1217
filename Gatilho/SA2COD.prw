#include 'protheus.ch'
#include 'parmtype.ch'
#include "tbiconn.ch"

user function SA2COD()

Local cRet 


 dbSelectArea("SA1")
 dbSetOrder(1)
 MsSeek(xFilial("SA1")+M->A2_COD+M->A2_LOJA)


cRet := Sa1->a1_nome

Return(cRet)

	
!__lSX8