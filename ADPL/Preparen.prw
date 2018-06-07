#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBEX.CH"
#INCLUDE "TBICONN.CH"

User Function Prep_Teste()
	Local cHtml := ""
	Local aRet	:= {}
	Local cTempo := " Inicio " + Dtoc(MsDate()) + " " + Time() + " Fim "
	Local cTeste := ""
	
 	//RPCSetType(3)
	//RpcSetEnv( '01' , '01',,,'FAT',,{},,,,.T.)

	//cTeste := Month2Str(( stod("20180101") ) + "/" + Year( stod("20180101") )
	

 	//RPCSetType(3)
	//RpcSetEnv( '01' , '01',,,'FAT',,{},,,,.T.)
	conout("Antes do primeiro PREPARE")
	conout("Tempo inicio " + Dtoc(MsDate()) + " " + Time())
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"
	conout("Dentro do primeiro PREPARE")
	conout("Tempo " + Dtoc(MsDate()) + " " + Time())
	dbSelectArea('SA1')
	dbSetOrder(1)
	conout("Primeiro cliente da tabela " + SA1->A1_COD + " " + AllTrim(SA1->A1_NOME))	
	Reset Environment
	conout("Depois do primeiro PREPARE")
	conout("Antes do segundo PREPARE")
	conout("Tempo " + Dtoc(MsDate()) + " " + Time())
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"
	conout("Dentro do segundo PREPARE")
	conout("Tempo " + Dtoc(MsDate()) + " " + Time())	
	dbSelectArea('SA1')
	dbSetOrder(1)
	conout("Primeiro cliente da tabela " + SA1->A1_COD + " " + AllTrim(SA1->A1_NOME))	
	Reset Environment
	conout("Depois do segundo PREPARE")
	conout("Antes do terceiro PREPARE")
	conout("Tempo " + Dtoc(MsDate()) + " " + Time())
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "03" MODULO "FAT"
	conout("Dentro do terceiro PREPARE")
	conout("Tempo " + Dtoc(MsDate()) + " " + Time())	
	dbSelectArea('SA1')
	dbSetOrder(1)
	conout("Primeiro cliente da tabela " + SA1->A1_COD + " " + AllTrim(SA1->A1_NOME))	
	Reset Environment
	conout("Fim do terceiro PREPARE")
	conout("Tempo " + Dtoc(MsDate()) + " " + Time())			
	cTempo += Dtoc(MsDate()) + " " + Time()
	
	Conout("Tempo de execucao da rotina " + cTempo)


Return .T.