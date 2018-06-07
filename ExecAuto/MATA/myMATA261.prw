#INCLUDE "PROTHEUS.CH"
#include "rwmake.ch"
#include "TbiConn.ch"
User Function myMATA261()
 Local cProd := "1"
 Local cUM := ""
 Local cLocal := ""
 Local cDoc := ""
 Local cLote := ""//LOTE01    "
 Local dDatVal := ""
 Local nQuant := 10
 Local lOk := .T.
 Local aItem := {}
 Local nX := 0
 Local nOpcAuto := 3 // Indica qual tipo de acao sera tomada (Inclusao/Exclusao)
 PRIVATE lMsHelpAuto := .T.
 PRIVATE lMsErroAuto := .F.
 //Abertura do ambiente                                      |
 PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"// MODULO "EST"
 DbSelectArea("SB1")
 DbSetOrder(1)
 If !SB1->(MsSeek(xFilial("SB1")+cProd))
  lOk := .F.
  ConOut(OemToAnsi("Cadastrar produto: " + cProd))
 Else
  cProd := B1_COD
  cDescri := B1_DESC
  cUM := B1_UM
  cLocal := B1_LOCPAD
 EndIf
 If lOk
//  cDoc    := GetSxENum("SD3","D3_DOC",1)
  
  cDOC := '000000003'
  
  ConOut(Repl("-",80))
  ConOut(PadC("Teste de Transf. Mod2",80))
  ConOut("Inicio: "+Time())
  Begin Transaction // Teste de Inclusao
      //Cabecalho a Incluir
      aAuto := {}
      aadd(aAuto,{cDOC,dDataBase}) //Cabecalho
      //Itens a Incluir
      aadd(aItem,cProd)      //D3_COD  (Origem)
      aadd(aItem,cDescri)  //D3_DESCRI    (Origem)
      aadd(aItem,cUM)      //D3_UM  (Origem)
      aadd(aItem,cLocal)      //D3_LOCAL  (Origem)
      aadd(aItem,"")        //D3_LOCAL    (Origem)
      aadd(aItem,cProd)      //D3_COD  (Destino)
      aadd(aItem,cDescri)  //D3_DESCRI    (Destino)
      aadd(aItem,cUM)      //D3_UM  (Destino)
      aadd(aItem,"1")    //D3_LOCAL  (Destino)
      aadd(aItem,"")      //D3_LOCALIZ    (Destino)
      aadd(aItem,"")      //D3_NUMSERI
      aadd(aItem,cLote)      //D3_LOTECTL
      aadd(aItem,"")      //D3_NUMLOTE
      aadd(aItem,dDataBase)    //D3_DTVALID
      aadd(aItem,0)    //D3_POTENCI
      aadd(aItem,10)      //D3_QUANT
      aadd(aItem,0)    //D3_QTSEGUM
      aadd(aItem,"")      //D3_ESTORNO
      aadd(aItem,"1")      //D3_NUMSEQ
      aadd(aItem,cLote)      //D3_LOTECTL
      aadd(aItem,dDataBase)    //D3_DTVALID
      aadd(aItem,"")      //D3_ITEMGRD
     // aadd(aitem,"      ")//"D3_IDDCF"
      aadd(aitem,"                              ")//"D3_OBSERVA"

     
      aadd(aAuto,aItem)
     
      MSExecAuto({|x,y| mata261(x,y)},aAuto,nOpcAuto)
      If !lMsErroAuto
    ConOut("Incluido com sucesso! " + cDoc)
      Else
    ConOut("Erro na inclusao!")
    MostraErro()
      EndIf
      ConOut("Fim  : "+Time())
  End Transaction
 EndIf
 //RESET ENVIRONMENT
Return Nil