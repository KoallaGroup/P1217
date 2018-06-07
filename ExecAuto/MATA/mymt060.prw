#include 'protheus.ch'
#include 'parmtype.ch'
#include "tbiconn.ch"
user function mymt060()
    Local PARAMIXB1 := {}
    Local PARAMIXB2 := 3
    Local cFornec       := "2     "
    Local cLoja         := "01"
//    Local cNomeFor      := "IMPORTAÇÃO VERDE S/A                    "
    Local cProduto      := "07             "
//    Local cNomeProd     := "CORPO SQUIZ                   "
    PRIVATE lMsErroAuto := .F.
//------------------------//
//| Abertura do ambiente |//
//------------------------//

    PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "EST" TABLES "SA5"

    ConOut(Repl("-",80))
    ConOut(PadC("Teste de Amarracao Produto x Fornecedor",80))
    ConOut("Inicio: "+Time())

//------------------------//
//| Teste de Inclusao    |//
//------------------------//

    Begin Transaction
        PARAMIXB1 := {}
        aadd(PARAMIXB1,{"A5_FORNECE",cFornec,})
        aadd(PARAMIXB1,{"A5_LOJA",cLoja,})
//        aadd(PARAMIXB1,{"A5_NOMEFOR",cNomeFor,})
        aadd(PARAMIXB1,{"A5_PRODUTO",cProduto,})
//        aadd(PARAMIXB1,{"A5_NOMPROD",cNomeProd,})

        MSExecAuto({|x,y| mata060(x,y)},PARAMIXB1,PARAMIXB2)

        If !lMsErroAuto
            ConOut("Incluido com sucesso! "+cFornec)
        Else
            ConOut("Erro na inclusao!")
            MOSTRAERRO()
        EndIf
        ConOut("Fim  : "+Time())
    End Transaction

    RESET ENVIRONMENT

Return Nil