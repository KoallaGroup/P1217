#include 'protheus.ch'
#include 'parmtype.ch'
#include "tbiconn.ch"


user function m2FINA070()
 
Local aBaixa := {}
PRIVATE lMsErroAuto := .F.

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" 
 
aBaixa := {{"E1_FILIAL"  ,"01"                  ,Nil    },;
		   {"E1_NUM"      ,"0000001  "            ,Nil    },;
           {"E1_TIPO"     ,"NF "                  ,Nil    },;
           {"E1_PARCELA"     ,"02"                  ,Nil    },;
           {"E1_NATUREZ"     ,"2         "                  ,Nil    },;
           {"AUTMOTBX"    ,"NOR"                  ,Nil    },;
           {"AUTBANCO"    ,"CX1"                  ,Nil    },;
           {"AUTAGENCIA"  ,"00001"                ,Nil    },;
           {"AUTCONTA"    ,"0000000001"           ,Nil    },;
           {"AUTDTBAIXA"  ,dDataBase              ,Nil    },;
           {"AUTDTCREDITO",dDataBase              ,Nil    },;
           {"AUTHIST"     ,"BAIXA TESTE"          ,Nil    },;
           {"AUTJUROS"    ,0                      ,Nil,.T.},;
           {"AUTVALREC"   ,700                    ,Nil    }}
 
MSExecAuto({|x,y| Fina070(x,y)},aBaixa,3) 

If lMsErroAuto
    MostraErro()
Else
    Alert("Baixa Realizada com sucesso!")
Endif
 
Return