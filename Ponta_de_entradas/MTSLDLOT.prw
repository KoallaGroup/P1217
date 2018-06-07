#INCLUDE "PROTHEUS.CH"
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} MTSLDLOT

Ponto de entrada na fun��o "SldPorLote" e na fun��o "SB8Saldo" para validar a escolha do lote.

Precisa configurar os par�metros abaixo:
MV_GERABLQ - Indica se deve gerar bloqueio de estoque para produtos que controlam rastro ou localizacao - Conteudo: .T.
MV_GRVBLQ2 - Indica se quando a liberacao for parcial deve-se gerar uma nova liberacao bloqueada - Conteudo: S         

@param   {B8_PRODUTO,B8_LOCAL,B8_LOTECTL,B8_NUMLOTE,BF_LOCALIZ,BF_NUMSERI,nEmpenho,.F.}

@return  lReturn

@author  Reinaldo Dias
@version P12
@since   28/07/2017
/*/
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
User Function MTSLDLOT()



Local aTest := PARAMIXB

Local lRet  := .F.

Local cTab := Alias()


Alert("Passou pelo MTSLDLOT")


If ALLTRIM(aTest[3]) <> " LOTE01"

      lRet := .T.

EndIF

 

Return lRet
	
	
	
/*	
 	Local aArea       := GetArea()
	Local aAreaSB8    := SB8->(GetArea())
	Local cB8_PRODUTO := PARAMIXB[1]
	Local cB8_LOCAL   := PARAMIXB[2]
	Local cB8_LOTECTL := PARAMIXB[3]
	Local cB8_NUMLOTE := PARAMIXB[4]
	Local lPDSHELF    := SuperGetMV("FS_PDSHELF", NIL, .T.)
	Local lReturn     := .T. 

	IF !lPDSHELF
		Return Nil
	Endif        

	/*
	MATA410  - Pedido de Venda
	MATA412  - Programa��es de Entrega
	MATA440  - Libera��o de Pedidos de Venda
	MATA450  - An�lise de Cr�dito de Pedido de Venda
	MATA450A - An�lise de Cr�dito de Cliente
	MATA455  - Libera��o de Estoque
	MATA456  - Libera��o de Cr�dito e Estoque
	
	IF !FunName() $ "MATA410|MATA412|MATA440|MATA450|MATA450A|MATA455|MATA456" .Or. QtdComp(SC5->C5_XPRAZO) == QtdComp(0) .Or. !Empty(SC6->C6_LOTECTL)
		Return Nil
	Endif

	IF !Rastro(cB8_PRODUTO) 
		Return Nil
	Endif 

	IF FunName() $ "MATA410|MATA440" .And. !IsInCallStack("MaLibDoFat") //Somente avaliar o lote na gravacao da liberacao.
		Return Nil
	Endif

	//ALERT("Passei MTSLDLOT -> "+SC5->C5_NUM+" "+SC6->C6_NUM+" "+SC6->C6_ITEM+" "+SC6->C6_PRODUTO+" "+SC6->C6_LOTECTL+" "+DTOC(SC6->C6_ENTREG))

	DBSelectArea("SB8")
	DBSetOrder(3) //B8_FILIAL+B8_PRODUTO+B8_LOCAL+B8_LOTECTL+B8_NUMLOTE+DTOS(B8_DTVALID)   
	DBSeek(xFilial("SB8")+cB8_PRODUTO+cB8_LOCAL+cB8_LOTECTL+cB8_NUMLOTE)

	nDiasVenc := SB8->B8_DTVALID - SC6->C6_ENTREG

	IF nDiasVenc < SC5->C5_XPRAZO
		lReturn := .F.
	Endif

	RestArea(aAreaSB8)
	RestArea(aArea)

Return(lReturn)


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
User Function fGatA1XTIPO()
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Local cTipo := Alltrim(M->A1_XTIPO)
	Local nDias := 0
	Do Case
		Case cTipo == "P";  nDias:= 360
		Case cTipo == "HC"; nDias:= 120
		Case cTipo == "OP"; nDias:= 120
		Case cTipo == "D";  nDias:= 270
		Case cTipo == "PR"; nDias:= 90
		Case cTipo == "O";  nDias:= 0
	EndCase
Return(nDias)

*/