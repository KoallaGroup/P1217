#include "tbiconn.ch"
#include "Protheus.ch"

User Function VldEstrut
	
	Local cProduto 	:= "2              "
	Local nCont		:= 0
	Local cNomeArq 
	Local oTempTable := NIL
	Private nEstru  := 0
		

	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" TABLES "SG1"
    
	While nCont < 1500
		nEstru := 0
		
/*		If Select("ESTRUT") <> 0
			ESTRUT->(DbCloseArea())
		Endif */
	cNomeArq :=	  cNomeArq := Estrut2(cProduto,1,NIL,@oTempTable,NIL,.T.)
                
        Conout(ESTRUT->CODIGO)

		FIMESTRUT2("ESTRUT",oTempTable)
		nCont++
		Conout(nCont)
	
	//RESET ENVIRONMENT
	
Return