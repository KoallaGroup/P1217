#include 'protheus.ch'
#include 'parmtype.ch'

user function AF012EXC() 
Local lRet := .T.

//If Alltrim(SN1->N1_STATUS)$ "0" 
Help(,,"AF012EXC",,"Ativo fixo não pode ser excluido, pois foi gerado pelas rotinas de Cota Capital.",1,0) 
lRet := .F. 
//Endif

return lRet