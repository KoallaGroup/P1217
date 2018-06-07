#include 'protheus.ch'
#include 'parmtype.ch'


User Function MATA094() 
Local aParam := PARAMIXB
Local xRet := .T.
Local oObj := ''
Local cIdPonto := ''
Local cIdModel := ''
Local lIsGrid := .F.

Local nLinha := 0
Local nQtdLinhas := 0
Local cMsg := ''


If aParam <> NIL

oObj := aParam[1]
cIdPonto := aParam[2]
cIdModel := aParam[3]
�lIsGrid := ( Len( aParam ) > 3 )

//If lIsGrid
�// nQtdLinhas := oObj:GetQtdLine()
�// nLinha := oObj:nLine
//EndIf

If cIdPonto == 'MODELPOS'
�cMsg := 'Chamada na valida��o total do modelo.' + CRLF
�cMsg += 'ID ' + cIdModel + CRLF

�xRet := ApMsgYesNo( cMsg + 'Continua ?' )

ElseIf cIdPonto == 'FORMPOS'
				Help(,,"MATA180",,"Testando a invalida��o do formul�rio",1,0)
				xRet := .F.

�If lIsGrid
�cMsg += '� um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ' linha(s).' + CRLF
�cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha ) ) + CRLF
�Else
�cMsg += '� um FORMFIELD' + CRLF
�EndIf

�xRet := ApMsgYesNo( cMsg + 'Continua ?' )

ElseIf cIdPonto == 'FORMLINEPRE'
�If aParam[5] == 'DELETE'
�cMsg := 'Chamada na pre valida��o da linha do formul�rio. ' + CRLF
�cMsg += 'Onde esta se tentando deletar a linha' + CRLF
�cMsg += 'ID ' + cIdModel + CRLF
�cMsg += '� um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ' linha(s).' + CRLF
�cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha ) ) + CRLF
�xRet := ApMsgYesNo( cMsg + 'Continua ?' )
�EndIf

ElseIf cIdPonto == 'FORMLINEPOS'
�cMsg := 'Chamada na valida��o da linha do formul�rio.' + CRLF
�cMsg += 'ID ' + cIdModel + CRLF
�cMsg += '� um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ' linha(s).' + CRLF
�cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha ) ) + CRLF
�xRet := ApMsgYesNo( cMsg + 'Continua ?' )

ElseIf cIdPonto == 'MODELCOMMITTTS'
�ApMsgInfo('Chamada apos a grava��o total do modelo e dentro da transa��o.')

ElseIf cIdPonto == 'MODELCOMMITNTTS'
�ApMsgInfo('Chamada apos a grava��o total do modelo e fora da transa��o.')

ElseIf cIdPonto == 'FORMCOMMITTTSPRE'
�ApMsgInfo('Chamada apos a grava��o da tabela do formul�rio.')

ElseIf cIdPonto == 'FORMCOMMITTTSPOS'
�ApMsgInfo('Chamada apos a grava��o da tabela do formul�rio.')

ElseIf cIdPonto == 'MODELCANCEL'
�cMsg := 'Deseja Realmente Sair ?'
�xRet := ApMsgYesNo( cMsg )

ElseIf cIdPonto == 'BUTTONBAR'
xRet := { {'Salvar', 'SALVAR', { || u_TESTEX() } } }

EndIf

EndIf

Return xRet	


