#include 'protheus.ch'
#include 'parmtype.ch'

user function tstPswname() 

 Local lRet := .F.
 Local cUsuVld := AllTrim('rodrigo') //Nome do usuario
 Local cPassWor  := allTrim('96064812') //senha do usuario

//    Local cUsuVld := AllTrim('SENHA2') //Nome do usuario
//    Local cPassWor  := allTrim('totvs123') //senha do usuario

 PswOrder(2)
 If     PswSeek(cUsuVld,.T.)
      If !PswName(cPassWor)//, .t.)
    MsgAlert("Senha incorreta! "+ cUsuVld)
           lRet := .F.
      Else
        MsgAlert("Usuário OK! " + cUsuVld)
           lRet := .T.
      EndIf
 Else
      MsgAlert("Código de usuário não existe")
      lRet := .F.
 EndIf

Return lRet 


/*
Local _lOk      :=.f.
Local _cGetUser := cUserName
Local _cGetPass := Space(100)
Local _lCerto:= .F.

DEFINE MSDIALOG _oDlgTlBlq TITLE "Tela Bloqueada" FROM 000, 000  TO 140, 325 COLORS 0, 16777215 PIXEL
@ 002, 005 GROUP _oGrpUsrPs TO 046, 158 PROMPT "" OF _oDlgTlBlq COLOR 0, 16777215 PIXEL
@ 013, 010 SAY _oSay1 PROMPT "Usuário" SIZE 025, 007 OF _oDlgTlBlq COLORS 0, 16777215 PIXEL
@ 011, 034 MSGET _oGetUser VAR _cGetUser SIZE 117, 010 OF _oDlgTlBlq COLORS 0, 16777215 PIXEL When .F.
@ 029, 010 SAY _oSay2 PROMPT "Senha" SIZE 022, 007 OF _oDlgTlBlq COLORS 0, 16777215 PIXEL
@ 029, 034 MSGET _oGetPass VAR _cGetPass SIZE 117, 010 OF _oDlgTlBlq COLORS 0, 16777215 PASSWORD PIXEL
@ 049, 119 BUTTON _oBtnOK PROMPT "&OK" SIZE 037, 012 OF _oDlgTlBlq ACTION eval({|| _lOk:=.T.,_lCerto:=.F.,_oDlgTlBlq:End() }) PIXEL
ACTIVATE MSDIALOG _oDlgTlBlq CENTERED

If _lOk
	
	PswOrder(2)
	If PswSeek(AllTrim(_cGetUser),.T.)
		
		If pswname(AllTrim(_cGetPass))
			_lCerto := .T.
		Else
			_lCerto := .F.
			Help(" ",1,"NORECNO",,"Senha informada não é valida. Tente novamente.",1,0)
		Endif
		
	Else
		_lCerto := .F.
		Help(" ",1,"NORECNO",,"Usuário informado não é valido. Verifique se a sintaxe esta correta.",1,0)
	Endif
	
Endif

PswOrder(1)
PswSeek(__CUSERID,.T.)

Return _lCerto
*/
