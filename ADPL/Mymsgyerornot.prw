#include 'protheus.ch'
#include 'parmtype.ch'

user function MyMsgYesNo()

Local cMsg := "Pergunta que ser� feita para usu�rio."  + Chr(13) + Chr(10) + Chr(13) + Chr(10) +"Testando v�rias linhas" + Chr(13) + Chr(10) + Chr(13) + Chr(10) +"Testando v�rias linhas"




Local cCaption := "Teste do ApMsgYesNo"

If ApMsgYesNo(cMsg, cCaption) 	//Op��o que ser� habilitada se o usu�rio clicar no bot�o "Yes"	

ApMsgInfo("O usu�rio aceitou a condi��o")

Else                                                    	//Op��o que ser� habilitada se o usu�rio clicar no bot�o "No"	
ApMsgInfo("O usu�rio n�o aceitou a condi��o")

EndIf




If MsgYesNo(cMsg, cCaption) 	//Op��o que ser� habilitada se o usu�rio clicar no bot�o "Yes"

ApMsgInfo("O usu�rio aceitou a condi��o")

Else                                                    	//Op��o que ser� habilitada se o usu�rio clicar no bot�o "No"	
ApMsgInfo("O usu�rio n�o aceitou a condi��o")

EndIf

return

iIF(FunName()=="MATA410", .t.,.f.)