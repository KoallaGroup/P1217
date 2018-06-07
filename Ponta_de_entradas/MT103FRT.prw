#include 'protheus.ch'
#include 'parmtype.ch'

user function MT103FRT()
	
aFilial := {}
nRegSM0 := SM0->(RECNO())
cEmpAtu := SM0->M0_CODIGO
cCnpj	  := SM0->M0_CGC
aArea := GetArea()

dbselectArea ("SM0")
dbGoTop()

While !Eof() .and. SM0->M0_CODIGO == cEmpAtu   

If SM0->M0_CGC == cCnpj      
   AADD(AFILIAL,SM0->M0_CODFIL)   
Endif   
dbSkip()
Enddo


SM0->(dbGoto(nRegSM0))

Return (aFilial)	