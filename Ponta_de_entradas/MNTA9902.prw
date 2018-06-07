#include "TbiConn.ch"
#include "Protheus.ch"
#include "rwmake.ch"
#INCLUDE "topconn.ch"

User Function MNTA9902()

	//Carrega variaveis de Entrada e Saida
	aTRB1	:= ParamIXB[1]
	aDBF 	:= ParamIXB[2]
	aTRB2	:= ParamIXB[3]
	aDBFa	:= ParamIXB[4]




	Alert("Passou pelo PE MNTA9902")
	Return