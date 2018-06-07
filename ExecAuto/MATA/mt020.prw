#include "protheus.ch"
#include "parmtype.ch"
#include "fwmvcdef.ch"
#include "tbiconn.ch"



User Function vMATA020()
    Local oModel := NIL
    Local lRet   := .T.
    Local cLog   := ""
    Local nOpc   := 3
    Local nX     := 0
    Private aMsLog := {}
    Private lMsErroAuto := .F.
    PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM" TABLES "SA2"
    If  oModel == NIL
        oModel := FwLoadModel("MATA020M")
        oModel:SetOperation(nOpc)
        oModel:Activate()
    EndIf */
oModel:SetValue("SA2MASTER","A2_COD"       ,"021   "                                   ) // Codigo
oModel:SetValue("SA2MASTER","A2_LOJA"      ,"01"                                       ) // Loja
oModel:SetValue("SA2MASTER","A2_NOME"      ,"MATA01 ELETRONICOS S/A                  " ) // Nome
oModel:SetValue("SA2MASTER","A2_NREDUZ"    ,"MATA01              "                     ) // Nome reduz.
oModel:SetValue("SA2MASTER","A2_END"       ,"RUA TURQUIA,150                         " ) // Endereco
oModel:SetValue("SA2MASTER","A2_BAIRRO"    ,"HIGIANOPOLIS        "                     ) // Bairro
oModel:SetValue("SA2MASTER","A2_EST"       ,"SP"                                       ) // Estado
oModel:SetValue("SA2MASTER","A2_COD_MUN"   ,"     "                                    ) // Codigo Municipio
oModel:SetValue("SA2MASTER","A2_MUN"       ,"SAO PAULO                                                   ")// Municipio
oModel:SetValue("SA2MASTER","A2_CEP"       ,"        "                                             ) // CEP
oModel:SetValue("SA2MASTER","A2_TIPO"      ,"J"                                        ) // Tipo
oModel:SetValue("SA2MASTER","A2_CGC"       ,"              "                           ) // CNPJ/CPF
oModel:SetValue("SA2MASTER","A2_INSCR"     ,"986547896547896547"                       ) // Inscricao Estadual
If oModel:VldData()
        oModel:CommitData()
    Else
        aLog := oModel:GetErrorMessage()
        For nX := 1 To Len(aLog)
            If !Empty(aLog[nX])
                cLog += Alltrim(aLog[nX]) + CRLF
            EndIf
        Next nX
       lMsErroAuto := .T.
        lRet := .F.
        AutoGRLog(cLog)
    EndIf
    If lMsErroAuto
        MostraErro()
        ConOut(Repl("-", 80))
        ConOut(PadC("Teste MATA020 finalizado com erro!", 80))
        ConOut(PadC("Fim: " + Time(), 80))
        ConOut(Repl("-", 80))
    Else
        ConOut(Repl("-", 80))
        ConOut(PadC("Teste MATA020 finalizado com sucesso!", 80))
        ConOut(PadC("Fim: " + Time(), 80))
        ConOut(Repl("-", 80))
    EndIf
  //  oModel:DeActivate()
    RESET ENVIRONMENT
Return lRet  