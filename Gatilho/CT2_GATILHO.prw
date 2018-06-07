#include 'protheus.ch'
#include 'parmtype.ch'

user function CT2_GATILHO()
	
Local cRet := M->CT2_DEBITO

//M->C5_VEND2 := M->C5_CLIENTE

/*If ExistTrigger('C5_VEND2') 
      RunTrigger(1,nil,nil,,'C5_VEND2')
Endif */    

Return(cRet)