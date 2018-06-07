#include 'protheus.ch'
#include 'parmtype.ch'

user function MFILTRMAIL()

Local cParUsuario := PARAMIXB[1]
Local cParGrUsuario := PARAMIXB[2]
Local cParEmails := PARAMIXB[3] 
	
alert("MFILTRMAIL")	

IF cFormEvent == '033'
cParUsuario:= {'rodrigo.gsoares@totvs.com.br'}

ELSEIF !empty(cParUsuario)
alert('Não será enviado o email')

ENDIF
	
return aParUsuario
