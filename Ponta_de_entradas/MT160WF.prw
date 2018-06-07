#include 'protheus.ch'
#include 'parmtype.ch'

User Function MT160WF()

Local aResult    := {}

local cNum := SC7->C7_NUM
local cItem := SC7->C7_ITEM


local cNum2 := SC8->C8_NUM
local cItem2 := SC8->C8_ITEM


//-- Gera notificacao - Encerramento de cotacao



conout("Valores da Tabela SC7"+cvaltochar(cNum)+"   "+cvaltochar(cItem))
conout("Valores da Tabela SC8"+cvaltochar(cNum2)+"   "+cvaltochar(cItem2))


alert ("Passou pelo ponto MT160WF") 

/*
Local aResult    := {}

//-- Gera notificacao - Encerramento de cotacao

If ExistProc('NOTENC')     


aResult:= TCSPExec( xProcedures('NOTENC'), SM0->M0_CODFIL, SC7->C7_NUMCOT, Substr(cUsuario,7,15))

If Empty(aResult) .Or. aResult[1] <> '1'        


 ApMsgStop('Erro na chamada do processo')     
 
 EndIf
 
 EndIf */


Return


