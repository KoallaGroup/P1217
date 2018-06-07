#include 'protheus.ch'
#include 'parmtype.ch'

user function MyMsgYesNo()

Local cMsg := "Pergunta que será feita para usuário."  + Chr(13) + Chr(10) + Chr(13) + Chr(10) +"Testando várias linhas" + Chr(13) + Chr(10) + Chr(13) + Chr(10) +"Testando várias linhas"




Local cCaption := "Teste do ApMsgYesNo"

If ApMsgYesNo(cMsg, cCaption) 	//Opção que será habilitada se o usuário clicar no botão "Yes"	

ApMsgInfo("O usuário aceitou a condição")

Else                                                    	//Opção que será habilitada se o usuário clicar no botão "No"	
ApMsgInfo("O usuário não aceitou a condição")

EndIf




If MsgYesNo(cMsg, cCaption) 	//Opção que será habilitada se o usuário clicar no botão "Yes"

ApMsgInfo("O usuário aceitou a condição")

Else                                                    	//Opção que será habilitada se o usuário clicar no botão "No"	
ApMsgInfo("O usuário não aceitou a condição")

EndIf

return

iIF(FunName()=="MATA410", .t.,.f.)