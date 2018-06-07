#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "TBICONN.CH"

user function MATA410alt()

Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nX     := 0
Local nY     := 0
Local cDoc   := ""
Local lOk    := .T.
Private cNumPedido := "000002"
Private lMsErroAuto := .F.  

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"

DbSelectArea("SC5")
DbSetOrder(1)
DbSeek(xFilial("SC5")+cNumPedido)


        
        aadd(aCabec,{"C5_NUM"   ,SC5->C5_NUM,Nil})
        aadd(aCabec,{"C5_TIPO" ,SC5->C5_TIPO,Nil})
        aadd(aCabec,{"C5_CLIENTE",SC5->C5_CLIENTE,Nil})
        aadd(aCabec,{"C5_LOJACLI",SC5->C5_LOJACLI,Nil})
        aadd(aCabec,{"C5_LOJAENT",SC5->C5_LOJAENT,Nil})
        aadd(aCabec,{"C5_CONDPAG",SC5->C5_CONDPAG,Nil})


        DbSelectArea("SC6")
        DbSetOrder(1)
        DbSeek(xFilial("SC6")+cNumPedido+"02"+"2              ")


            aadd(aLinha,{"C6_ITEM",SC6->C6_ITEM,Nil})
            aadd(aLinha,{"C6_PRODUTO",SC6->C6_PRODUTO,Nil})
            aadd(aLinha,{"C6_QTDVEN",SC6->C6_QTDVEN,Nil})
            aadd(aLinha,{"C6_PRCVEN",SC6->C6_PRCVEN,Nil})
            aadd(aLinha,{"C6_PRUNIT",SC6->C6_PRUNIT,Nil})
            aadd(aLinha,{"C6_VALOR",SC6->C6_VALOR,Nil})
            aadd(aLinha,{"C6_TES",SC6->C6_TES,Nil})
            aadd(aItens,aLinha)




        MSExecAuto({|x,y,z| mata410(x,y,z)},aCabec,aItens,4)
        If !lMsErroAuto
            ConOut("ALTERADO com sucesso! "+cDoc)
        Else
            ConOut("Erro na inclusao!")
            MostraErro()
        EndIf
        
        
//        startjob("U_MATA410exc()",getenvserver(),.T.,cNumPedido)
        
        
 
return