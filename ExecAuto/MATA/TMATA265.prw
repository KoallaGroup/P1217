#include "protheus.ch"
#include "rwmake.ch"
#include "tbiconn.ch"

user function TMATA265()
	local nOpc		:= 3 // 3) INCLUSÃO || 4) ESTORNO
	local aCabec	:= {}
	local aItens	:= {}
	local aLinha	:= {}
	
	private lMsErroAuto := .F.
	
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "EST" TABLES "SDA", "SDB"
	
	conOut(repl("-", 80))
	conOut(padC("Teste MATA265 iniciado!", 80))
	conOut(padC("Inicio: " + Time(), 80))
	conOut(repl("-", 80))
	
	if nOpc == 3
		aCabec := {	{"DA_PRODUTO",	"02             ",	NIL},;
						{"DA_NUMSEQ",		"000205",		NIL}}
						
		aItens := {	{"DB_ITEM"	,		"0005",		NIL},;
						{"DB_ESTORNO",	"",				NIL},;
						{"DB_LOCALIZ",	"RUA BRAZ LEME, ",		NIL},;
						{"DB_DATA",		dDataBase,		NIL},;
						{"DB_QUANT",		13,				NIL}}
			
		aadd(aLinha, aItens)
	endIf

	if nOpc == 4
		aCabec := {	{"DA_PRODUTO",	"PRDT0005",	NIL},;
						{"DA_NUMSEQ",		"000018",		NIL}}
						
		aItens := {	{"DB_ITEM"	,		"0003",		NIL},;
						{"DB_ESTORNO",	"S",			NIL},;
						{"DB_LOCALIZ",	"RUA DOS JABUTIS",		NIL},;
						{"DB_DATA",		dDataBase,		NIL},;
						{"DB_QUANT",		13,				NIL}}
			
		aadd(aLinha, aItens)
	endIf
	
	MSExecAuto({|x,y,z| Mata265(x,y,z)},aCabec,aLinha,nOpc)
	
	
	if lMsErroAuto
		mostraErro()
		conOut(repl("-", 80))
		conOut(padC("Teste MATA265 finalizado com erro!", 80))
		conOut(padC("Fim: " + Time(), 80))
		conOut(repl("-", 80))
	else
		conOut(repl("-", 80))
		conOut(padC("Teste MATA265 finalizado com sucesso!", 80))
		conOut(padC("Fim: " + Time(), 80))
		conOut(repl("-", 80))
	endIf

//	RESET ENVIRONMENT
return