#include "TbiConn.ch"
#include "Protheus.ch"
#include "rwmake.ch"
#INCLUDE "topconn.ch"


User Function MNTA9904()

//Carrega vari�veis de Entrada e Sa�da

c990TRB1 := ParamIXB1

//Carrega o campo de usu�rio criado pelo ponto de entrada MNTA9902

(c990TRB1)->PLANO := "Teste de ponto de entrada MNTA9904"

Alert("Passou pelo PE MNTA9904")

Return