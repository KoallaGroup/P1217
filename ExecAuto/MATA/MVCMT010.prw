#include "protheus.ch"
#include "fwmvcdef.ch"
#include "tbiconn.ch"

#define enter chr(13) + chr(10)

function u_MVCMT010()

local oModelB1 := nil 
local oB1Master := nil
local cCodigo := ""
Local bset 

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" TABLES "SB1" MODULO "COM"

private inclui := .t.
private altera := .f.

oModelB1 := fwLoadModel("COMP011_MVC")

oModelB1:setOperation(3)
IF oModelB1:activate()
conout("Modelo Ativo")
ENDIF


oB1Master := oModelB1:getModel("SB1MASTER")

cCodigo := getSxeNum("SB1", "B1_COD")

oB1Master:setValue("B1_COD" , cCodigo )
oB1Master:setValue("B1_DESC" , "PRODUTO TESTE" + cCodigo ) 
oB1Master:setValue("B1_TIPO" , "PA" ) 
oB1Master:setValue("B1_UM" , "CC" ) 
oB1Master:setValue("B1_LOCPAD" , "1"  )
oB1Master:setValue("B1_PICM" , 0) 

bset := oB1Master:setValue("B1_IPI" , '0' ) 
IF(!bset)
aErro := oModelB1:getErrorMessage()

varInfo("Erro durante a validacao (MATA010)", aErro)
ENDIF 



oB1Master:setValue("B1_CONTRAT" , "N" ) 
oB1Master:setValue("B1_LOCALIZ" , "N" ) 

if oModelB1:vldData()
      if oModelB1:commitData()
conOut("Processo executado com sucesso (MATA010)" + enter + "PRODUTO : " + SB1->B1_DESC)
      else
aErro := oModelB1:getErrorMessage()

varInfo("Erro durante o commit (MATA010)", aErro)
      endIf
else
aErro := oModelB1:getErrorMessage()

varInfo("Erro durante a validacao (MATA010)", aErro)
endIf

oB1Master:destroy()

//RESET ENVIRONMENT

return
