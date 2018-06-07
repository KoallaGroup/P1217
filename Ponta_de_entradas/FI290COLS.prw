#include 'protheus.ch'
#include 'parmtype.ch'

User Function FI290COLS() // Indica o Array que será alterado: 1- aHeader; 2- aCols 


Local nTipo := PARAMIXB[1] // Array 
Local aRet := PARAMIXB[2] // Posição do Array 
Local nI := PARAMIXB[3] // Posição do Array aHeader 
Local nCount // Array com os campos a serem incluídos 
Local aColPE := {"E2_CODBAR","E2_SALDO","E2_ORIGEM","E2_DIRF","E2_CODRET "} // Condição utilizado para retornar o restante do aHeader 


If nTipo == 1 

	dbSelectArea("SX3") 
	dbSetOrder(2) 


    For nCount := 1 to len(aColPE) 
    DbSeek(aColPE[nCount]) 
    
    AADD(aRet,{ X3TITULO(aColPE[nCount]), aColPE[nCount], X3PICTURE(aColPE[nCount]), TamSx3(aColPE[nCount])[1] ,0,"","û",Posicione("SX3",2,aColPE[nCount],'X3_TIPO'),"SE2" } ) // "Cabeçalho do campo adicinado FI290Cols" 
    
    next // Ponto que Incrementa os valores das colunas 
    
Else 

	aAdd(aRet[nI],SE2->E2_CODBAR) //Novo campo Adicionado 
	aAdd(aRet[nI],SE2->E2_SALDO) //Novo campo Adicionado 
	aAdd(aRet[nI],SE2->E2_ORIGEM) //Novo campo Adicionado 
	aAdd(aRet[nI],SE2->E2_DIRF) //Novo campo Adicionado 
	aAdd(aRet[nI],SE2->E2_CODRET) //Novo campo Adicionado 	
	//Identifica se o registro esta deletado 
	//Esta posição deve ser adicionada sempre que 
	//criado o ponto de entrada 
	AaDD(aRet[nI],.F.) 
	
EndIF 
	
Return aRet