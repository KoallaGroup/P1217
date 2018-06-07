#include 'protheus.ch'
#include 'parmtype.ch'
#include "tbiconn.ch"

user function tstcheckbo()


Local cTexto
Local cTexto1

Pergunte("CHEKBOX", .T.)

alert(cvaltochar(MV_PAR01))
alert(cvaltochar(MV_PAR02))


cTexto := STRTRAN(MV_PAR01, "1", "2")
alert(cvaltochar(MV_PAR01))


cTexto := STRTRAN(MV_PAR01, "1", "2")
alert(cvaltochar(MV_PAR02))


	
return