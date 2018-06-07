#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "rwmake.ch"

user function FINA330()
	

Local lRetOK := .T.
Local aArea  := GetArea()

Local nTaxaCM := 0
Local aTxMoeda := {}

Private nRecnoNDF
Private nRecnoE1

dbSelectArea("SE1")
dbSetOrder(2) // E1_FILIAL, E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, R_E_C_N_O_, D_E_L_E_T_

             IF dbSeek(XFILIAL("SE1")+"2     "+"1 "+"1  "+"000004   "+"A "+"NCC")
             nRecnoRA := RECNO()
                          IF dbSeek(XFILIAL("SE1")+"2     "+"1 "+"   "+"000000091"+"01"+"NF ")
                                       nRecnoE1 := RECNO()

                                       PERGUNTE("AFI340",.F.)
                                       lContabiliza  := MV_PAR11 == 1
                                       lAglutina   := MV_PAR08 == 1
                                       lDigita   := MV_PAR09 == 1

nTaxaCM := RecMoeda(dDataBase,SE1->E1_MOEDA)

aAdd(aTxMoeda, {1, 1} )

aAdd(aTxMoeda, {2, nTaxaCM} )


                                       SE1->(dbSetOrder(1)) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_FORNECE+E1_LOJA
  
                                       aRecRA := { nRecnoRA }
                                       aRecSE1 := { nRecnoE1 }
   
                                       If !MaIntBxCR(3,aRecSE1,,aRecRA,,{lContabiliza,lAglutina,lDigita,.F.,.F.,.F.},,,,,250,,,,,,.t. )
                                                    Help("XAFCMPAD",1,"HELP","XAFCMPAD","Não foi possível a compensação"+CRLF+" do titulo do adiantamento",1,0)
                                                    lRet := .F.
                                       ENDIF
                          ENDIF
             ENDIF

RestArea(aArea)

Return lRetOK