#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "FWMBROWSE.CH"

user function MTA161BUT()

Local aRotina:= PARAMIXB[1]
Local aAcoes:= { }


//Valida��es do usu�rio


aadd(aRotina,{'TEXTO DO BOTAO','NOME DA FUNCAO' , 0 , 3,0,NIL}) //Cria um novo bot�o


ADD OPTION aRotina Title 'teste'		Action 'PesqBrw'  		OPERATION 1 ACCESS 0 //dentro do menu (Outras op��es)


alert("MTA161BUT")


Return (aRotina)
	
