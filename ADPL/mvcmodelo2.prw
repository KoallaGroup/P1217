#include 'protheus.ch'
#include 'parmtype.ch'
#include "tbiconn.ch"
#Include 'FWMVCDef.ch'


User Function Mod2_MVC()

Local oBrowse
Private aRotina := MenuDef()

oBrowse := FWmBrowse():New()
oBrowse:SetAlias( 'ZA2' )
oBrowse:SetDescription( 'Musicas' )
oBrowse:Activate()

Return NIL
//-------------------------------------------------------------------
Static Function MenuDef()
Local aRotina := {}

ADD OPTION aRotina Title 'Visualizar'  Action 'VIEWDEF.Mod2_MVC' OPERATION 2 ACCESS 0
ADD OPTION aRotina Title 'Incluir'     Action 'VIEWDEF.Mod2_MVC' OPERATION 3 ACCESS 0
ADD OPTION aRotina Title 'Alterar'     Action 'VIEWDEF.Mod2_MVC' OPERATION 4 ACCESS 0
ADD OPTION aRotina Title 'Excluir'     Action 'VIEWDEF.Mod2_MVC' OPERATION 5 ACCESS 0

Return aRotina

//-------------------------------------------------------------------
Static Function ModelDef()
// Cria a estrutura a ser usada no Modelo de Dados
Local oStTmp   := FWFormModelStruct():New()
Local oStruZA2 := FWFormStruct( 1, 'ZA2', /*bAvalCampo*/, /*lViewUsado*/ )
Local oModel

oStTmp:AddTable('ZA2', {'ZA2_MUSICA'}, "Cabecalho ZA2")

oStTmp:AddField(;
  "Musica",;                                                                                  // [01]  C   Titulo do campo
  "Musica",;                                                                                  // [02]  C   ToolTip do campo
  "ZA2_MUSICA",;                                                                               // [03]  C   Id do Field
  "C",;                                                                                       // [04]  C   Tipo do campo
  TamSX3("ZA2_MUSICA")[1],;                                                                    // [05]  N   Tamanho do campo
  0,;                                                                                         // [06]  N   Decimal do campo
  Nil,;                                                                                       // [07]  B   Code-block de validação do campo
  Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
  {},;                                                                                        // [09]  A   Lista de valores permitido do campo
  .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
  FwBuildFeature( STRUCT_FEATURE_INIPAD, "ZA2_MUSICA" ),;   // [11]  B   Code-block de inicializacao do campo
  .T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
  .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
  .F.)         

// Cria o objeto do Modelo de Dados
oModel := MPFormModel():New( 'Mod2M', /*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/, /*bCancel*/ )

// Adiciona ao modelo uma estrutura de formulário de edição por campo
oModel:AddFields( 'ZA2MASTER', /*cOwner*/, oStTmp )

// Adiciona ao modelo uma estrutura de formulário de edição por grid
oModel:AddGrid( 'ZA2DETAIL', 'ZA2MASTER', oStruZA2, /*bLinePre*/, /*bLinePost*/, {|oModelGrid|tstPreValid(oModelGrid)}/*bPreVal*/, /*bPosVal*/, /*BLoad*/ )

// Faz relaciomaneto entre os compomentes do model
oModel:SetRelation( 'ZA2DETAIL', { { 'ZA2_FILIAL', 'xFilial( "ZA2" )' }, { 'ZA2_MUSICA', 'ZA2_ITEM' } }, ZA2->( IndexKey( 1 ) ) )

// Liga o controle de nao repeticao de linha
oModel:GetModel( 'ZA2DETAIL' ):SetUniqueLine( { 'ZA2_AUTOR' } )

// Adiciona a descricao do Modelo de Dados
oModel:SetDescription( 'Modelo de Musicas' )

// Adiciona a descricao do Componente do Modelo de Dados
oModel:GetModel( 'ZA2DETAIL' ):SetDescription( 'Dados do Autor Da Musica'  )

Return oModel


//-------------------------------------------------------------------
Static Function ViewDef()
// Cria um objeto de Modelo de Dados baseado no ModelDef do fonte informado
Local oModel := ModelDef()
Local oView 
Local oStTmp  := FWFormViewStruct():New()
Local oStr2   := FWFormStruct(2, 'ZA2')

oView := FWFormView():New()
oView:SetModel( oModel )

oView:AddField('ZA2MASTER' , oStTmp)
oView:AddGrid('ZA2DETAIL' , oStr2) 

oView:CreateHorizontalBox( 'BOX6', 100)
oView:CreateFolder( 'FOLDER7', 'BOX6')

oView:AddSheet('FOLDER7','SHEET9','SHEET9')
oView:CreateHorizontalBox( 'BOXFORM2', 100, , , 'FOLDER7', 'SHEET9')

oView:AddSheet('FOLDER7','SHEET8','SHEET8')
oView:CreateHorizontalBox( 'BOXFORM4', 100, , , 'FOLDER7', 'SHEET8')

oView:SetOwnerView('ZA2MASTER','BOXFORM2')
oView:SetOwnerView('ZA2DETAIL','BOXFORM4')


Return oView