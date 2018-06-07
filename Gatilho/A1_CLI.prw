#include 'protheus.ch'
#include 'parmtype.ch'

user function C5_CLI()


Local cRet := M->A1_BAIRRO


M->A1_NOME = "TESTE" 


If ExistTrigger('A1_NOME') 
      RunTrigger(1,nil,nil,,'A1_NOME')
Endif     

Return .t.



/****utilizando no aCols *****
If ExistTrigger('C6_PRODUTO') 
// verifica se existe trigger para este campo      
RunTrigger(2,nLin,nil,,'C6_PRODUTO')
Endif	 
/****utilizando na Enchoice *****
If ExistTrigger('C5_CLIENTE')      
RunTrigger(1,nil,nil,,'C5_CLIENTE')

Endif*/
