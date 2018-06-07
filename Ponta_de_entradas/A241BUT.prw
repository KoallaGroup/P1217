#include 'protheus.ch'
#include 'parmtype.ch'
#include "TbiConn.ch

user function A241BUT()
	
Local nOpcao  := PARAMIXB[1]  // Opção escolhida
Local aBotoes := PARAMIXB[2]  // Array com botões padrão// Customizações do cliente

aAdd(aBotoes,{"Cópia","",{|| TMATA241()},"ViewVisual",,})


Return aBotoes