#Include 'Protheus.ch'
#include "rwmake.ch"
#include "tbiconn.ch"

User Function DevMata103() // teste com ambiente atualizado....

Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local cDoc := ""
PRIVATE lMsErroAuto := .F.

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//| Abertura do ambiente |
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

ConOut(Repl("-",80))

ConOut(PadC(OemToAnsi("Teste de Inclusao de NFE DEVOLUCAO COM NOTA DE ORIGEM NFS"),80))

ConOut(Repl("-",80))


PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM"

cDoc := "DEV000017"
aCabec := {}
aItens := {}

aadd(aCabec,{"F1_TIPO" ,"D" })
aadd(aCabec,{"F1_FORMUL" ,"N" })
aadd(aCabec,{"F1_DOC" ,cDoc })
aadd(aCabec,{"F1_SERIE" ,"000" })
aadd(aCabec,{"F1_EMISSAO" ,dDataBase })
aadd(aCabec,{"F1_FORNECE" ,"2     " })
aadd(aCabec,{"F1_LOJA" ,"1 " })
aadd(aCabec,{"F1_ESPECIE" ,"NFE" })


aLinha := {}



aadd(aLinha,{"D1_ITEM" ,"001" ,Nil})
aadd(aLinha,{"D1_COD" ,"2 " ,Nil})
aadd(aLinha,{"D1_QUANT" ,1 ,Nil})
aadd(aLinha,{"D1_VUNIT" ,10 ,Nil})
aadd(aLinha,{"D1_TOTAL" ,10 ,Nil})
aadd(aLinha,{"D1_TES" ,"101" ,Nil})//TES DEVOLU플O
aAdd(aLinha,{"D1_CF" ,"000 " ,Nil})
aAdd(aLinha,{"D1_DOC" ,cDoc ,Nil}) // *
aAdd(aLinha,{"D1_SERIE" ,"000" ,Nil}) // *
aAdd(aLinha,{"D1_EMISSAO",dDataBase ,Nil}) // ADICIONEI
aadd(aLinha,{"D1_NFORI" ,"000001" ,Nil}) // nota de origem
aadd(aLinha,{"D1_SERIORI","1 " ,Nil})
aadd(aLinha,{"D1_ITEMORI","01" ,Nil})
aadd(aLinha,{"D1_VALFRE",0 ,Nil})
AAdd(aLinha,{"D1_IDENTB6","000334" ,Nil}) // d2_nunseq
aadd(aLinha,{"AUTDELETA" ,"N" ,Nil})
aadd(aItens,aLinha)


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//| Teste de Inclusao |
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

MSExecAuto({|x,y,z| mata103(x,y,z)},aCabec,aItens,3)

If !lMsErroAuto
ConOut("Incluido com sucesso! "+cDoc)
Else
ConOut("Erro na inclusao!")
mostraerro()
EndIf

ConOut(OemToAnsi("Fim : ")+Time())

RESET ENVIRONMENT

Return(.T.)