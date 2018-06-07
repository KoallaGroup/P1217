#INCLUDE "TBICONN.CH"
/*
TLOGA - Registro de acessos ao Portal Protheus.
Programador: Vicente de Paula	14.05.2009
cPar01 = Fun��o sendo executada (funname());
cPar02 = Detalhes para serem mostrados no mp8console.log;
cPar03 = C�digo do usu�rio. Quando n�o informado, ser� tratato o retorno de GetUsrCode().
lPar04 = .T. = registra no log, .F. = n�o registra.

23.10.2009 Vicente - Inclus�o dos par�metros cPar03 e lPar04.
05.12.2009 Vicente - Se n�o informar o 4� par�metro (ref.a gravar no log), ser� considerado o mesmo como .T.
VV.11.2017 Vicente - Substitu�do RPCSETTYPE(3) e RpcSetEnv("01","01") por PREPARE ENVIRONMENT, conforme indica��o da Totvs via chamado 1667845 de 13.11.2017. 
*/
User Function TLoga(cPar01,cPar02,cPar03,lPar04)

if type("cEmpAnt") == "U"
	conout(dtoc(date()) +" "+ time() +" "+ iif(cPar03 = NIL, GetUsrCode(), cPar03) +": ANTES DE PREPARAR O AMBIENTE") 
	conout(dtoc(date()) +" "+ time() +" Empresa: "+ iif(type("cEmpAnt") == "U","U",cEmpAnt) +" Filial: "+ iif(type("cFilAnt") == "U","U",cFilAnt))
	conout(dtoc(date()) +" "+ time() +" "+ iif(cPar03 = NIL, GetUsrCode(), cPar03) +": PREPARANDO O AMBIENTE") 
	PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"
	conout(dtoc(date()) +" "+ time() +" "+ iif(cPar03 = NIL, GetUsrCode(), cPar03) +": AMBIENTE PREPARADO") 
	conout(dtoc(date()) +" "+ time() +" Empresa: "+ cEmpAnt +" Filial: "+ cFilAnt)
endif

if lPar04 = NIL .or. lPar04
	dbselectarea("ZE1")
	RecLock("ZE1",.T.)
	replace ZE1_DATA		with date()
	replace ZE1_HORA		with time()
	replace ZE1_CODUSU	with iif(cPar03 = NIL, GetUsrCode(), cPar03)
	replace ZE1_ROTINA	with cPar01
	MsUnlock()
endif
	
conout(dtoc(date()) +" "+ time() +" "+ iif(cPar03 = NIL, GetUsrCode(), cPar03) +": "+ cPar01 +" - "+ cPar02)
return