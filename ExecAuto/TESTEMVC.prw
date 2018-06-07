#include "protheus.ch"
#include "fwmvcdef.ch"
#include "tbiconn.ch"

#define enter chr(13) + chr(10)

function u_tstTecaDDA()

local oMdlTeca250                          := nil
local oMdl250                   := nil
local oMdGridDDA                         := nil
local oMdGridDDC                          := nil
local aErro                                          := {}
local cContrato                 := ""

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "TMS"

private inclui      := .t.
private altera    := .f.

oMdlTeca250    := fwLoadModel("TECA250") 

oMdlTeca250:setOperation(3)
oMdlTeca250:activate()

oMdl250                             := oMdlTeca250:getModel("MdFieldCAAM")
oMdGridDDA    := oMdlTeca250:getModel("MdGridIDDA")
oMdGridDDC    := oMdlTeca250:getModel("MdGridIDDC")

cContrato := getSxeNum("AAM", "AAM_CONTRT")
rollBackSx8()

oMdl250:setValue("AAM_CONTRT"      , cContrato                                        )
oMdl250:setValue("AAM_CODCLI"        , "TMS001"                                        )
oMdl250:setValue("AAM_LOJA"                            , "01"                                    )
oMdl250:setValue("AAM_TPCONT"      , "2"                                                      )              
oMdl250:setValue("AAM_CLASSI"         , "001"                                                 )
oMdl250:setValue("AAM_ABRANG"     , "1"                                                      )
oMdl250:setValue("AAM_STATUS"       , "1"                                                      )
oMdl250:setValue("AAM_INIVIG"         , sToD("20180301")                         )
oMdl250:setValue("AAM_FIMVIG"       , sToD("20180310")                         )
oMdl250:setValue("AAM_CPAGPV"     , "001"                                                 )
oMdl250:setValue("AAM_TIPFRE"         , "1"                                                      )
oMdl250:setValue("AAM_NFCTR"         , 1                                                          )

//Tratamento referente a validação do campo DDA_ITEM
M->DDA_CODNEG := "01"
M->DDA_NCONTR := cContrato

oMdGridDDA:setValue("DDA_ITEM"    , strZero(1, tamSx3("DDA_ITEM")[1])   )
oMdGridDDA:setValue("DDA_TABFRE"               , "0001"                                                                                                                                             )
oMdGridDDA:setValue("DDA_TIPTAB"                , "01"                                                                                                                                                  )
oMdGridDDA:setValue("DDA_SERVIC"                , "001"                                                                                                                                                )
oMdGridDDA:setValue("DDA_VALCOL"              , "1"                                                                                                                                                    )
oMdGridDDA:setValue("DDA_TIPOPE"               , "1"                                                                                                                                                    )

//Tratamento referente a validação do campo DDC_ITEM
M->DDC_NCONTR := cContrato

oMdGridDDC:setValue("DDC_ITEM"                    , strZero(1, tamSx3("DDC_ITEM")[1])    )
oMdGridDDC:setValue("DDC_CODNEG"             , "01"                                                                                                                                                  )
oMdGridDDC:setValue("DDC_INIVIG" , sToD("20180301")                                                                                                                                       )
oMdGridDDC:setValue("DDC_FIMVIG"               , sToD("20180310")                                                                                                                       )

if oMdlTeca250:vldData()
                if oMdlTeca250:commitData()
                               conOut("Processo executado com sucesso (TECA250)" + enter + "Contrato : " + AAM->AAM_CONTRT)
                else
                               aErro := oMdlTeca250:getErrorMessage()
                               
                               varInfo("Erro durante o commit (TECA250)", aErro)
                endIf
else
                aErro := oMdlTeca250:getErrorMessage()
                
                varInfo("Erro durante a validacao (TECA250)", aErro)
endIf

RESET ENVIRONMENT

return
