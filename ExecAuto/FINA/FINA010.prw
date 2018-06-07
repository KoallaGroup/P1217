#include 'protheus.ch'
#include 'parmtype.ch'
#include 'tbiconn.ch'

user function FINA010INC()
	LOCAL aArray := {}

	PRIVATE lMsErroAuto := .F.

	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FIN" TABLES "SED"

	aArray := { { "ED_CODIGO"  , "A         "             , NIL },;
	{ "ED_DESCRIC" , "TESTE2                        " , NIL },;
	{ "ED_CALCIFR" , "N"               , NIL },;
	{ "ED_CALCISS" , "N"               , NIL },;
	{ "ED_CALCINS" , "N"               , NIL },;
	{ "ED_CALCCSL" , "N"               , NIL },;
	{ "ED_CALCCOF" , "N"               , NIL },;
	{ "ED_CALCPIS" , "N"               , NIL },;
	{ "ED_DEDPIS"  , "2"               , NIL },;
	{ "ED_DEDCOF"  , "2"               , NIL } }

	//Versão anteriores à versão 12.1.17
	//MsExecAuto( { |x,y| FINA010A(x,y)} , aArray, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão

	//Versão 12.1.17 e posteriores:
	MsExecAuto( { |x,y| FINA010(x,y)} , aArray, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão

	If lMsErroAuto
		MostraErro()
	Else
		Alert("Natureza incluída com sucesso!")
	Endif

Return

//	#include 'protheus.ch'
//	#include 'parmtype.ch'
//	#include 'tbiconn.ch'
//
//user function FINA010INC()
//	local aArray 		:= {}
//	private lMsErroAuto := .F.
//
//	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FIN" TABLES "SED"
//
//	aArray := { { "ED_CODIGO",	"NATUREZA 1",   			NIL },;
//	{ "ED_DESCRIC",	"INCLUIDO POR FINA010INC",	NIL },;
//	{ "ED_CALCIFR",	"N",				NIL },;
//	{ "ED_CALCISS",	"N",				NIL },;
//	{ "ED_CALCINS",	"N",				NIL },;
//	{ "ED_CALCCSL",	"N",				NIL },;
//	{ "ED_CALCCOF",	"N",				NIL },;
//	{ "ED_CALCPIS",	"N",				NIL },;
//	{ "ED_DEDPIS",	"2",				NIL },;
//	{ "ED_DEDCOF",	"2",				NIL } }
//
//	MsExecAuto( { |x, y| FINA010(x, y)}, aArray, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão
//
//	if lMsErroAuto
//		MostraErro()
//	else
//		Alert("Natureza incluída com sucesso!")
//	endIf
//return

//user function FINA010ALT()
//	local aArray 		:= {}
//	private lMsErroAuto := .F.
//
//	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FIN" TABLES "SED"
//
//	aArray := { { "ED_CODIGO",	"TST",					NIL },;
//				{ "ED_DESCRIC", "DESCRIÇÃO ALTERADA",	NIL } }
//
//	DbSelectArea("SED")
//	DbSeek(xFilial("SED"))
//
//	MsExecAuto( { |x, y| FINA010A(x, y)}, aArray, 4)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão
//
//	if lMsErroAuto
//		MostraErro()
//	else
//		Alert("Natureza alterada com sucesso!")
//	endIf
//return
//
//user function FIN010EXC()
//	local aArray 		:= {}
//	private lMsErroAuto := .F.
//
//	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FIN" TABLES "SED"
//
//	DbSelectArea("SED")
//	DbSeek(xFilial("SED") + "TST")
//
//	aArray := { { "ED_CODIGO" , SED->ED_CODIGO , NIL } }
//
//	MsExecAuto( { |x, y| FINA010A(x, y)}, aArray, 5)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão
//
//	if lMsErroAuto
//		MostraErro()
//	else
//		Alert("Exclusão da Natureza com sucesso!")
//	endIf
//return