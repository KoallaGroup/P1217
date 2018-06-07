#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "TBICONN.CH"

user function MATA185()
	
Local aCamposSCP
Local aCamposSD3

Local aRelProj
Local cNum := "000011" // No.da Requisicao
Local cItem := "01" // No.do Item da Req.
Local cOp := 2
LOCAL aRetCQ := {}


PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" USER 'ADMIN'

Conout("       INICIO do TESTE           ")    
dbSelectArea("SCP")
dbSetOrder(1)
If SCP->(dbSeek(xFilial("SCP")+cNum+cItem))
        aCamposSCP := { {"CP_NUM" ,SCP->CP_NUM ,Nil },;
                                      {"CP_ITEM" ,SCP->CP_ITEM ,Nil },;
                                      {"CP_QUANT" ,SCP->CP_QUANT ,Nil }}

         aCamposSD3 := { {"D3_TM" ,"002" ,Nil },; // Tipo do Mov. 
                                      {"D3_COD" ,SCP->CP_PRODUTO,Nil },;
                                      {"D3_LOCAL" ,SCP->CP_LOCAL ,Nil },;
                                      {"D3_DOC"        ,"TESTE1"         ,Nil },;  // No.do Docto.
                                      {"D3_EMISSAO" ,DDATABASE ,Nil }}


    /*   //Dados para atualização do vinculo com pms (opcional)
        aRelProj := {}
        aAdd(aRelProj,{})
        aAdd(aRelProj[1],{"AFH_PROJET" ,"Projeto1  " ,Nil })
        aAdd(aRelProj[1],{"AFH_TAREFA" ,"01.01       " ,Nil })
        aAdd(aRelProj[1],{"AFH_QBAIX" ,1 ,Nil })

        aAdd(aRelProj,{})
        aAdd(aRelProj[2],{"AFH_PROJ" ,"Projeto2  " ,Nil })
        aAdd(aRelProj[2],{"AFH_TAREFA" ,"01.01       " ,Nil })
        aAdd(aRelProj[2],{"AFH_QBAIX" ,2 ,Nil })

     */

        lMSHelpAuto := .F.
        lMsErroAuto := .F.

        MSExecAuto({|v,x,y,z,w| mata185(v,x,y,z,w)},aCamposSCP,aCamposSD3,cOp,,aRelProj)   // 1 = BAIXA (ROT.AUT)

        If lMsErroAuto
               
               IF cOP == 1
               Conout("Baixado Com sucesso")
               ElseIF cOP == 2
               Conout("Estornado Com sucesso")
               ENDIF
        
                MostraErro()
        EndIF

Else
        Aviso("SIGAEST", "Req. nao encontrada", {" Ok "}) 
EndIf

Return Nil