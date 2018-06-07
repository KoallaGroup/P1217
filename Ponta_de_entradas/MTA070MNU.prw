#include 'protheus.ch'
#include 'parmtype.ch'

user function MTA070MNU()
	
alert("Passou pelo PE MTA070MNU")

aadd(aRotina,{'Abrir Dialog', "U_Geratela()" , 0 , 3,0,NIL})
	
return aRotina