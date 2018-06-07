#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"
//#INCLUDE "FATA600.CH"
#INCLUDE "TBICONN.CH"

User Function myFT600()


Local nOperation      := 3
Local aADZProduto  := {}
Local aADYMaster   := {}
Local aADZAcessor := {}
Local lRetorno          := .T.
Private lMsErroAuto := .F.

conout( "INICIO FT600")

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
//RpcSetEnv( "99", "01", "Admin", "",,, )

conout( "Cabeçalho")
//-----------------------------------------------
// Cabeçalho da Proposta Comercial
//----------------------------------------------
aAdd( aADYMaster, {"ADY_OPORTU", "000143", Nil } )
aAdd( aADYMaster, {"ADY_REVISA", "01", Nil } )
aAdd( aADYMaster, {"ADY_DATA", dDatabase, Nil } )
aAdd( aADYMaster, {"ADY_ENTIDA", "1", Nil } ) //1=Cliente; 2=Prospect
aAdd( aADYMaster, {"ADY_CODIGO", "1", Nil } )
aAdd( aADYMaster, {"ADY_LOJA", "01", Nil } )
aAdd( aADYMaster, {"ADY_TABELA", "001", Nil } )

conout( "Itens da Proposta")
//-----------------------------------------------
// Itens da Proposta Comercial - Folder Produtos
//-----------------------------------------------
aAdd( aADZProduto,{ {"ADZ_PRODUT", "PAL", Nil } ,;
{"ADZ_CONDPG", "001", Nil } ,;
{"ADZ_TES", "520", Nil } ,;
{"ADZ_QTDVEN", 2, Nil } ,; 
{"ADZ_CODAGR", "000004", Nil },;
{"ADZ_CODNIV", "001", Nil } } )

//-------------------------------------------------
// Itens da Proposta Comercial - Folder Acessórios
//-------------------------------------------------
aAdd( aADZAcessor, { {"ADZ_PRODUT", "PAL", Nil },;
{"ADZ_CONDPG", "001", Nil } ,;
{"ADZ_TES", "520", Nil } ,;
{"ADZ_QTDVEN", 4, Nil } } )
conout( "Gravação")

FATA600( /*oMdlFt300*/, nOperation, aADYMaster, aADZProduto, aADZAcessor )

If lMsErroAuto 
    lRetorno := .F.
    DisarmTransaction()
    MostraErro()
Else
    Conout( "Proposta incluída com sucesso.!" )
EndIf 

RpcClearEnv()

Return(lRetorno)

Return

