#include 'protheus.ch'
#include 'parmtype.ch'

User Function MyAtfa012

Local aArea := GetArea()
Local cBase := "0000000001"
Local cItem := "0000"
Local cDescri := "TESTE"
Local nQtd := 1
Local cChapa := "00000"
Local cPatrim := "N"
Local cGrupo := "01"
Local dAquisic := dDataBase 
Local dIndDepr := RetDinDepr(dDataBase)
Local cDescric := "Teste ATFA012"
Local nQtd := 2
Local cChapa := "00000"
Local cPatrim := "N"
Local cTipo := "01"
Local cHistor := "TESTE "
Local cContab := "3.1.1               "
Local cCusto := "CDL"
Local nValor := 1000
Local nTaxa := 10
Local nTamBase := TamSX3("N3_CBASE")[1]
Local nTamChapa := TamSX3("N3_CBASE")[1]
Local cGrupo := "0001" 
Local aParam := {}

Local aCab := {}
Local aItens := {}

 Private lMsErroAuto := .F.
Private lMsHelpAuto := .T.

aCab := {}
AAdd(aCab,{"N1_CBASE" , cBase ,NIL})
AAdd(aCab,{"N1_ITEM" , cItem ,NIL})
AAdd(aCab,{"N1_AQUISIC", dDataBase ,NIL})
AAdd(aCab,{"N1_DESCRIC", cDescric ,NIL})
AAdd(aCab,{"N1_QUANTD" , nQtd ,NIL})
AAdd(aCab,{"N1_CHAPA" , cChapa ,NIL})
AAdd(aCab,{"N1_PATRIM" , cPatrim ,NIL})
//AAdd(aCab,{"N1_GRUPO" , cGrupo ,NIL})

 

aItens := {}
//-- Preenche itens

 
AAdd(aItens,{; 
{"N3_CBASE" , cBase ,NIL},;
{"N3_ITEM" , cItem ,NIL},;
{"N3_TIPO" , cTipo ,NIL},;
{"N3_BAIXA" , "0" ,NIL},;
{"N3_HISTOR" , cHistor ,NIL},;
{"N3_CCONTAB" , cContab ,NIL},;
{"N3_DINDEPR" , dIndDepr ,NIL},;
{"N3_VORIG1" , nValor ,NIL},;
{"N3_TXDEPR1" , nTaxa ,NIL},;
{"N3_VORIG2" , nValor ,NIL},;
{"N3_TXDEPR2" , nTaxa ,NIL},;
{"N3_VORIG3" , nValor ,NIL},;
{"N3_TXDEPR3" , nTaxa ,NIL},;
{"N3_VORIG4" , nValor ,NIL},;
{"N3_TXDEPR4" , nTaxa ,NIL},;
{"N3_VORIG5" , nValor ,NIL},;
{"N3_TXDEPR5" , nTaxa ,NIL};
})

Begin Transaction

MSExecAuto({|x,y,z| Atfa012(x,y,z)},aCab,aItens,3,aParam)
 If lMsErroAuto 

MostraErro()
DisarmTransaction()
 Endif
 End Transaction

RestArea(aArea)

Return 

