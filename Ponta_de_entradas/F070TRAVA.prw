#include 'protheus.ch'
#include 'parmtype.ch'

user function F070TRAVA()

Local lRet

Alert("Passou pelo PE F070TRAVA e n�o travou a Tabela SA1")

lRet:= .f.//MsgYesNo ("Deseja travar os registros da tabela SA1 ?")

	
return lret