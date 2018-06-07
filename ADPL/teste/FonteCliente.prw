
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#DEFINE  CRLF CHR(13)+CHR(10)
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³JOBMT330        ºAutor  ³ Robson Costa       º Data ³  08/07/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ JOB para rodar a rotina de Calculo do Custo medio de forma       º±±
±±º          ³automatica.                                                 		º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TKM                                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function JOBMT330()
Local lCPParte  := .F. //-- Define que nao sera processado o custo em partes
Local lBat      := .T.//-- Define que a rotina sera executada em Batch
Local aListaFil := {} //-- Carrega Lista com as Filiais a serem processadas
Local cCodFil   := '' //-- Codigo da Filial a ser processada 
Local cNomFil   := '' //-- Nome da Filial a ser processada
Local cCGC      := '' //-- CGC da filial a ser processada
Local aParAuto  :={}  //-- Carrega a lista com os 21 parametros
	
Conout("Inicio da execucao do JOBMT330 - Filial 04: ")
	
PREPARE ENVIRONMENT EMPRESA '03' FILIAL '04' MODULO "EST" TABLES "AF9","SB1","SB2","SB3","SB8","SB9","SBD","SBF","SBJ","SBK","SC2","SC5","SC6","SD1","SD2","SD3","SD4","SD5","SD8","SDB","SDC","SF1","SF2","SF4","SF5","SG1","SI1","SI2","SI3","SI5","SI6","SI7","SM2","ZAX","SAH","SM0","STL"	

Conout("Inicio da execucao do JOBM330")
//-- Adiciona filial a ser processada
dbSelectArea("SM0")
dbSeek(cEmpAnt)
Do While ! Eof() .And. SM0->M0_CODIGO == cEmpAnt 
	
	cCodFil := SM0->M0_CODFIL
	cNomFil := SM0->M0_FILIAL
	cCGC    := SM0->M0_CGC
	
	//-- Somente adiciona a Filial 04
	If cCodFil == "04"
		//-- Adiciona a filial na lista de filiais a serem processadas
		Aadd(aListaFil,{.T.,cCodFil,cNomFil,cCGC,.F.,})
	EndIf 
		
	dbSkip()
EndDo

//-- Executa a rotina de recalculo do custo medio
MATA330(lBat,aListaFil,lCPParte, aParAuto)
	
ConOut("Termino da execucao do JOBM330 - Filial 04")

Return Nil
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³JMT330F6        ºAutor  ³ Robson Costa       º Data ³  08/07/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ JOB para rodar a rotina de Calculo do Custo medio de forma       º±±
±±º          ³automatica, na Filial 06                                   		º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TKM                                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function JMT330F6(lBat)
Local lCPParte  := .F. //-- Define que nao sera processado o custo em partes
Local aListaFil := {} //-- Carrega Lista com as Filiais a serem processadas
Local cCodFil   := '' //-- Codigo da Filial a ser processada 
Local cNomFil   := '' //-- Nome da Filial a ser processada
Local cCGC      := '' //-- CGC da filial a ser processada
Local aParAuto  :={}  //-- Carrega a lista com os 21 parametros

lBat      := .T.//-- Define que a rotina sera executada em Batch
	
Conout("Inicio da execucao do JOBMT330 - Filial 06: ")
	
PREPARE ENVIRONMENT EMPRESA '03' FILIAL '06' MODULO "EST" TABLES "AF9","SB1","SB2","SB3","SB8","SB9","SBD","SBF","SBJ","SBK","SC2","SC5","SC6","SD1","SD2","SD3","SD4","SD5","SD8","SDB","SDC","SF1","SF2","SF4","SF5","SG1","SI1","SI2","SI3","SI5","SI6","SI7","SM2","ZAX","SAH","SM0","STL"	

//-- Adiciona filial a ser processada
dbSelectArea("SM0")
dbSeek(cEmpAnt)
Do While ! Eof() .And. SM0->M0_CODIGO == cEmpAnt 
	
	cCodFil := SM0->M0_CODFIL
	cNomFil := SM0->M0_FILIAL
	cCGC    := SM0->M0_CGC
	
	//-- Somente adiciona a Filial 06
	If cCodFil == "06"
		//-- Adiciona a filial na lista de filiais a serem processadas
		Aadd(aListaFil,{.T.,cCodFil,cNomFil,cCGC,.F.,})
	EndIf 
		
	dbSkip()
EndDo

//-- Executa a rotina de recalculo do custo medio
MATA330(lBat,aListaFil,lCPParte, aParAuto)
	
ConOut("Termino da execucao do JOBM330 - Filial 06")

Return Nil