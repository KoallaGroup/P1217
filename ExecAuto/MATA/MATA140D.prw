#Include 'Protheus.ch'
#include "tbiconn.ch"

User Function MATA140D()

Private lMsErroAuto := .F.
Private lMsHelpAuto := .T.
		
_aCabec := {}
_aItens := {}

ConOut(PadC(OemToAnsi("Teste de Devolução"),80))

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM" TABLES "SF1","SD1","SA1","SA2","SB1","SB2","SF4"


        aadd(_aCabec,{"F1_TIPO"   ,'D'          ,Nil})
        aadd(_aCabec,{"F1_FORMUL" ,'S'          ,Nil})
        aadd(_aCabec,{"F1_DOC"    ,"000005   "  ,Nil})
        aadd(_aCabec,{"F1_SERIE"  ,"1  "         ,Nil}) 
        aadd(_aCabec,{"F1_EMISSAO",dDataBase    ,Nil})
        aadd(_aCabec,{"F1_FORNECE","2     "     ,Nil}) 
        aadd(_aCabec,{"F1_LOJA"   ,"1 "         ,Nil}) 
        aadd(_aCabec,{"F1_ESPECIE",'NF'       ,Nil})    
                                     
 /*       dbSelectArea("SD2")
        DBSetOrder(3)   && D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM  
        DbSeek(xFilial("SD2")+'000002   '+"1  "+"2     "+"1 "+"2              "+"01")
        If Eof()
		  lMsErroAuto := .F.
          Alert("Nota fiscal " +_cNFORI + " não localizada !")
          return (.f.)
        EndIf */
        
	aLinha := {}
	aadd(aLinha,{"D1_COD"    ,"2              "     ,Nil}) 
	aadd(aLinha,{"D1_QUANT"  ,2               ,Nil})  
	aadd(aLinha,{"D1_VUNIT"  ,100  ,Nil})
	aadd(aLinha,{"D1_TOTAL"  ,200  ,Nil})   
	aadd(aLinha,{"D1_TES"    ,"101"           ,Nil})   
	aadd(aLinha,{"D1_ITEMORI","01  "    ,Nil})   
	aadd(aLinha,{"D1_NFORI"  ,'000005   '     ,Nil}) 
	aadd(aLinha,{"D1_SERIORI","1  "   ,Nil}) 
	aadd(aLinha,{"D1_FORNECE","2     " ,Nil}) 
	aadd(aLinha,{"D1_LOJA"   ,"1 "    ,Nil}) 
//	aadd(aLinha,{"D1_CONTA"  ,SD2->D2_CONTA   ,Nil}) 
//	aadd(aLinha,{"D1_CC"     ,SD2->D2_CCUSTO  ,Nil}) 
//	aadd(aLinha,{"D1_CF"     ,"1949"          ,Nil}) 
	aadd(aLinha,{"AUTDELETA" , "N"            , Nil})
	aadd(_aItens,aLinha)
		                                 
	MSExecAuto({|x,y,z|Mata140(x,y,z)},_aCabec,_aItens,3)
   

	    If lMsErroAuto
	      MostraErro() 
	      lMsErroAuto := .F.
	    Else 
              Alert("Entrada de Devolução realizada !")
	    EndIf
//RESET ENVIRONMENT



Return(.T.)



