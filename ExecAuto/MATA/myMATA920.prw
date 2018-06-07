#Include 'Protheus.ch'

User Function myMATA920()


#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

User Function MyMata920()
Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nX     := 0
Local nY     := 0
Local cDoc   := ""
Local lOk    := .T.
PRIVATE lMsErroAuto := .F.

//-- Abertura do ambiente
ConOut(Repl("-",80))
ConOut(PadC("Teste de Inclusao",80))

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FIS" TABLES "SF2","SD2","SA1","SA2","SB1","SB2","SF4"

 ConOut("Inicio: "+Time())
 //-- Verifica o ultimo documento valido para um fornecedor
 dbSelectArea("SF2")
 dbSetOrder(2)
 MsSeek(xFilial("SF2")+Padr("2     ",Len(SA1->A1_COD))+"1 ",.T.)
 dbSkip(-1)
 cDoc := SF2->F2_DOC
 aCabec := {}
 aItens := {}

  If Empty(cDoc)
   cDoc := StrZero(1,Len(SD2->D2_DOC))
  Else
   cDoc := Soma1(cDoc)
  EndIf
  aadd(aCabec,{"F2_TIPO"   ,"C"})
  aadd(aCabec,{"F2_FORMUL" ,"N"})
  aadd(aCabec,{"F2_DOC"    ,(cDoc)})
  aadd(aCabec,{"F2_SERIE"  ,"UNI"})
  aadd(aCabec,{"F2_EMISSAO",dDataBase})
  aadd(aCabec,{"F2_CLIENTE",Padr("2     ",Len(SA1->A1_COD))})
  aadd(aCabec,{"F2_LOJA"   ,"1 "})
  aadd(aCabec,{"F2_ESPECIE","NF"})
  aadd(aCabec,{"F2_COND","001"})
  aadd(aCabec,{"F2_DESCONT",0})
  aadd(aCabec,{"F2_FRETE",0})
  aadd(aCabec,{"F2_SEGURO",0})
  aadd(aCabec,{"F2_DESPESA",0})
  If cPaisLoc == "PTG"         
   aadd(aCabec,{"F2_DESNTRB",0})
   aadd(aCabec,{"F2_TARA",0})
  Endif
  aLinha := {}
   aadd(aLinha,{"D2_COD"  ,"2     ",Nil})
   aadd(aLinha,{"D2_ITEM" ,StrZero(nX,2),Nil})
//   aadd(aLinha,{"D2_QUANT",1,Nil})
   aadd(aLinha,{"D2_PRCVEN",100,Nil})
   aadd(aLinha,{"D2_TOTAL",100,Nil})
   aadd(aLinha,{"D2_TES","501",Nil})
   aadd(aLinha,{"D2_NFORI","000001   ",Nil})
   aadd(aLinha,{"D2_SERIORI","A  ",Nil})
   aadd(aItens,aLinha)

  //-- Teste de Inclusao
  MATA920(aCabec,aItens,3)
  If !lMsErroAuto
   ConOut("Incluido com sucesso! "+cDoc)
  Else
   MostraErro()
   ConOut("Erro na inclusao!")
  EndIf
 
 ConOut("Fim  : "+Time())
 
RESET ENVIRONMENT

Return(.T.)



