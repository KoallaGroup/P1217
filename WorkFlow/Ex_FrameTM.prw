#INCLUDE "PROTHEUS.CH" 
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH" 
#INCLUDE "TBICONN.CH"
#include "ap5mail.ch"

User Function tstmailsmtp()

Local oServer
Local oMessage
Local cBody := "" 

//PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01" 

oServer := TMailManager():New()
  
//SSL .T.
//oServer:SetUseSSL( .T. ) //GMail
oServer:SetUseTLS(.T.)
  
oServer:Init( "", "smtplw.com.br", "nucleo@totvs-ibirapuera.com.br","nucleo@123", 0, 587 )
   
//seta um tempo de time out com servidor de 1min
If oServer:SetSmtpTimeOut( 1000 ) != 0
                Conout( "Falha ao setar o time out" )
                Return .F.
EndIf
   
//realiza a conexão SMTP
If oServer:SmtpConnect() != 0
                Conout( "Falha ao conectar" )
    Return .F.
EndIf
   
// Autentica quando for GMail
nAuth := oServer:SMTPAuth("nucleo@totvs-ibirapuera.com.br“,”nucleo@123")

If nAuth != 0
            Conout( "Falha ao autenticar" )
   Return .F.
EndIf

//Apos a conexão, cria o objeto da mensagem
oMessage := TMailMessage():New()
   
//Limpa o objeto
oMessage:Clear()

oMessage:cFrom              := "rodrigo.gsoares@totvs.com.br"
oMessage:cTo                := "rodrigo.gsoares@totvs.com.br"
oMessage:cSubject           := "Teste de Email - Frame"
oMessage:cBody              := "Teste"
   
//Envia o e-mail
If oMessage:Send( oServer ) != 0
                Conout( "Erro ao enviar o e-mail" )
    Return .F.
EndIf
   
//Desconecta do servidor
If oServer:SmtpDisconnect() != 0
                Conout( "Erro ao disconectar do servidor SMTP" )
    Return .F.
EndIf

//RESET ENVIRONMENT

Return .T.
