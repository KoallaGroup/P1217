#include 'protheus.ch'
#include 'parmtype.ch'
#iNCLUDE 'TBICONN.CH'

user function GPEA580()

//Declaracao das variaveis de controle
Local aCabAuto := {}
Local aItemAuto := {}
Local aLinha := {}
Local xFilial := '01'
Local cMatricula := '880001'
Private lMsErroAuto := .F.

//Preparando ambiente para conexão 
PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'


//Posiciona 1
RGB->(DbSetOrder(1))
RGB->(DbSeek(xFilial + cMatricula))


//Criando variaveis do cabecalho
aAdd( aCabAuto,{ 'RA_FILIAL' , xFilial , nil })
aAdd( aCabAuto,{ 'RA_MAT' , cMatricula , nil })
aAdd( aCabAuto,{ 'CROTEIRO' , 'PLA' , nil })
aAdd( aCabAuto,{ 'CNUMPAGTO', '01' , nil })
aAdd( aCabAuto,{ 'CPERIODO' , '201802' , nil })

//Criando variaveis dos itens

// Item 1
aadd(aLinha,{'RGB_SEMANA' , '01' , nil})
aadd(aLinha,{'RGB_PD' , '003' , nil})
aadd(aLinha,{'RGB_TIPO1 ' , 'V' , nil})
aadd(aLinha,{'RGB_HORAS ' , 2 , nil})
aadd(aLinha,{'RGB_VALOR ' , 10 , nil})
aadd(aLinha,{'RGB_DTREF ' , dDataBase, nil})
aadd(aLinha,{'RGB_CC ' , '1.2      ' , nil})
//aadd(aLinha,{'RGB_PARCEL' , 0 , nil})
aadd(aLinha,{'RGB_CODFUN' , 'ENFER' , nil})
//aadd(aLinha,{'RGB_DEPTO ' , '000000002' , nil})
aadd(aItemAuto,aLinha)

//Chama a rotina
MsExecAuto({|a, b, c, d| GPEA580(a,b,c,d)},nil, aCabAuto, aItemAuto,4)

//Faz a validacao
If !lMsErroAuto
Alert("Incluido com sucesso! ")
Else
MostraErro()
EndIf

//RESET ENVIRONMENT
Return
	
