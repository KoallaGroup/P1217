#include "PROTHEUS.CH"  
#include "TBICONN.CH" 

#DEFINE WF_URL 			"http://127.0.0.1:8089/wf"
#DEFINE WF_EMPRESA 		"01"
#DEFINE WF_FILIAL 		"01"

//-------------------------------------------------------------------
/*/{Protheus.doc} WFApprover    
Permite customizar a mensagem de processamento do WF por link. 

@author 	Valdiney V GOMES
@since     	16/10/2014
@version 	11
/*/
//-------------------------------------------------------------------
User Function WFApprover() 
	Local aApprover 	:= {}
	Local oProcess	:= Nil 
	
	PREPARE ENVIRONMENT EMPRESA "T1" FILIAL "D MG 01 "   
		
	//-------------------------------------------------------------------
	// Define a lista e aprovadores.   
	//------------------------------------------------------------------- 	
	aAdd( aApprover, {"rodrigo@totvs.com.br", Nil } )
	aAdd( aApprover, {"rodrigo@totvs.com.br", Nil } )

	//-------------------------------------------------------------------
	// Inst�ncia a classe TWFProcess informando o c�digo e nome do processo.  
	//-------------------------------------------------------------------  
	oProcess := TWFProcess():New( "000001", "Treinamento" )
	
	//-------------------------------------------------------------------
	// Grava a lista de aprovadores nos par�metros livres.   
	//-------------------------------------------------------------------  	
	aAdd( oProcess:aParams, aClone( aApprover ) )

	//-------------------------------------------------------------------
	// Define as tarefas do processo.   
	//------------------------------------------------------------------- 
	u_WFTask( oProcess )
Return 

//-------------------------------------------------------------------
/*/{Protheus.doc} WFTask    
Fun��o de exemplo de utiliza��o da classe TWFProcess. 

@author 	Valdiney V GOMES
@since     	11/02/2014
@version 	11
/*/
//-------------------------------------------------------------------  
User Function WFTask( oProcess )	
	Local aApprover 	:= oProcess:aParams[1]	
	Local cApprover	:= u_WFNextApprover( aApprover )	
	Local cHostWF		:= WF_URL		
	Local cMailId 	:= ""	
	Local cDone		:= ""
	Local cPending	:= ""	
	Local nApprover	:= 0

	//-------------------------------------------------------------------
	// Lista os aprovadores do processo.  
	//------------------------------------------------------------------- 		
	For nApprover := 1 To Len( aApprover )
		If ( aApprover[nApprover][2] == Nil )
			cPending 	+= aApprover[nApprover][1] + "<br>"
		Else
			cDone 		+= aApprover[nApprover][1] + "<br>"	
		EndIf 
	Next nApprover
	
	//-------------------------------------------------------------------
	// Verifica se tem um pr�ximo aprovador.  
	//------------------------------------------------------------------- 
	If ! ( Empty( cApprover ) )		
		//-------------------------------------------------------------------
		// "FORMULARIO"
		//-------------------------------------------------------------------  	

		//-------------------------------------------------------------------
		// Criamos a tafefa principal que ser� respondida pelo usu�rio.  
		//-------------------------------------------------------------------  
		oProcess:NewTask("FORMULARIO", "\Workflow\WF_FORM.html")
	
		//-------------------------------------------------------------------
		// Atribu�mos valor aos campos do formul�rio.  
		//-------------------------------------------------------------------  	   
		oProcess:oHtml:ValByName("TEXT_TIME"		, Time() )   
		oProcess:oHtml:ValByName("TEXT_ALL"		, cDone + cPending ) 
		oProcess:oHtml:ValByName("TEXT_DONE"		, cDone ) 
		oProcess:oHtml:ValByName("TEXT_PENDING"	, cPending) 	   
                          
		//-------------------------------------------------------------------
		// Informamos em qual diret�rio ser� gerado o formul�rio.  
		//-------------------------------------------------------------------  	 
		oProcess:cTo 			:= "HTML"    
			
		//-------------------------------------------------------------------
		// Informamos qual fun��o ser� executada no evento de timeout.  
		//-------------------------------------------------------------------  	
		oProcess:bTimeOut 	:= {{"u_wfTimeout()", 1, 0, 0 }}
	
		//-------------------------------------------------------------------
		// Informamos qual fun��o ser� executada no evento de retorno.   
		//-------------------------------------------------------------------  	
		oProcess:bReturn 		:= "u_WFReturn()"

		//-------------------------------------------------------------------
		// Iniciamos a tarefa e recuperamos o nome do arquivo gerado.   
		//-------------------------------------------------------------------  
		cMailID := oProcess:Start()     
	
		//-------------------------------------------------------------------
		// "LINK"
		//------------------------------------------------------------------- 
	
		//-------------------------------------------------------------------
		// Criamos o ling para o arquivo que foi gerado na tarefa anterior.  
		//------------------------------------------------------------------- 	
		oProcess:NewTask("LINK", "\workflow\WF_LINK.html")
		
		//-------------------------------------------------------------------
		// Atribu�mos valor a um dos campos do formul�rio.  
		//------------------------------------------------------------------- 
		oProcess:oHtml:ValByName("A_LINK", cHostWF + "/messenger/emp" + cEmpAnt + "/HTML/" + cMailId + ".htm") 
		
		//-------------------------------------------------------------------
		// Informamos o destinat�rio do email contendo o link.  
		//------------------------------------------------------------------- 
		oProcess:cTo 		:= cApprover  
	
		//-------------------------------------------------------------------
		// Informamos o assunto do email.  
		//------------------------------------------------------------------- 	
		oProcess:cSubject	:= "Workflow via link."
	
		//-------------------------------------------------------------------
		// Iniciamos a tarefa e enviamos o email ao destinat�rio.
		//------------------------------------------------------------------- 	
		oProcess:Start()
	EndIf                                                          		
Return    


//-------------------------------------------------------------------
/*/{Protheus.doc} WFReturn    
Fun��o executada no retorno do processo. 

@param 	   	poProcess Objeto do processo em execu��o.	 
@author 	Valdiney V GOMES
@since     	16/10/2014
@version 	11
/*/
//-------------------------------------------------------------------       
User Function WFReturn( poProcess )
	//-------------------------------------------------------------------
	// Regista a aprova��o no processo.
	//------------------------------------------------------------------- 
	u_WFAssent( poProcess )
	
	//-------------------------------------------------------------------
	// Envia a solicita��o para o pr�ximo aprovador.
	//------------------------------------------------------------------- 
	u_WFTask( poProcess )	
Return Nil    


//-------------------------------------------------------------------
/*/{Protheus.doc} wfTimeout    
Fun��o executada no timeout do processo. 

@param 	   	poProcess Objeto do processo em execu��o.	 
@author 	Valdiney V GOMES
@since     	16/10/2014
@version 	11
/*/
//-------------------------------------------------------------------
User Function WFTimeout( poProcess )  
	//-------------------------------------------------------------------
	// Exibe mensagem com dados do processamento no console.
	//-------------------------------------------------------------------               
	Conout('Timeout do processo' + poProcess:FProcessID)  
Return Nil    


//-------------------------------------------------------------------
/*/{Protheus.doc} WFApprover    
Verifica qual o pr�ximo aprovador do processo. 

@author 	Valdiney V GOMES
@since     	16/10/2014
@version 	11
/*/
//-------------------------------------------------------------------
User Function WFNextApprover( aApprover )
	Local nApprover 	:= 1
	Local cApprover	:= ""
	
	Default aApprover	:= {}
	
	If ! ( Len( aApprover ) == 0 )
		For nApprover := 1 To Len( aApprover )
			If ( aApprover[nApprover][2] == Nil )
				cApprover := aApprover[nApprover][1]
				Exit		
			EndIf 
		Next nApprover
	EndIf
Return cApprover


//-------------------------------------------------------------------
/*/{Protheus.doc} WFAssent    
Identifica os usu�rios que j� aprovaram o processo. 

@author 	Valdiney V GOMES
@since     	16/10/2014
@version 	11
/*/
//-------------------------------------------------------------------
User Function WFAssent( poProcess )
	Local nApprover 	:= 1
	Local aApprover	:= {} 
	
	Default poProcess	:= Nil
	
	If ! ( poProcess == Nil )	
		aApprover := poProcess:aParams[1]
		
		If ! ( Len( aApprover ) == 0 )
			For nApprover := 1 To Len( aApprover )
				If ( aApprover[nApprover][2] == Nil )
					aApprover[nApprover][2] := .T. 
					Exit
				EndIf 
			Next nApprover
		EndIf
	EndIf 
Return Nil 