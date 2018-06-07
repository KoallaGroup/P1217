#include 'protheus.ch'
#include 'parmtype.ch'

user function MYATMSA050()
	
Local aCabDTC  := {}
Local aItemDTC := {}
Local aItemEnd := {}
Local aItem    := {}

Private lMsErroAuto := .F.
Private lMsHelpAuto := .T.

// Dados da Nota Fiscal
aCabDTC:=     {{"DTC_FILORI" ,"01"         , Nil},; //Dados da Empresa - filial de origem
        {"DTC_LOTNFC" ,"001130"      , Nil},; //Dados da Empresa - numero da cotacao
       {"DTC_DATENT" ,dDataBase    , Nil},; //Dados da Empresa - Data da Cotacao      
       {"DTC_CLIREM" ,"61064911"          , Nil},; //Dados da Empresa - 
       {"DTC_LOJREM" ,"0001"          , Nil},; //Servico - Regiao de origem 1=Transportadora/2=Cliente Remetente/3=Local Coleta.
       {"DTC_CLIDES" ,"61064911"     , Nil},; //Servico - Codigo da regiao de origem
       {"DTC_LOJDES" ,"0017"  , Nil},; //Servico - Nome Regiao de Origemm(*****)
       {"DTC_DEVFRE" ,"1"     , Nil},; //Servico - Codigo da regiao de destino 
       {"DTC_CLIDEV" ,"61064911" , Nil},; //Servico - Nome da Regiao de Destino(*****)
       {"DTC_LOJDEV" ,"0001"          , Nil},; //Servico - Servico de transporte 1= Coleta / 2=Transporte / 3=Entrega.
       {"DTC_CLICAL" ,"61064911" , Nil},; //Servico - Nome da Regiao de Destino(*****)
       {"DTC_LOJCAL" ,"0001"          , Nil},; //Servico - Servico de transporte 1= Co
       {"DTC_TIPFRE" ,"1"    , Nil},; //Servico - Descricao Servico Tansporte(*****)
       {"DTC_SERTMS" ,"3"          , Nil},; //Servico - Tipo de Transporte 1=Rodoviario / 2=Aereo / 3=Fluvial. 
       {"DTC_TIPTRA" ,"1" , Nil},; //Servico - Descricao Tipo Tansporte 
       {"DTC_SERVIC" ,"001"        , Nil},; //Servico - Servico 
       {"DTC_TIPNFC" ,"0"         , Nil},; //Servico - Tipo NFC
       {"DTC_SELORI" ,"2"          , Nil},; //Servico - KM 
       {"DTC_CDRORI" ,"Q38709"         , Nil},; //Servico - ISS no Preco 
       {"DTC_CDRDES" ,"I25506"         , Nil},; //Servico - Dis Ida/Volt
       {"DTC_NCONTR" ,"1"         , Nil},; //Servico - Dis Ida/Volt
       {"DTC_CODNEG" ,"1"         , Nil},; //Servico - Dis Ida/Volt  
       {"DTC_CDRCAL" ,"I25506"    , Nil}} //Aprovacao - Cliente Remetente

// Itens da NF
Aadd(aItemDTC,{ {"DTC_FILORI" ,"01"         , Nil},; //Dados da Empresa - filial de origem
         {"DTC_LOTNFC" ,"001130"      , Nil},; //Dados da Empresa - numero da cotacao
      {"DTC_NUMNFC" ,"123987456" , Nil},; //Dados da Empresa - Hora da Cotacao 
        {"DTC_SERNFC" ,"011"        , Nil},; //Dados da Empresa - DDD do solicitante
        {"DTC_CODPRO" ,"TMSDIVERSOS    "   , Nil},; //Dados da Empresa - Telefone do solicitante 
        {"DTC_CODEMB" ,"CX"  , Nil},; //Dados da Empresa - Nome Solicitante (*****)
        {"DTC_EMINFC" ,dDataBase  , Nil},; //Dados da Empresa - Prazo de Validade
        {"DTC_QTDVOL" ,1000          , Nil},; //Dados da Empresa - Tipo de Frete (1-CIF / 2-FOB)
        {"DTC_PESO"   ,10000      , Nil},; //Dados da Empresa - Usuario 
        {"DTC_VALOR"  ,10000          , Nil},; //Dados da Empresa - Pessoa (1 - Fisica/ 2 - Juridica)
        {"DTC_EDI"    ,'1'          , Nil}}) //Dados da Empresa - Pessoa (1 - Fisica/ 2 - Juridica)
 

Aadd(aItemEnd,{"123987456011TMSDIVERSOS    ",; //Numero da Nota + Serie + Produto
     {{"01","0000000001     ",500,"",0,.F.},; //1 Array contendo o endereçamento (Local + Armazém + Quantidade)
      {"01","0000000003     ",500,"",0,.F.}}}) //2 Array contendo o endereçamento (Local + Armazém + Quantidade)
    
        
// Executa rotina TMSA050
MSExecAuto({|u,v,x,y,z| TMSA050(u,v,x,y,z)},aCabDTC,aItemDTC,NIL,aItemEnd,3)

// Retorna Resultado do Processo
If lMsErroAuto
 MostraErro()
Else
 MsgInfo("Nota gravada com sucesso!")
EndIf

Return