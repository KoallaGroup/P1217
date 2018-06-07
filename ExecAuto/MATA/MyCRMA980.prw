#include 'protheus.ch'
#include 'parmtype.ch'

user function MyCRMA980()
	
Local aSA1Auto  := {}
Local aAI0Auto  := {}
Local nOpcAuto  := 3
Local lRet      := .T.
 
Private lMsErroAuto := .F.
 
lRet := RpcSetEnv("99","01","Admin")
 
If lRet
     
    //----------------------------------
    // Dados do Cliente
    //----------------------------------
    aAdd(aSA1Auto,{"A1_COD"     ,"XBX139"               ,Nil})
    aAdd(aSA1Auto,{"A1_LOJA"    ,"01"                   ,Nil})
    aAdd(aSA1Auto,{"A1_NOME"    ,"ROTINA AUTOMATICA"    ,Nil})
    aAdd(aSA1Auto,{"A1_NREDUZ"  ,"ROTAUTO"              ,Nil}) 
    aAdd(aSA1Auto,{"A1_TIPO"    ,"F"                    ,Nil})
    aAdd(aSA1Auto,{"A1_END"     ,"BRAZ LEME"            ,Nil}) 
    aAdd(aSA1Auto,{"A1_BAIRRO"  ,"CASA VERDE"           ,Nil}) 
    aAdd(aSA1Auto,{"A1_EST"     ,"SP"                   ,Nil})
    aAdd(aSA1Auto,{"A1_MUN"     ,"SAO PAULO"            ,Nil})
     
    //---------------------------------------------------------
    // Dados do Complemento do Cliente
    //---------------------------------------------------------
    aAdd(aAI0Auto,{"AI0_SALDO"  ,30                     ,Nil})
     
    //------------------------------------
    // Chamada para cadastrar o cliente.
    //------------------------------------
    MSExecAuto({|a,b,c| CRMA980(a,b,c)}, aSA1Auto, nOpcAuto, aAI0Auto)
      
    If lMsErroAuto  
        lRet := lMsErroAuto
    Else
        Conout("Cliente inclu�do com sucesso!")
    EndIf
     
EndIf
 
RpcClearEnv()
              
Return lRet