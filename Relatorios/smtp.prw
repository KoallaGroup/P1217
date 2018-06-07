#include "protheus.ch"
#include "topconn.ch"
#include "tbiconn.ch"


User Function xTESTE()
Local cHtml       := ""
Local cAccount    := ""
Local cServer     := ""
Local cPass       := ""  
Local lRet        := .T.

cAccount := "rodrigoguimaraessoares@gmail.com"// Conta de Envio de Relatorios por e-mail do acr
cServer  := "mail.gmail.com.br:587"// IP do Servidor de e-mails //'smtp.microsiga.com.br'
cPass    := "Julia1305" // Senha da Conta de e-mail

cEmail   := "rodrigo.gsoares@totvs.com.br" //destinatario

cAssunto := "Teste E-mail WorkFlow" // Assunto

/*Mensagem*/
_cBody  := "Prezado(a) TESTE"+Chr(13)+Chr(10)+Chr(13)+Chr(10)
_cBody  += "Informamos que seu Pedido de Compras Nr. 001410 foi aprovado."
_cBody  += Chr(13)+Chr(10)+Chr(13)+Chr(10)
_cBody  += "Obs: SOMENTE TESTE"



CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPass RESULT lResult
If !lResult
   conout('Erro de conexao ')                        
   Return .F.
EndIf    

If ! MailAuth(cAccount,cPass)
   ConOut(OemToAnsi("Falha na Autenticação do Usuário no Provedor de E-mail")+" no ambiente "+GetEnvServer()+" -> " + Time())
   DISCONNECT SMTP SERVER
   Return .F.
else
   SEND MAIL FROM cAccount TO cEmail SUBJECT cAssunto BODY _cBody
   MsgStop("E-mail enviado")
EndIf

DISCONNECT SMTP SERVER RESULT lOk
If  !lOk
    GET MAIL ERROR cErro
    conout('Erro de Desconexao :'+ cErro)                        
    lRet := .F.
EndIf


Return
