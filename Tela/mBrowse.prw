#include 'protheus.ch'
#include 'parmtype.ch'


User Function MBrwSA1()

Local cAlias := "SA1"

Local aCores := {}//

Local cFiltra := "A1_FILIAL == '"+xFilial('SA1')+"' .And. A1_EST == 'SP'"

Private cCadastro := "Cadastro de Clientes"

Private aRotina := {}  
//+-----------------------------------------
// op��es de filtro utilizando a FilBrowse
//+-----------------------------------------//

Private aIndexSA1 := {}//

Private bFiltraBrw:= { || FilBrowse(cAlias,@aIndexSA1,@cFiltra) }

//+-----------------------------------------

AADD(aRotina,{"Pesquisar" ,"AxPesqui",0,1})  
//+-----------------------------------------
// quando a fun��o FilBrowse for utilizada a fun��o de pesquisa dever� ser a PesqBrw ao inv�s da AxPesqui
//+-----------------------------------------//

AADD(aRotina,{"Pesquisar" ,"PesqBrw" ,0,1})
//+-----------------------------------------
AADD(aRotina,{"Visualizar" ,"AxVisual",0,2})
AADD(aRotina,{"Incluir" ,"AxInclui",0,3})
AADD(aRotina,{"Alterar" ,"AxAltera",0,4})
AADD(aRotina,{"Excluir" ,"U_Exclui",0,5})
AADD(aRotina,{"Legenda" ,"U_BLegenda" ,0,3})


/*-- CORES DISPONIVEIS PARA LEGENDA --BR_AMARELOBR_AZULBR_BRANCOBR_CINZABR_LARANJABR_MARRONBR_VERDEBR_VERMELHOBR_PINKBR_PRETO*/


AADD(aCores,{"A1_TIPO == 'F'" ,"BR_VERDE" })
AADD(aCores,{"A1_TIPO == 'L'" ,"BR_AMARELO" })
AADD(aCores,{"A1_TIPO == 'R'" ,"BR_LARANJA" })
AADD(aCores,{"A1_TIPO == 'S'" ,"BR_MARRON" })
AADD(aCores,{"A1_TIPO == 'X'" ,"BR_AZUL" })

dbSelectArea(cAlias)
dbSetOrder(1)
//+-----------------------------------------
// op��es de filtro utilizando a FilBrowse
// Cria o filtro na MBrowse utilizando a fun��o FilBrowse
//+-----------------------------------------//
Eval(bFiltraBrw)//
dbSelectArea(cAlias)//
dbGoTop()
//+-----------------------------------------
mBrowse(6,1,22,75,cAlias)
//+-----------------------------------------
// op��es de filtro utilizando a FilBrowse
// Deleta o filtro utilizado na fun��o FilBrowse
//+-----------------------------------------
//
EndFilBrw(cAlias,aIndexSA2)
//+-----------------------------------------
Return Nil

// Exemplo: Determinando a op��o do aRotina pela informa��o recebida em nOpc




User Function Exclui(cAlias, nReg, nOpc)
Local cTudoOk := "(Alert('OK'),.T.)"
Local nOpcao := 0

nOpcao := AxDeleta(cAlias,nReg,nOpc)
// Identifica corretamente a op��o definida para o fun��o em aRotinas com mais
// do que os 5 elementos padr�es.

If nOpcao == 1	
MsgInfo("Exclus�o realizada com sucesso!")
ElseIf nOpcao == 2	
MsgInfo("Exclus�o cancelada!")
Endif
Return Nil

//+-------------------------------------------
//|Fun��o: BLegenda - Rotina de Legenda
//+-------------------------------------------
User Function BLegenda()
Local aLegenda := {}
AADD(aLegenda,{"BR_VERDE" ,"Cons.Final" })
AADD(aLegenda,{"BR_AMARELO" ,"Produtor Rural" })
AADD(aLegenda,{"BR_LARANJA" ,"Revendedor" })
AADD(aLegenda,{"BR_MARRON" ,"Solidario" })
AADD(aLegenda,{"BR_AZUL" ,"Exporta��o" })
BrwLegenda(cCadastro, "Legenda", aLegenda)
Return Nil