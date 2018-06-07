//Exemplo de uma forma simples de se efetuar uma movimentação bancária a pagar, a receber ou transferências entre contas correntes de forma automática (sem a apresentação de telas).

#INCLUDE "Protheus.ch"

User Function TST100()
Local nOpc     := 0
Local aFINA100 := {}

Private lMsErroAuto := .F.

While .T.

    nOpc := 0
    nOpc := Aviso("TESTE EXECAUTO DO FINA100", "Escolha a opção do menu da rotina FINA100 a ser executada via EXECAUTO",{"PAGAR","RECEBER","EXCLUIR","CANCELAR","TRANSF.","EST. TRANSF.","SAIR"})
    
    If nOpc == 1   
        aFINA100 := {    {"E5_DATA"        ,dDataBase                    ,Nil},;
                            {"E5_MOEDA"        ,"R$"                            ,Nil},;
                            {"E5_VALOR"         ,500                            ,Nil},;
                            {"E5_NATUREZ"    ,"1         "                    ,Nil},;
                            {"E5_BANCO"        ,"001"                        ,Nil},;
                            {"E5_AGENCIA"    ,"155  "                        ,Nil},;
                            {"E5_CONTA"        ,"95919     "                        ,Nil},;
                            {"E5_BENEF"        ,"TESTE AUTO - BENEF"    ,Nil},;
                            {"E5_HISTOR"    ,"TESTE AUTO - AUTO"        ,Nil}}
    
        MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,3)
    
        If lMsErroAuto
            MostraErro()
        Else
            MsgAlert("Movto. Bancario Pagar incluido com sucesso !!!")
        EndIf       
        
    ElseIf nOpc == 2
        aFINA100 := {    {"E5_DATA"        ,dDataBase                    ,Nil},;
                              {"E5_MOEDA"        ,"01"                            ,Nil},;
                            {"E5_VALOR"         ,500                            ,Nil},;
                            {"E5_NATUREZ"    ,"CHEQUE    "                    ,Nil},;
                            {"E5_BANCO"        ,"CX1"                        ,Nil},;
                            {"E5_AGENCIA"    ,"00001"                        ,Nil},;
                            {"E5_CONTA"        ,"0000000001"                        ,Nil},;
                            {"E5_HISTOR"    ,"TESTE AUTO - AUTO"        ,Nil}}
    
        MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,4)
    
        If lMsErroAuto
            MostraErro()
        Else
            MsgAlert("Movto. Bancario Receber incluido com sucesso !!!")
        EndIf       
    
    ElseIf nOpc == 3
        dbSelectArea("SE5")
        SE5->(dbSetOrder(1))
        SE5->(dbSeek(xFilial("SE5")+DToS(dDataBase) ))
        aFINA100 := {    {"E5_DATA"             ,SE5->E5_DATA            ,Nil},;
                            {"E5_MOEDA"             ,SE5->E5_MOEDA            ,Nil},;
                            {"E5_VALOR"             ,SE5->E5_VALOR            ,Nil},;
                            {"E5_NATUREZ"        ,SE5->E5_NATUREZ        ,Nil},;
                            {"E5_BANCO"            ,SE5->E5_BANCO            ,Nil},;
                            {"E5_AGENCIA"         ,SE5->E5_AGENCIA        ,Nil},;
                            {"E5_CONTA"         ,SE5->E5_CONTA            ,Nil},;
                            {"E5_HISTOR"        ,SE5->E5_HISTOR        ,Nil},;
                            {"E5_TIPOLAN"        ,SE5->E5_TIPOLAN        ,Nil} }
    
        MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,5)
    
        If lMsErroAuto
            MostraErro()
        Else
            MsgAlert("Exclusão realizada com sucesso !!!")
        EndIf       

    ElseIf nOpc == 4
        dbSelectArea("SE5")
        SE5->(dbSetOrder(1))
        SE5->(dbSeek(xFilial("SE5")+DToS(dDataBase) ))
        dbSkip() //colocado apenas para esta sequencia de testes
        aFINA100 := {    {"E5_DATA"             ,SE5->E5_DATA            ,Nil},;
                            {"E5_MOEDA"             ,SE5->E5_MOEDA            ,Nil},;
                            {"E5_VALOR"             ,SE5->E5_VALOR            ,Nil},;
                            {"E5_NATUREZ"        ,SE5->E5_NATUREZ        ,Nil},;
                            {"E5_BANCO"            ,SE5->E5_BANCO            ,Nil},;
                            {"E5_AGENCIA"         ,SE5->E5_AGENCIA        ,Nil},;
                            {"E5_CONTA"         ,SE5->E5_CONTA            ,Nil},;
                            {"E5_HISTOR"        ,SE5->E5_HISTOR        ,Nil},;
                            {"E5_TIPOLAN"        ,SE5->E5_TIPOLAN        ,Nil} }
    
        MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,6)
    
        If lMsErroAuto
            MostraErro()
        Else
            MsgAlert("Cancelamento realizada com sucesso !!!")
        EndIf       

    
    ElseIf nOpc == 5
        aFINA100 := {    {"CBCOORIG"             ,"C01"                            ,Nil},;
                            {"CAGENORIG"        ,"00001"                            ,Nil},;
                            {"CCTAORIG"             ,"0000000001"                            ,Nil},;
                            {"CNATURORI"         ,"DINHEIRO  "                            ,Nil},;
                            {"CBCODEST"            ,"CX1"                            ,Nil},;
                            {"CAGENDEST"         ,"00001"                            ,Nil},;
                            {"CCTADEST"         ,"0000000001"                            ,Nil},;
                            {"CNATURDES"        ,"DINHEIRO  "                            ,Nil},;
                            {"CTIPOTRAN"        ,"R$"                                ,Nil},;
                            {"CDOCTRAN"            ,"0000003        "                        ,Nil},;
                            {"NVALORTRAN"        ,2000                                ,Nil},;
                            {"CHIST100"            ,"TESTE TRF VIA EXECAUTO"    ,Nil},;
                            {"CBENEF100"        ,"TESTE TRF VIA EXECAUTO"    ,Nil} }
    
        MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,7)
    
        If lMsErroAuto
            MostraErro()
        Else
            MsgAlert("Transferência executada com sucesso !!!")
        EndIf       
                    
    //Estorno da Transferencia
    ElseIf nOpc == 6
        aFINA100 := {    {"AUTNRODOC"         ,"123456"                ,Nil},;
                            {"AUTDTMOV"            ,dDataBase                ,Nil},;
                            {"AUTBANCO"             ,"001"                    ,Nil},;
                            {"AUTAGENCIA"     ,"001"                    ,Nil},;
                            {"AUTCONTA"            ,"001"                    ,Nil} }
                    
        MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,8)
    
        If lMsErroAuto
            MostraErro()
        Else
            MsgAlert("Transferência cancelada com sucesso !!!")
        EndIf       
    EndIf
    If nOpc == 7
        Exit
    Endif
Enddo
    
Return(Nil)