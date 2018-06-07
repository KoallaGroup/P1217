#INCLUDE 'PROTHEUS.CH'

//-----------------------------------------------------------------------
/*/{Protheus.doc} A410TAB

Este ponto de entrada pertence à rotina de pedidos de venda, MATA410A(). 
Está localizado A410TABELA, que retorna o preco de lista considerando grade 
de produtos. Usado quando existe uma Tabela Especial ou quando o Cliente 
usa a tabela de precos do SIGALOJA. A execução deste ponto depende do 
décimo parâmetro passado para a A410TABELA: se .T. executa, .F. não executa. 
É assumido, por padrão o valor .T..

Específico KCI:
Caso o campo customizado C6_XTABPRC estiver preenchido, buscar o preço de 
lista - C6_PRUNIT - a partir desta tabela

@param		cProduto,cTabprec,nLin,nQtde,cCliente,cLoja,cLoteCtl,cNumLote,lLote
@return	nPrcVen
@author 	Fábio Cazarini
@since 		06/04/2016
@version 	1.0
/*/
//-----------------------------------------------------------------------
USER FUNCTION A410TAB()
	
	
	
	
	Local cProduto	:= M->PARAMIXB[1]
	Local cTabprec	:= M->PARAMIXB[2]
	Local nLin		:= M->PARAMIXB[3]
	Local nQtde		:= M->PARAMIXB[4]
	Local cCliente	:= M->PARAMIXB[5]
	Local cLoja		:= M->PARAMIXB[6]
	Local cLoteCtl	:= M->PARAMIXB[7]
	Local cNumLote	:= M->PARAMIXB[8]
	Local lLote		:= M->PARAMIXB[9]

	Local aArea		:= GetArea()
	Local aAreaSF4	:= SF4->( GetArea() )
	Local aAreaSB1	:= SB1->( GetArea() )

	Local nPrcVen		:= 0
   //	Local lPrcPod3  	:= ( GetNewPar( "MV_PRCPOD3", "1" ) == "2" )                    
	Local lPrcPod3  	:= .F. 
	Local cPoder3		:= ""
	Local nPosTes		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_TES"})
	//Local nPosTAB		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_XTABPRC"})  
	Local cTABPRC		:= ""	

	
	Alert("Passou pelo A410TAB")
	//-----------------------------------------------------------------------
	// Eh poder terceiro?
	//-----------------------------------------------------------------------
	If nLin > 0 .And. nPosTes > 0
		dbSelectArea("SF4")
		dbSetOrder(1)
		If MsSeek(xFilial("SF4")+aCols[nLin][nPosTes])
			cPoder3 := SF4->F4_PODER3
		Else
			cPoder3 := "N"
		Endif
	Else
		cPoder3 := "N"
	Endif

	//-----------------------------------------------------------------------
	// Busca o preco da tabela
	//-----------------------------------------------------------------------
	dbSelectArea("SB1")
	dbSetOrder(1)
	/*If ( !Empty(cProduto) .And. MsSeek(xFilial("SB1")+cProduto,.F.) .And. ( ( M->C5_TIPO=="N" .And. cPoder3 == "N" ) .Or. (lPrcPod3 .And. !(IsInCallStack("A410Devol"))) ) ) 
		//-----------------------------------------------------------------------
		// Se foi preenchido a tabela de precos do item do pedido
		//-----------------------------------------------------------------------
		IF SB1->B1_XGRPPRD == "1"
			cTabPrec := M->C5_XTABGR1
		ELSE 
			cTabPrec := M->C5_XTABGR2
		ENDIF	

		nPrcVen := MaTabPrVen(cTabPrec,cProduto,nQtde,cCliente,cLoja,M->C5_MOEDA,M->C5_EMISSAO)
	EndIf
	*/
    nPrcven := 15
	//-----------------------------------------------------------------------
	// Restaura ambiente
	//-----------------------------------------------------------------------
	RestArea(aAreaSB1)
	RestArea(aAreaSF4)
	RestArea(aArea)

RETURN nPrcVen