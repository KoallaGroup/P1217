#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "TBICONN.CH"

user function MATA410exc(cNUM)

Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nX     := 0
Local nY     := 0
Local cDoc   := ""
Local lOk    := .T.
//Local cNumPedido := "000002"
Private lMsErroAuto := .F.  

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"

DbSelectArea("SC5")
DbSetOrder(1)
DbSeek(xFilial("SC5")+cvaltochar(cNUM))

        aadd(aCabec,{"C5_NUM"   ,SC5->C5_NUM,Nil})
        aadd(aCabec,{"C5_TIPO" ,SC5->C5_TIPO,Nil})
        aadd(aCabec,{"C5_CLIENTE",SC5->C5_CLIENTE,Nil})
        aadd(aCabec,{"C5_LOJACLI",SC5->C5_LOJACLI,Nil})
        aadd(aCabec,{"C5_LOJAENT",SC5->C5_LOJAENT,Nil})
        aadd(aCabec,{"C5_CONDPAG",SC5->C5_CONDPAG,Nil})


        DbSelectArea("SC6")
        DbSetOrder(1)
        DbSeek(xFilial("SC6")+cvaltochar(cNUM)+"01"+"2              ")


            aadd(aLinha,{"C6_ITEM",SC6->C6_ITEM,Nil})
            aadd(aLinha,{"C6_PRODUTO",SC6->C6_PRODUTO,Nil})
            aadd(aLinha,{"C6_QTDVEN",SC6->C6_QTDVEN,Nil})
            aadd(aLinha,{"C6_PRCVEN",SC6->C6_PRCVEN,Nil})
            aadd(aLinha,{"C6_PRUNIT",SC6->C6_PRUNIT,Nil})
            aadd(aLinha,{"C6_VALOR",SC6->C6_VALOR,Nil})
            aadd(aLinha,{"C6_TES",SC6->C6_TES,Nil})
            aadd(aItens,aLinha)



     //   IF  msgyesno("Deseja excluir o pedido alterado :"+cvaltochar(SC5->C5_NUM))
        	MATA410(aCabec,aItens,5)
        	If !lMsErroAuto
        		ConOut("Excluido com sucesso! "+cvaltochar(cNUM))
        	Else
        	    Mostraerro()	
        		ConOut("Erro na inclusao!")
        	EndIf
       // Else
        
        //	ConOut("Produto não Excluido")                
        //ENDIF
	
return