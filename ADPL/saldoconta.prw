#include 'protheus.ch'
#include 'parmtype.ch'
#include "tbiconn.ch"

user function saldoconta()
	
Local nREt

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" 

nRet := SaldoConta("3.1.1               ",dDataBase,"01","1",1)

conout('Saldo é :'+cvaltochar(nRet))
return
//Efeito: Retorna o saldo atual [1] da conta 2101 na database do sistema para o moeda 1, saldo 1