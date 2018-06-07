#include 'protheus.ch'
#include 'parmtype.ch'
#include 'TOPCONN.CH'
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"

user function myMATA020()


Local PARAMIXB1 := {}
Local PARAMIXB2 := 3 //4-alteração 3-inclusão, 5- exclusão
Local cCod      := "016   "
//Local cFil      := "01"
Local cNome     := "ANA LUIZA MORAIS 4"
Local cLoja     := "01"
Local cNReduz   := "TESTE1"
Local cEnd      := "RUA DE PARDINHO"
Local cEst      := "SP"
lOCAL cMun      := "SÃO PAULO"
Local cTipo     := "F"
Local cCPF		:= "80916133850"



Private lMsErroAuto := .F.

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM" TABLES "SA2"


DbSelectArea("SA2") 
DbSetOrder(1) //A2_FILIAL+A2_XCLIENT 
DbSeek(xFilial("SA2")+cCod+cLoja)

//------------------------
//| Abertura do ambiente |
//------------------------

ConOut(Repl("-",80))
ConOut(PadC("Teste de Cadastro de Fornecedores",80))
ConOut("Inicio: "+Time())
//------------------------
//| Teste de Inclusao    |
//------------------------
Begin Transaction 	
PARAMIXB1 := {}
aadd(PARAMIXB1,{"A2_COD",cCod,nil})
//aadd(PARAMIXB1,{"A2_FILIAL",cFil,nil})	
aadd(PARAMIXB1,{"A2_LOJA",cLoja,nil})	
aadd(PARAMIXB1,{"A2_NOME",cNome,nil})	
aadd(PARAMIXB1,{"A2_NREDUZ",cNReduz,nil})	
aadd(PARAMIXB1,{"A2_END",cEnd,nil})	
aadd(PARAMIXB1,{"A2_EST",cEst,nil})	
aadd(PARAMIXB1,{"A2_MUN",cMun,nil})	
aadd(PARAMIXB1,{"A2_TIPO",cTipo,nil})
aadd(PARAMIXB1,{"A2_CGC",cCPF,nil})

	        
MSExecAuto({|x,y| mata020(x,y)},PARAMIXB1,PARAMIXB2)		
If !lMsErroAuto		
ConOut("Alterado com sucesso! "+cNome)		
Else		
ConOut("Erro na Alteração!")
Mostraerro()	
EndIf	
ConOut("Fim  : "+Time())
End Transaction

Return Nil

	
return