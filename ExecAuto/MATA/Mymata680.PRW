#Include "Protheus.Ch"
#INCLUDE "FONT.CH"
#include "topconn.ch"
#INCLUDE "TBICONN.CH"

User Function mymata680()

	Local HoraInicial := SUBSTR(TIME(), 1, 5) 
	Local HoraSoma    := '00:01'
	Local HoraTeste   := SomaHoras(HoraInicial,HoraSoma)
	Local HoraInicial := StrTran(transform(HoraInicial,"99.99"),".",":")
	Local HoraFinal   := StrTran(transform(HoraTeste,"99.99"),".",":")
	Local HoraFinal   := StrTran(HoraFinal," ","0")//troca espacos vazio com 0
	Local DataInicial := Date()
	Local DataFinal   := Date()
	Local _cOp        := '00000901001   '
	Local _cProduto   := '02             '
//	Local _cTurno     := '1'
	Local nQtd        := 1
//	Local cIdent      := ProxNum()	
	Local Maquina     := '001   '
	Local aVetor      := {} 
	  
	PRIVATE lMsErroAuto := .F.

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM" 
	
	aVetor := { {"H6_FILIAL" , "01"        ,NIL},;
				{"H6_OP"     , _cOp        ,NIL},;
				{"H6_PRODUTO", _cProduto        ,NIL},;
				{"H6_DATAINI", DataInicial ,NIL},;
				{"H6_DATAFIN", DataFinal   ,NIL},;
				{"H6_OPERAC" , '1 '        ,NIL},;
				{"H6_LOCAL"  , "1 "        ,NIL},;
				{"H6_RECURSO", Maquina     ,NIL},;
				{"H6_QTDPROD", nQtd        ,NIL},;  
				{"H6_DTAPONT", DataFinal   ,NIL}} 
				
				/*,;
				{"H6_OPERAC" , '01'        ,NIL},;
				{"H6_RECURSO", Maquina     ,NIL},;
				{"H6_DATAINI", DataInicial ,NIL},;
				{"H6_HORAINI", HoraInicial ,NIL},;
				{"H6_DATAFIN", DataFinal   ,NIL},;
				{"H6_HORAFIN", HoraFinal   ,NIL},;                                   
				{"H6_TIPO"   , "P"         ,NIL},;
				{"H6_QTDPROD", nQtd        ,NIL},;
				{"H6_LOCAL"  , "1 "        ,NIL},;
				{"H6_PT"     , 'P'         ,NIL},;
				{"H6_DTAPONT", Date()      ,NIL},;
				{"H6_DTPROD" , Date()      ,NIL}} */
   
	
	MSExecAuto({|x| mata680(x)},aVetor,3)  // inclusao
	  
	IF lMsErroAuto   
		Mostraerro() 
		Alert("Nao foi possivel efetuar o apontamento!")
		lMsErroAuto := .F.
	ELSE    
		Alert("Apontado!!!")
	ENDIF
			

Return
 