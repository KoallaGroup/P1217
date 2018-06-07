#include "TbiConn.ch"
#include "Protheus.ch"
#include "rwmake.ch"
#INCLUDE "topconn.ch"


User Function MNTA9904()

//Carrega variáveis de Entrada e Saída

c990TRB1 := ParamIXB1

//Carrega o campo de usuário criado pelo ponto de entrada MNTA9902

(c990TRB1)->PLANO := "Teste de ponto de entrada MNTA9904"

Alert("Passou pelo PE MNTA9904")

Return