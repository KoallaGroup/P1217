#include "PROTHEUS.CH"  
#include "TBICONN.CH" 

//-------------------------------------------------------------------
/*/{Protheus.doc} wfExemplo    
Função de exemplo de utilização da classe TWFProcess. 
/*/
//-------------------------------------------------------------------  

User Function wfExemplo()

	Local oProcess 	:= Nil									//Objeto da classe TWFProcess.
	Local cMailId 	:= ""									//ID do processo gerado. 
	Local cHostWF		:= "http://localhost:81/wf"			//URL configurado no ini para WF Link. 
	Local cTo 			:= "rodrigo.gsoares@totvs.com.br;rodrigoguimaraessoares@msn.com" //Destinatário de email.
	Local cCC 			:= "rodrigoguimaraessoares@msn.com" 		//Destinatário cópia de email.    
	
	
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" 
	
//	PREPARE ENVIRONMENT EMPRESA "T1" FILIAL "M SP 01 "  

//	PREPARE ENVIRONMENT EMPRESA "T1" FILIAL "D MG 01 "    
	
	//-------------------------------------------------------------------
	// "FORMULARIO"
	//-------------------------------------------------------------------  	
   conout("inicio")
	//-------------------------------------------------------------------
	// Instanciamos a classe TWFProcess informando o código e nome do processo.  
	//-------------------------------------------------------------------  
	
	oProcess := TWFProcess():New("000001", "Treinamento")

	//-------------------------------------------------------------------
	// Criamos a tafefa principal que será respondida pelo usuário.  
	//-------------------------------------------------------------------  
	oProcess:NewTask("FORMULARIO", "\Workflow\WF_FORM.html")

	//-------------------------------------------------------------------
	// Atribuímos valor a um dos campos do formulário.  
	//-------------------------------------------------------------------  	   
	oProcess:oHtml:ValByName("TEXT_TIME", Time() )
	
	//teste
	oProcess:oHtml:ValByName('EMP', SM0->M0_CODIGO)
	
	oProcess:oHtml:ValByName('FIL', SM0->M0_CODFIL)	
	
	oProcess:oHtml:ValByName("WFMailTo", 'rodrigo.gsoares@totvs.com.br' )
	
	//termino
	oProcess:oHtml:ValByName("TEXT_TEXTO", "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111112132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132132121322132132132121321321321213213213213213213213212132132132132213213213132216546549841618136549813251681354421691321513216412,654216543216512346513654216513246913246513216514345651641651064165165465168411654171065147651" )
	                           
	//-------------------------------------------------------------------
	// Informamos em qual diretório será gerado o formulário.  
	//-------------------------------------------------------------------  	 
	oProcess:cTo 		:= "HTML"    

	//-------------------------------------------------------------------
	// Informamos qual função será executada no evento de timeout.  
	//-------------------------------------------------------------------  	
	oProcess:bTimeOut 	:= {{"u_wfTimeout()", 0, 0, 5 }}

	//-------------------------------------------------------------------
	// Informamos qual função será executada no evento de retorno.   
	//-------------------------------------------------------------------  	
	oProcess:bReturn 	:= "u_wfExemplo()"

	//-------------------------------------------------------------------
	// Iniciamos a tarefa e recuperamos o nome do arquivo gerado.   
	//-------------------------------------------------------------------  
	
	cMailID := oProcess:Start()     

    conout(cvaltochar(cMailID))
	//-------------------------------------------------------------------
	// "LINK"
	//------------------------------------------------------------------- 
    
	//-------------------------------------------------------------------
	// Criamos o ling para o arquivo que foi gerado na tarefa anterior.  
	//------------------------------------------------------------------- 	
	oProcess:NewTask("LINK", "\workflow\WF_LINK.html")
	
	//-------------------------------------------------------------------
	// Atribuímos valor a um dos campos do formulário.  
	//------------------------------------------------------------------- 
	oProcess:oHtml:ValByName("A_LINK", cHostWF + "/messenger/emp" + cEmpAnt + "/html/" + cMailId + ".htm") 
	
	//-------------------------------------------------------------------
	// Informamos o destinatário do email contendo o link.  
	//------------------------------------------------------------------- 	
	oProcess:cTo 		:= cTo  
	//oProcess:cCC 		:= cCC   
	
	//-------------------------------------------------------------------
	// Informamos o assunto do email.  
	//------------------------------------------------------------------- 	
	oProcess:cSubject	:= "Workflow via link Protheus 11.8."

	//-------------------------------------------------------------------
	// Iniciamos a tarefa e enviamos o email ao destinatário.
	//------------------------------------------------------------------- 	
	oProcess:Start()
	
                                     		
Return    

//-------------------------------------------------------------------
/*/{Protheus.doc} wfRetorno    
Função executada no retorno do processo. 

/*/
//-------------------------------------------------------------------       
User Function wfRetorno( poProcess )  
	Local cTime 		:= ""
	Local cProcesso 	:= ""  
	Local cTarefa		:= ""  
	Local cMailID		:= ""
	
	//-------------------------------------------------------------------
	// Recuperamos a hora do processo utilizando o método RetByName.
	//------------------------------------------------------------------- 		
	cTime 		:= poProcess:oHtml:RetByName("TEXT_TIME") 
     
 	//-------------------------------------------------------------------
	// Recuperamos o identificador do email utilizando o método RetByName.
	//------------------------------------------------------------------- 		
	cMailID		:= poProcess:oHtml:RetByName("WFMAILID") 
  
	//-------------------------------------------------------------------
	// Recuperamos o ID do processo através do atributo do processo.
	//------------------------------------------------------------------- 		
	cProcesso 	:= poProcess:FProcessID  
 
	//-------------------------------------------------------------------
	// Recuperamos o ID da tarefa através do atributo do processo.
	//------------------------------------------------------------------- 	 
	cTarefa		:= poProcess:FTaskID  

	//-------------------------------------------------------------------
	// Exibe mensagem com dados do processamento no console.
	//-------------------------------------------------------------------                  
	Conout('Retorno do processo gerado às ' + cTime + " número " + cProcesso + ' ' + poProcess:oHtml:RetByName("WFMAILID") + ' tarefa ' + cTarefa + ' executado com sucesso!')
Return Nil    

//-------------------------------------------------------------------
/*/{Protheus.doc} wfTimeout    
Função executada no timeout do processo. 

/*/
//-------------------------------------------------------------------
User Function wfTimeout( poProcess )  
	//-------------------------------------------------------------------
	// Exibe mensagem com dados do processamento no console.
	//-------------------------------------------------------------------               
	Conout('Timeout do processo' + poProcess:FProcessID)  
Return Nil    

//-------------------------------------------------------------------
/*/{Protheus.doc} WFPE007    
Permite customizar a mensagem de processamento do WF por link. 

/*/
//-------------------------------------------------------------------
User Function WFPE007()

	Local cHTML 			:= ""
	Local plSuccess		:= ParamIXB[1] 
	Local pcMessage  		:= ParamIXB[2]	
	Local pcProcessID  	:= ParamIXB[3]
	
	If ( plSuccess ) 
		//-------------------------------------------------------------------
		// Mensagem em formato HTML para sucesso no processamento. 
		//------------------------------------------------------------------- 
    	cHTML += 'Processamento executado com sucesso!'
    	cHTML += '<br>'
    	cHTML += pcMessage
	Else       
		//-------------------------------------------------------------------
		// Mensagem em formato HTML para falha no processamento. 
		//------------------------------------------------------------------- 
		cHTML += 'Falha no processamento!'
    	cHTML += '<br>'
    	cHTML += pcMessage
	EndIf
	
	conout('FIM')
	//RESET ENVIRONMENT
	//RpcClearEnv()
	
Return cHTML