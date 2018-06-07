#include "PROTHEUS.CH"  
#include "TBICONN.CH" 

#DEFINE WF_URL 			"http://127.0.0.1:8089/wf"
#DEFINE WF_DESTINATARIO "aryane.sousa@totvs.com.br"
#DEFINE WF_EMPRESA 		"99"
#DEFINE WF_FILIAL 		"01"

//-------------------------------------------------------------------
/*/{Protheus.doc} wfExemplo    
Função de exemplo de utilização da classe TWFProcess. 

@author 	Valdiney V GOMES
@since     	11/02/2014
@version 	11
/*/
//-------------------------------------------------------------------  
User Function wfExemploa()
	Local oProcess 	:= Nil							
	Local cMailId 	:= ""							
	Local cHostWF	:= WF_URL						
	Local cTo 		:= WF_DESTINATARIO 	
	
	PREPARE ENVIRONMENT EMPRESA WF_EMPRESA FILIAL WF_FILIAL    
	
	//-------------------------------------------------------------------
	// "FORMULARIO"
	//-------------------------------------------------------------------  	

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
		                           
	//-------------------------------------------------------------------
	// Informamos em qual diretório será gerado o formulário.  
	//-------------------------------------------------------------------  	 
	oProcess:cTo 		:= "HTML"    
	
	//-------------------------------------------------------------------
	// Parâmetros livres.   
	//-------------------------------------------------------------------  	
	aAdd( oProcess:aParams, 'Coloco o que eu quiser aqui!' )
	
	//-------------------------------------------------------------------
	// Informamos qual função será executada no evento de timeout.  
	//-------------------------------------------------------------------  	
	oProcess:bTimeOut 	:= {{"u_wfTimeout()", 0, 0, 5 }}

	//-------------------------------------------------------------------
	// Informamos qual função será executada no evento de retorno.   
	//-------------------------------------------------------------------  	
	oProcess:bReturn 	:= "u_wfRetorno()"

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
	// Atribuímos valor a um dos campos do formulário.  
	//------------------------------------------------------------------- 
	oProcess:oHtml:ValByName("A_LINK", cHostWF + "/messenger/emp" + cEmpAnt + "/HTML/" + cMailId + ".htm") 
	
	//-------------------------------------------------------------------
	// Informamos o destinatário do email contendo o link.  
	//------------------------------------------------------------------- 	
	oProcess:cTo 		:= cTo   
	
	//-------------------------------------------------------------------
	// Informamos o assunto do email.  
	//------------------------------------------------------------------- 	
	oProcess:cSubject	:= "Workflow via link."

	//-------------------------------------------------------------------
	// Iniciamos a tarefa e enviamos o email ao destinatário.
	//------------------------------------------------------------------- 	
	oProcess:Start()                                                            		
Return    

//-------------------------------------------------------------------
/*/{Protheus.doc} wfRetorno    
Função executada no retorno do processo. 

@param 	   	poProcess Objeto do processo em execução.	 
@author 	Valdiney V GOMES
@since     	12/03/2012
@version 	10
/*/
//-------------------------------------------------------------------       
User Function wfRetorno( poProcess )  
	Local cTime 	:= ""
	Local cProcesso := ""  
	Local cTarefa	:= ""  
	Local cMailID	:= "" 
	Local cRetorno	:= ""
	
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
	// Recuperamos as informações dos checkboxes.
	//-------------------------------------------------------------------                    
	If !( poProcess:oHtml:RetByName("A") == Nil )
		cRetorno += 'Marcou: Opção A' + CRLF
	Else 
		cRetorno += 'Não Marcou: Opção A' + CRLF
	EndIf     

	If !( poProcess:oHtml:RetByName("B") == Nil )
		cRetorno += 'Marcou: Opção B' + CRLF
	Else 
		cRetorno += 'Não Marcou: Opção B' + CRLF
	EndIf     
  
  	//-------------------------------------------------------------------
	// Parâmetro livre.
	//-------------------------------------------------------------------   
	cRetorno  += 'Conteúdo do parâmetro livre:' + poProcess:aParams[1] + CRLF

	//-------------------------------------------------------------------
	// Exibe mensagem com dados do processamento no console.
	//-------------------------------------------------------------------    
	cRetorno += 'Retorno do processo gerado às : ' + cTime + CRLF  
 	cRetorno += 'Número: ' + cProcesso + ' ' + poProcess:oHtml:RetByName("WFMAILID") + CRLF  
 	cRetorno += 'Tarefa : ' + cTarefa + CRLF  
     
	QQOut( cRetorno )
Return Nil    

//-------------------------------------------------------------------
/*/{Protheus.doc} wfTimeout    
Função executada no timeout do processo. 

@param 	   	poProcess Objeto do processo em execução.	 
@author 	Valdiney V GOMES
@since     	12/03/2012
@version 	10
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

@author 	Valdiney V GOMES
@since     	12/03/2012
@version 	10
/*/
//-------------------------------------------------------------------
User Function WFPE007()
	Local cHTML 		:= ""
	Local plSuccess		:= ParamIXB[1] 
	Local pcMessage  	:= ParamIXB[2]	
	Local pcProcessID  	:= ParamIXB[3]
	
	If ( plSuccess ) 
		//-------------------------------------------------------------------
		// Mensagem em formato HTML para sucesso no processamento. 
		//-------------------------------------------------------------------  
		
      	cHTML += '<h1>'
      	cHTML += '   <img alt="" src="http://www.totvs.com/sites/all/themes/totvs/logo.png" style="width: 152px; height: 49px;" />'
      	cHTML += '</h1>'
      	cHTML += '<p style="text-align: center;">'
      	cHTML += '   <span style="color:#5cbfe2;">'
      	cHTML += '   	<span style="font-size:20px;">'
      	cHTML += '   		<span style="font-family:verdana,geneva,sans-serif;">Obrigado!</span>'
      	cHTML += '   	</span>'
      	cHTML += '   </span>'
      	cHTML += '</p>'		
	Else    
	   
		//-------------------------------------------------------------------
		// Mensagem em formato HTML para falha no processamento. 
		//------------------------------------------------------------------- 
      	cHTML += '<h1>'
      	cHTML += '   <img alt="" src="http://www.totvs.com/sites/all/themes/totvs/logo.png" style="width: 152px; height: 49px;" />'
      	cHTML += '</h1>'
      	cHTML += '<p style="text-align: center;">'
      	cHTML += '   <span style="color:#5cbfe2;">'
      	cHTML += '   	<span style="font-size:20px;">'
      	cHTML += '   		<span style="font-family:verdana,geneva,sans-serif;"> Desculpe, não conseguimos processar a resposta!</span>'
      	cHTML += '   	</span>'
      	cHTML += '   </span>'
      	cHTML += '</p>'		
	EndIf
Return cHTML