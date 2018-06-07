#Include "protheus.ch"
#Include "parmtype.ch"
#include 'tbiconn.ch'
 
User Function TFINA080()
    Local nOpc    := 3
    Local aTitBx  := {}
 
    Private lMsErroAuto := .F.
 
    PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FIN" 
 
    If nOpc == 3
        DbSelectArea("SE2")
        DbSetOrder(1)
        DbSeek(xFilial("SE2") + "UNI" + "400000020")
 
        Aadd(aTitBx, {"E2_PREFIXO",    SE2->E2_PREFIXO,    NIL})
        Aadd(aTitBx, {"E2_NUM",        SE2->E2_NUM,        NIL})
        Aadd(aTitBx, {"E2_PARCELA",    SE2->E2_PARCELA,    NIL})
        Aadd(aTitBx, {"E2_TIPO",       SE2->E2_TIPO,       NIL})
        Aadd(aTitBx, {"E2_FORNECE",    SE2->E2_FORNECE,    NIL})
        Aadd(aTitBx, {"E2_LOJA",       SE2->E2_LOJA,       NIL})
        Aadd(aTitBx, {"AUTMOTBX",      "DAC",              NIL})
        Aadd(aTitBx, {"AUTDTBAIXA",    dDataBase,          NIL})
        Aadd(aTitBx, {"AUTHIST",       "Baixa Teste",      NIL})
    EndIf
 
    MsExecAuto({|x, y| FINA080(x, y)}, aTitBx, nOpc)
 
    If lMsErroAuto
        MostraErro()
        ConOut(Repl("-", 80))
        ConOut(PadC("Teste FINA080 finalizado com erro!", 80))
        ConOut(PadC("Fim: " + Time(), 80))
        ConOut(Repl("-", 80))
    Else
        ConOut(Repl("-", 80))
        ConOut(PadC("Teste FINA080 finalizado com sucesso!", 80))
        ConOut(PadC("Fim: " + Time(), 80))
        ConOut(Repl("-", 80))
    EndIf
 
//    RESET ENVIRONMENT
Return NIL
