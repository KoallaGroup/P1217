#include 'protheus.ch'
#include 'parmtype.ch'
#include "TbiConn.ch

user function A241BUT()
	
Local nOpcao  := PARAMIXB[1]  // Op��o escolhida
Local aBotoes := PARAMIXB[2]  // Array com bot�es padr�o// Customiza��es do cliente

aAdd(aBotoes,{"C�pia","",{|| TMATA241()},"ViewVisual",,})


Return aBotoes