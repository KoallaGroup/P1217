#Include 'Protheus.ch'
#INCLUDE "topconn.ch"


// Filtro
#DEFINE ADDFIL_TITULO    1
#DEFINE ADDFIL_EXPR      2
#DEFINE ADDFIL_NOCHECK   3                                                                                        
#DEFINE ADDFIL_SELECTED  4
#DEFINE ADDFIL_ALIAS     5
#DEFINE ADDFIL_FILASK    6
#DEFINE ADDFIL_FILPARSER 7
#DEFINE ADDFIL_ID        8

User Function tFWBrow()

Local oBrowse  	 := Nil
Local nX         := 0
Local aCoresLeg	 := {}

Local aIndexSA1	:= {}

Local xRet      := NIL
                                 
Private  aAddFil := {}

Private aRotina 	:= MenuDef()
Private cFilCTR     := cFilAnt

Private aRotina := Menudef()

//-- Instanciamento da Classe de Browse
oBrowse := FWMBrowse():New()
oBrowse:SetAlias('SA1')
oBrowse:SetDescription("Teste...")


If(ValType(aCoresLeg) == "A")
	For nX := 1 to Len(aCoresLeg) STEP 1
		If(Len(aCoresLeg[nX]) >= 3)
			oBrowse:addLegend(aCoresLeg[nX][1],aCoresLeg[nX][2],aCoresLeg[nX][3])
		EndIf
	Next nX
EndIf


//-- Filtros adicionais do Browse
For nX := 1 To Len( aAddFil )
	oBrowse:DeleteFilter( aAddFil[nX][ADDFIL_ID] )
	oBrowse:AddFilter( aAddFil[nX][ADDFIL_TITULO], ;
					      aAddFil[nX][ADDFIL_EXPR], ;
					      aAddFil[nX][ADDFIL_NOCHECK], ;
					      aAddFil[nX][ADDFIL_SELECTED], ;
					      aAddFil[nX][ADDFIL_ALIAS], ;
					      aAddFil[nX][ADDFIL_FILASK], ;
					      aAddFil[nX][ADDFIL_FILPARSER], ;
					      aAddFil[nX][ADDFIL_ID] )
	oBrowse:ExecuteFilter()

Next nX

oBrowse:Activate()

If ( Len(aIndexSA1)>0 )
	EndFilBrw("SA1",aIndexSA1)
EndIf


Return( xRet )
                                  
Static Function MenuDef()

PRIVATE aRotina	:= { 	{ "Pesquisar"      , "AxPesqui"      , 0, 1, 0,.F.},;   //"Pesquisar"
						{ "Alterar"        , "AxAltera"      , 0, 4, 0,.F.},;  //"Alterar"
						{ "Atualiza SRV"   , "U_ATUASRV()"   , 0, 4, 0,.F.}}   //"Atualizar"

Return(aRotina)

                                
User Function ATUASRV(cAlias,nReg,nOpc)
Local cArqTRB   := ""
Local cQuery    := ""
Local cForn := ""
  
DbSelectArea("SE1")

DbSelectArea("SA2")
DbSetOrder(1)
If DbSeek(xFilial("SA2")+"000001")
	While !SA2->(EOF())
		cForn :=  SA2->A2_NOME
		SA2->(DbSkip())
	Enddo
Endif


// O arquivo temporario abaixo visa filtras os PA1 que nao    
// nos interessam no momento.
cArqTRB  := GetNextAlias()

cQuery := "SELECT * FROM "+RetSqlName("SA1")+" TEMPSA1 "
cQuery += "WHERE "
cQuery += "A1_FILIAL   = '" + xFilial("SA1") + "' And "
cQuery += "D_E_L_E_T_ <> '*' "

TcQuery cQuery ALIAS &(cArqTRB) NEW

//DbSelectArea(cArqTRB)

//DbgoTop()                     

While &(cArqTRB)->(!EOF())                                             
	
	DbSelectArea("SE1")
	SE1->(dbSetOrder(2))
	SE1->(DbgoTop())  
	
	If SE1->(DbSeek(xFilial("SE1")+(cArqTRB)->A1_COD))
		If  SE1->E1_TIPO  <> "RA "
			Alert("TESTE")
		ENdif
	Endif
	
    &(cArqTRB)->(DbSkip())
     
Enddo

&(cArqTRB)->(DbCloseArea())

Return