#include 'protheus.ch'
#include 'parmtype.ch'

user function SD3250I()

Alert("PE SD3250I")

if MsgYesNo ("Deseja executar a ExecAuto MATA250?")
U_MATA250()

ENDIF

return