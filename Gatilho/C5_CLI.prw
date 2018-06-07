#include 'protheus.ch'
#include 'parmtype.ch'

user function C5_CLI()


Local cRet := M->C5_CLIENTE

M->C5_VEND2 := M->C5_CLIENTE


If ExistTrigger('C5_VEND2') 
      RunTrigger(1,nil,nil,,'C5_VEND2')
Endif     

Return(cRet)


/****utilizando no aCols *****
If ExistTrigger('C6_PRODUTO') 
// verifica se existe trigger para este campo      
RunTrigger(2,nLin,nil,,'C6_PRODUTO')
Endif	 
/****utilizando na Enchoice *****
If ExistTrigger('C5_CLIENTE')      
RunTrigger(1,nil,nil,,'C5_CLIENTE')

Endif*/
