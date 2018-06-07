#INCLUDE "Acar590.CH"                                                                                                             
#include "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณACAR590   บAutor  ณRafael Rodrigues    บ Data ณ 04/JUN/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio Extrato Financeiro do Aluno                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณGestao Educacional                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณcAluno: RA do aluno (utilizado na ficha financeira)         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
USER Function Acar59A(cAluno)

Local nJa2Recno := JA2->(Recno())
Local nTam      := 0

//Faz ajustes no Dicionario de Dados
AjustaSX()

cString		:= "SE1"
aOrd		:= {}
nLastKey	:= 0
m_pag		:= 1
wnrel		:= "Acar59A"
titulo		:= STR0001 //"Extrato Financeiro"
cDesc1		:= STR0002 //"Emite o extrato financeiro do aluno"
cDesc2		:= ""
cDesc3		:= ""
aReturn		:= {STR0003, 1,STR0004, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
cPerg		:= "ACR590"
cOrder		:= ""
nomeprog	:= "Acar59A"
cTamanho	:= "G"
cCabec1		:= ""
cCabec2		:= ""  


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณSe foi passado o parametro cAluno, preenche as perguntas de aluno automaticamente. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
if cAluno <> nil
	dbSelectArea("SX1")
	dbSetOrder(1)
	nTam:=Len(SX1->X1_GRUPO)
	if dbSeek(Padr(cPerg,nTam)+"01")
		RecLock("SX1", .F.)
		SX1->X1_CNT01	:= cAluno
		msUnlock()
	endif
	if dbSeek(Padr(cPerg,nTam)+"02")
		RecLock("SX1", .F.)
		SX1->X1_CNT01	:= cAluno
		msUnlock()
	endif
	if dbSeek(Padr(cPerg,nTam)+"03")
		RecLock("SX1", .F.)
		SX1->X1_CNT01	:= Space(TamSx3("JBE_CODCUR")[1])
		msUnlock()
	endif
	if dbSeek(Padr(cPerg,nTam)+"04")
		RecLock("SX1", .F.)
		SX1->X1_CNT01	:= Replicate("Z",TamSx3("JBE_CODCUR")[1])
		msUnlock()
	endif
	if dbSeek(Padr(cPerg,nTam)+"05")
		RecLock("SX1", .F.)
		SX1->X1_CNT01	:= Space(TamSx3("JBE_PERLET")[1])
		msUnlock()
	endif
	if dbSeek(Padr(cPerg,nTam)+"06")
		RecLock("SX1", .F.)
		SX1->X1_CNT01	:= Replicate("Z",TamSx3("JBE_PERLET")[1])
		msUnlock()
	endif
	if dbSeek(Padr(cPerg,nTam)+"07")
		RecLock("SX1", .F.)
		SX1->X1_CNT01	:= "3"
		msUnlock()
	endif
Endif

Pergunte(cPerg, .F.)

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,cTamanho)

If nLastKey == 27
	Set Filter To
	Return
EndIf

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter To
	Return
EndIf

Processa({|lEnd| ACR590Imp(lEnd)}, STR0005)	// "Aguarde..."

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

JA2->(dbGoto(nJA2Recno))

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณACR590Imp บAutor  ณRafael Rodrigues    บ Data ณ04/06/02     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRealiza a impressao do Extrato Financeiro do Aluno.         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณGestao Educacional                                          บฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤยฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ PROGRAMADOR  ณ DATA   ณ BOPS ณ  MOTIVO DA ALTERACAO                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤลฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณIcaro Queiroz ณ29/09/06ณ106931ณFoi incluida uma nova pergunta no SX1 - ณฑฑ
ฑฑณ              ณ        ณ      ณconsidera baixas automaticas? - Se for  ณฑฑ
ฑฑณ              ณ        ณ      ณigual a SIM - continuara fazendo da ma- ณฑฑ
ฑฑณ              ณ        ณ      ณneira atual, se for igual a NAO - nao   ณฑฑ
ฑฑณ              ณ        ณ      ณconsiderara as baixas como "BA" no campoณฑฑ
ฑฑณ              ณ        ณ      ณE5_TIPODOC.                             ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
STATIC Function ACR590Imp(lEnd)

local nLin		 := 999
local nTit		 := 0
local nMulta	 := 0
local nJuros	 := 0
local nTotValor  := 0
local nTotDesc   := 0
local nTotBolsa  := 0
local nTotFies	 := 0
local nTotMulta  := 0
local nTotJuros  := 0
local nTotVlPag  := 0
local nTotAPag   := 0
local nDesc		 := 0
local nVlPago    := 0
local nMultaPaga := 0
local nJurosPago := 0
local cBcoSe5    :=""			
local cAgSe5     :=""
local cContaSe5	 :=""	
local dBaseVenc
local aValores	 :={}
local nValAtual	 :=0 

mv_par01 := Padr(mv_par01,TamSx3("JA2_NUMRA")[1])
mv_par02 := Padr(mv_par02,TamSx3("JA2_NUMRA")[1])

dbSelectArea("JA2")
ProcRegua(RecCount())

dbSetOrder(1)
dbSeek(xFilial()+mv_par01,.T.)
while !eof() .and. JA2->JA2_FILIAL == xFilial("JA2") .and. JA2->JA2_NUMRA <= mv_par02
	IncProc(STR0045+JA2->JA2_NUMRA+"...")
	
	dbSelectArea("JBE")	//Alocacao de Alunos
	dbSetOrder(1)		//JBE_FILIAL+JBE_NUMRA+JBE_CODCUR+JBE_PERLET+JBE_HABILI+JBE_TURMA
	dbSeek(xFilial()+JA2->JA2_NUMRA+mv_par03, .T.)
	while !eof() .and. JBE->JBE_FILIAL == xFilial("JBE") .and. JBE->JBE_NUMRA == JA2->JA2_NUMRA .and. JBE->JBE_CODCUR <= mv_par04
		
		// ignora registros pelos parametros de periodo
		if JBE->JBE_PERLET < mv_par05 .or. JBE->JBE_PERLET > mv_par06
			dbSkip()
			loop
		endif
		
		// Inicia o cabecalho do proximo aluno
		m_pag	:= 1
		Cabec(titulo,cCabec1,cCabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18),,,if( ExistBlock("ACALogo"), U_ACALogo(), nil ))
		nLin := 6
		
		nLin := ACR590Cab(nLin)		// Imprime os dados do aluno no cabecalho
		nTit := 0	// Contador de titulos impressos por aluno
		
		dbSelectArea("JC5")	// Bolsas por Aluno
		dbSetOrder(1)		// Filial + Numero RA
		dbSeek(xFilial()+JA2->JA2_NUMRA)
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime as bolsasณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		while !eof() .and. JC5->JC5_NUMRA == JA2->JA2_NUMRA
			
			dbSelectArea("JC4")
			dbSetOrder(1)
			dbSeek(xFilial()+JC5->JC5_TIPBOL)
			
			@ nlin	,000 psay STR0027+Alltrim(Substr(JC4->JC4_DESC,1,30))	//"Bolsa....: "
			@ nlin	,050 psay STR0029+Transform(JC5->JC5_PERBOL, "@E 999.99%")	//"Perc. :"
			@ nlin	,085 psay STR0030+dtoc(JC5->JC5_DTVAL1)	//"Inicio :"
			@ nlin++,125 psay STR0031+dtoc(JC5->JC5_DTVAL2)	//"Termino :"
			
			dbSelectArea("JC5")
			dbSkip()
			
		end // bolsas
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime o Cabecalho dos Titulosณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		if nLin > 55
			
			@ 060,000 psay STR0047	//"Continua na proxima pagina..."
			
			Cabec(titulo,cCabec1,cCabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18),,,if( ExistBlock("ACALogo"), U_ACALogo(), nil ))
			nLin := 8
			
			@ nlin++,000 psay STR0048	//"...continuacao"
			
		endif
		
		nLin := ACR590CabT(nLin)
	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Inicializa variaveis de totais ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		nTotValor := 0
		nTotDesc  := 0
		nTotBolsa := 0
		nTotFies  := 0
		nTotMulta := 0
		nTotJuros := 0
		nTotVlPag := 0
		nTotAPag  := 0
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime os Titulosณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		dbSelectArea("SE5")
		SE5->( dbSetOrder(7) )//ORDEM: E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ
		dbSelectArea("SE1")			// Titulos a Receber
		SE1->( dbSetOrder(18) )
		SE1->( dbSeek(xFilial("SE1")+JA2->JA2_NUMRA) )
		while !eof() .and. SE1->E1_NUMRA == JA2->JA2_NUMRA
			
			// Ignora tํtulos de abatimento
			If SE1->E1_TIPO $ MVABATIM
				SE1->(dbskip())
				Loop
			EndIf

			// Ignora pelo curso
			if mv_par08 == 1 .and. Left(SE1->E1_NRDOC,8) <> JBE->JBE_CODCUR+JBE->JBE_PERLET
				dbSkip()
				loop
			endif
			
			// Ignora pelo parametro de situacao
			if  (mv_par07 == 1 .and. SE1->E1_STATUS == "B") .or.;
				(mv_par07 == 2 .and. SE1->E1_STATUS <> "B")			// Em aberto / Baixados
				dbSkip()
				loop
			endif
			
			nTit++
			
			// Verifica quebra de pagina
			if nLin > 57
				
				@ 060,000 psay STR0047		//"Continua na proxima pagina..."
				
				Cabec(titulo,cCabec1,cCabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18),,,if( ExistBlock("ACALogo"), U_ACALogo(), nil ))
				nLin := 8
				
				@ nlin++,000 psay STR0048	//"...continuacao"
				nlin++
				
				nLin := ACR590CabT(nLin)
				
			endif
			
			dBaixa := If (Empty(SE1->E1_BAIXA), dDataBase ,SE1->E1_BAIXA)
            nTxMoeda := If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0)		                                                    
           
	   		nDesc 		:= 0
	   		nMultaPaga 	:= 0
	   		nJurosPago 	:= 0
	   		nVlPago	 	:= 0
	   		
			SE5->( dbSeek(xFilial("SE5")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA) )
			while !eof() .and. xFilial()+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA == SE5->E5_FILIAL+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA
                if SE5->E5_CLIENTE == SE1->E1_CLIENTE //.and. upper(alltrim(SE5->E5_MOTBX)) != 'DAC'
	            	if SE5->E5_TIPODOC == "VL" .or. SE5->E5_TIPODOC == "CP" .or. Iif( mv_par10 == 1, SE5->E5_TIPODOC == "BA", .F. ) //Se for titulo recebido, RECEBIMENTO ANTECIPADO / NOTA CREDITO CLIENTE ou  for Baixa Automatica
	   					nDesc 		+= SE5->E5_VLDESCO //Valor de desconto dado
	   					nMultaPaga 	+= SE5->E5_VLMULTA
	   					nJurosPago 	+= SE5->E5_VLJUROS
	   					nVlPago 	+= SE5->E5_VALOR //Valor Pago 
	   					cBcoSe5		:= ALLTRIM(SE5->E5_BANCO)
               			cAgSe5 		:= ALLTRIM(SE5->E5_AGENCIA)
               			cContaSe5	:= ALLTRIM(SE5->E5_CONTA)
         			elseif SE5->E5_TIPODOC == "ES" //Se for cancelamento da baixa, subtrai os valores de desconto, multa e o valor pago do titulo cancelado
	   					nDesc 		:= nDesc-SE5->E5_VLDESCO 
	   					nMultaPaga 	:= nMultaPaga-SE5->E5_VLMULTA
	   					nJurosPago 	:= nJurosPago-SE5->E5_VLJUROS
	   					nVlPago 	:= nVlPago-SE5->E5_VALOR 
	   					cBcoSe5		:= ""
               			cAgSe5 		:= ""
               			cContaSe5	:= ""
	            	endif
				EndIf   
            	SE5->(dbskip())
            end 
           
            IF EMPTY(SE1->E1_BAIXA) .OR. SE1->E1_STATUS = 'A'
            	dBaseVenc := SE1->E1_VENCREA
		   		If dDATABASE > dBaseVenc
					dBaseVenc := SE1->E1_VENCTO
            	endif   
    			aValores:= aclone(U_VLMENSDEVIDO( dBaseVenc, dDataBase /*informada em */, SE1->E1_VALOR, SE1->E1_VLBOLSA, '2', SE1->E1_EMISSAO,SE1->E1_PREFIXO, SE1->E1_NRDOC, SE1->E1_HIST, SE1->E1_DESCON1 ))
				nValAtual:=aValores[1]  	// Valor total a pagar na data informada
   				nMulta := aValores[3]   
		   		nJuros := aValores[4] 
   		   		nValAtual-= SE1->E1_VALLIQ  
   			ELSE		
	            nJuros := faJuros(SE1->E1_VALOR,SE1->E1_SALDO,SE1->E1_VENCTO,SE1->E1_VALJUR,SE1->E1_PORCJUR,SE1->E1_MOEDA,SE1->E1_EMISSAO,dBaixa,nTxMoeda,SE1->E1_BAIXA)
	            nJuros := iif(nJurosPago>0,nJurosPago,nJuros)
	            if dBaixa > SE1->E1_VENCREA
           			nMulta := if( !Empty(SE1->E1_BAIXA) .and. !Empty(nMultaPaga), nMultaPaga, SE1->E1_VLMULTA )
            	else
	            	nMulta := nMultaPaga
            	endif
	       	ENDIF            	
    
            nTotValor += SE1->E1_VALOR 		//Valor Total 
   			nTotDesc  += nDesc + SE1->E1_DECRESC	//Valor Total Dessconto
            nTotBolsa += SE1->E1_VLBOLSA 	//Valor Total Bolsa
            nTotFies  += SE1->E1_VLFIES		//Valor Total Fies
            nTotMulta += nMulta				//Valor Total Multa
			nTotJuros += nJuros	+ SE1->E1_ACRESC	//Valor Total Juros
			nTotVlPag += nVlPago			//Valor Total Pago 
			 
	   		if mv_par09 == 1 //Abate o valor da Bolsa do Valor A Pagar
				nTotAPag  += iif(!Empty(SE1->E1_SALDO),nValAtual,0) //Valor Total A Pagar
			else
				nTotAPag  += iif(!Empty(SE1->E1_SALDO),nValAtual,0)
			endif
			
			@ nlin  ,000 psay SE1->E1_NUM									//"Titulo"
			@ nlin	,010 psay SE1->E1_PARCELA+"/"+SE1->E1_PREFIXO			//"Parcela"
			@ nlin	,019 psay dtoc(SE1->E1_EMISSAO)							//"Emissao"  
			@ nlin	,032 psay dtoc(SE1->E1_VENCREA)							//"Vencto"
			@ nlin	,042 psay Transform(SE1->E1_VALOR	, "@E 999,999.99")	//"Valor"
			@ nlin	,057 psay Transform(nDesc + SE1->E1_DECRESC	, "@E 999,999.99")			//"Desconto"
			@ nlin	,072 psay Transform(SE1->E1_VLBOLSA , "@E 999,999.99")	//"Bolsa"
			@ nlin	,087 psay Transform(SE1->E1_VLFIES  , "@E 999,999.99")	//"Fies"			
			@ nlin	,102 psay Transform(nMulta	, "@E 999,999.99")			//"Multa"
			@ nlin	,117 psay Transform(nJuros + SE1->E1_ACRESC	, "@E 999,999.99")			//"Juros"
			@ nlin	,132 psay Transform(nVlPago , "@E 999,999.99")			//"Valor Pago"
			@ nlin	,147 psay dtoc(SE1->E1_BAIXA)							//"Dt.Pagto"
			
			if mv_par09 == 1 //Abate o valor da Bolsa do Valor A Pagar
				@ nlin	,157 psay Transform(iif(!Empty(SE1->E1_SALDO),nValAtual,0)	, "@E 999,999.99") //"Valor a Pagar"
			else
				@ nlin	,157 psay Transform(iif(!Empty(SE1->E1_SALDO),nValAtual,0)	, "@E 999,999.99")
			endif
			    
				@ nlin ,169 psay cBcosE5
				@ nlin ,174 psay cAgSe5  
				@ nlin ,179 psay cContaSe5
		 
		    if JA2->JA2_CLIENT # SE1->E1_CLIENTE
			  @ nlin++,190 psay "Bolsa - "+Left(SE1->E1_NOMCLI,20)
			else         
			  @ nlin++,190 psay Left(SE1->E1_HIST,20)			
			endif        
			 
			cBcoSe5:= 	" "
   			cAgSe5 := 	" "
      		cContaSe5:= " "			
			dbSelectArea("SE1")
			dbSkip()
			
		end // titulos
		
		if nTit == 0
			
			@ ++nlin,000 psay STR0046	//"*** Nao existem titulos para este aluno no periodo solicitado ***"
			
		else
		      
			nLin++           
			@ nLin, 000 psay Replicate("-",220)
			nLin++
			@ nLin, 000 psay STR0053		// Total
			@ nLin, 040 psay Transform( nTotValor, "@E 99,999,999.99")
			@ nLin, 055 psay Transform( nTotDesc , "@E 99,999,999.99")
			@ nLin, 070 psay Transform( nTotBolsa, "@E 99,999,999.99")
			@ nLin, 084 psay Transform( nTotFies,  "@E 99,999,999.99")
			@ nLin, 099 psay Transform( nTotMulta, "@E 99,999,999.99")
			@ nLin, 114 psay Transform( nTotJuros, "@E 99,999,999.99")
			@ nLin, 128 psay Transform( nTotVlPag, "@E 99,999,999.99")
			@ nLin, 155 psay Transform( nTotAPag , "@E 99,999,999.99")
			nLin ++
			@ nLin, 000 psay Replicate("-",220)
						
		endif
		                                         
		if nLin <= 55
			// Coloca um rodape para cada aluno+curso
			Roda(m_pag - 1,, cTamanho)
		endif	
		
		If mv_par08 = 2
			exit
		EndIf
		
		dbSelectArea("JBE")
		dbSkip()
		
	end // aluno+curso
	
	dbSelectArea("JA2")
	dbSkip()
	
end // alunos

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณACR590Cab บAutor  ณRafael Rodrigues    บ Data ณ04/06/02     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime o cabecalho do Extrato Financeiro com as informacoesบฑฑ
ฑฑบ          ณbasicas do aluno                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณGestao Educacional                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNenhum                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNenhum                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC Function ACR590Cab(nLin)
Local cSituacao := ""
Local aOpcoes := {} 

dbSelectArea("JAH")	// Curso Vigente
dbSetOrder(1)		// Filial + Codigo
dbSeek(xFilial()+JBE->JBE_CODCUR)

dbSelectArea("JBO")	// Itens Curso x Sala
dbSetOrder(1)		// JBO_FILIAL+JBO_CODCUR+JBO_PERLET+JBO_TURMA
dbSeek(xFilial()+JBE->JBE_CODCUR+JBE->JBE_PERLET+JBE->JBE_HABILI+JBE->JBE_TURMA)

dbSelectArea("JA3")	// Locais
dbSetOrder(1)		// JA3_FILIAL+JA3_CODLOC
dbSeek(xFilial()+JBO->JBO_CODLOC)

@ nLin	,000 psay STR0015+Alltrim(JA2->JA2_NUMRA)+" - "+Alltrim(JA2->JA2_NOME)	//"Aluno....: "
If mv_par08 = 1
	Do case
	Case JBE->JBE_ATIVO == "1" 
		aOpcoes := RetSx3Box(Posicione("SX3",2,"JBE_SITUAC","X3_CBOX"),,,14)
		if VAL(JBE->JBE_SITUAC) >= 1 .and. VAL(JBE->JBE_SITUAC) <= len(aOpcoes)
			cSituacao := aOpcoes[Val(JBE->JBE_SITUAC)][3]
		EndIf	
	Case JBE->JBE_ATIVO == "2"
		cSituacao := STR0050
	Case Val(JBE->JBE_ATIVO) > 2
		aOpcoes := RetSx3Box(Posicione("SX3",2,"JBE_ATIVO","X3_CBOX"),,,14)
		if Val(JBE->JBE_ATIVO) <= len(aOpcoes)
			cSituacao := aOpcoes[Val(JBE->JBE_ATIVO)][3]
		EndIf
	EndCase
	@ nLin++,125 psay STR0018+Alltrim(JA3->JA3_DESLOC)								//"Unidade..: "
	@ nLin++,000 psay STR0017+Alltrim(Posicione("JAH",1,xFilial("JAH")+JAH->JAH_CODIGO,"JAH_DESC"))		//"Curso....: "
	@ nLin	,000 psay STR0019+Alltrim(JBE->JBE_PERLET)								//"Serie....: "
	@ nLin	,020 psay STR0020+Alltrim(JBE->JBE_TURMA)								//"Turma....: "
	@ nLin   ,050 psay STR0016+Tabela("F5",JAH->JAH_TURNO,.F.)						//"Turno....: "
	@ nLin   ,085 psay STR0049+Alltrim(cSituacao)                        //"Situa็ใo: "
	if Alltrim(mv_par05) == "" .and. "Z"$Upper(mv_par06)
		@ nLin++,125 psay STR0021+STR0022								//"Periodos.: "###"Todos"
	elseif Alltrim(mv_par05) == ""
		@ nLin++,125 psay STR0021+STR0023+mv_par06		//"Periodos.: "###"Ate "
	elseif "Z"$Upper(mv_par06)
		@ nLin++,125 psay STR0021+STR0024+mv_par05		//"Periodos.: "###"Desde "
	else
		@ nLin++,125 psay STR0021+STR0025+mv_par05+;
		STR0026+mv_par06				//"Periodos.: "###"De "###" ate "
	endif

	If !Empty(JBE->JBE_HABILI)
		@ nLin++,000 psay STR0051 + Posicione("JDK",1,xFilial("JDK") + JBE->JBE_HABILI,"JDK_DESC")  // "Habilita็ใo: "
	EndIf
else
	nLin ++
EndIf

Return nLin

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณACR590CabTบAutor  ณRafael Rodrigues    บ Data ณ04/06/02     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime o subcabecalho para os Titulos                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณGestao Educacional                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณnLin: numero da linha atual para impressao                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณvariavel nLin atualizada                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ACR590CabT(nLin)

@ nlin++,000 psay Repl("-", 220)

@ nLin  ,000 psay STR0052   //"Titulo"
@ nlin	,010 psay STR0034	//"Parcela"  
@ nlin	,019 psay STR0055   //"Emissใo"
@ nlin	,032 psay STR0035	//"Vencto"
@ nlin	,042 psay STR0036	//"Valor"
@ nlin	,057 psay STR0037	//"Desconto"
@ nlin	,072 psay STR0038	//"Bolsa"
@ nlin	,093 psay STR0054	//"Fies"
@ nlin	,102 psay STR0039	//"Multa"
@ nlin	,117 psay STR0040	//"Juros"
@ nlin	,132 psay STR0041	//"Valor Pago"
@ nlin	,147 psay STR0042	//"Dt.Pagto"
@ nlin	,157 psay STR0043	//"Vl a Pagar"
@ nlin	,169 psay "Bco"
@ nlin	,174 psay "Ag."
@ nlin	,179 psay "Conta"
@ nlin++,190 psay STR0044	//"Historico"

@ nlin++,000 psay Repl("-",220)

Return nLin



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjustaSX  บAutor  ณAlberto Deviciente  บ Data ณ  12/06/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Faz ajuste no dicinario de dados.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao Educacional                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjustaSX()
Local nTam := 0    

SX1->( dbSetOrder( 1 ) )
nTam:=Len(SX1->X1_GRUPO)

If SX1->(!dbSeek(Padr("ACR590",nTam)+"09"))
	RecLock("SX1",.T.)
	SX1->X1_GRUPO   	:= "ACR590"
	SX1->X1_ORDEM   	:= "09"
	SX1->X1_PERGUNT 	:= "Abate Valor da Bolsa?"
	SX1->X1_VARIAVL 	:= "mv_ch9"
	SX1->X1_TIPO	 	:= "N"
	SX1->X1_TAMANHO 	:= 1
	SX1->X1_PRESEL 		:= 2
	SX1->X1_GSC 		:= "C"
	SX1->X1_VAR01   	:= "mv_par09"
	SX1->X1_DEF01     	:= "Sim"
	SX1->X1_DEF02     	:= "Nao"
	MsUnlock()
Endif

If SX1->(!dbSeek(Padr("ACR590",nTam)+"10"))
	RecLock("SX1",.T.)
	SX1->X1_GRUPO   	:= "ACR590"
	SX1->X1_ORDEM   	:= "10"
	SX1->X1_PERGUNT 	:= "Considera Baixas automaticas?"
	SX1->X1_VARIAVL 	:= "mv_cha"
	SX1->X1_TIPO	 	:= "N"
	SX1->X1_TAMANHO 	:= 1
	SX1->X1_PRESEL 		:= 2
	SX1->X1_GSC 		:= "C"
	SX1->X1_VAR01   	:= "mv_par10"
	SX1->X1_DEF01     	:= "Sim"
	SX1->X1_DEF02     	:= "Nao"
	MsUnlock()
Endif
                    
If SX1->(dbSeek(Padr("ACR590",nTam)+"03")) .AND. SX1->X1_F3 <> 'JAH'
	RecLock("SX1",.F.)
	SX1->X1_F3   	:= "JAH"
	MsUnlock()
Endif
                                                                
If SX1->(dbSeek(Padr("ACR590",nTam)+"04")) .AND. SX1->X1_F3 <> 'JAH'
	RecLock("SX1",.F.)
	SX1->X1_F3   	:= "JAH"
	MsUnlock()
Endif

Return
