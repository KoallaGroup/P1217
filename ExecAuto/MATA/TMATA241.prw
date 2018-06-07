#include "protheus.ch"
#include "rwmake.ch"
#include "tbiconn.ch"

user function TMATA241()
	local nOpc		:= 3 // 3) INCLUSÃO | 4) ALTERAÇÃO
	local aCabec	:= {}
	local aItem	:= {}
	local aLinha	:= {}
	
	private lMsErroAuto := .F.
	
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "EST" TABLES "SD3"
	
	conOut(repl("-", 80))
	conOut(padC("Teste MATA241 iniciado!", 80))
	conOut(padC("Inicio: " + Time(), 80))
	conOut(repl("-", 80))
	
	// INÍCIO: INCLUSÃO //
	if nOpc == 3
		aCabec := {	{"D3_TM",SD3->D3_TM,			NIL},;
						{"D3_EMISSAO",	ddatabase,		NIL}}
						
		aItem := {		{"D3_COD",SD3->D3_COD,	NIL},;
						{"D3_UM",SD3->D3_UM,			NIL},;
						{"D3_QUANT",SD3->D3_QUANT,				NIL},;
						{"D3_LOCAL",SD3->D3_LOCAL,			NIL}}
						
		aadd(aLinha, aItem)
	endIf
	// FIM: INCLUSÃO //
	
	MsExecAuto({|x, y, z| MATA241(x, y, z)}, aCabec, aLinha, nOpc,.t.)

	if lMsErroAuto
		mostraErro()
		conOut(repl("-", 80))
		conOut(padC("Teste MATA241 finalizado com erro!", 80))
		conOut(padC("Fim: " + Time(), 80))
		conOut(repl("-", 80))
	else
		conOut(repl("-", 80))
		conOut(padC("Teste MATA241 finalizado com sucesso!", 80))
		conOut(padC("Fim: " + Time(), 80))
		conOut(repl("-", 80))
	endIf
	
	RESET ENVIRONMENT
return