#include 'protheus.ch'
#include 'parmtype.ch'

user function A250REQAUT()
	
Local cReqAut   := PARAMIXB[1]
Local cProgMenu := FunName()

Local cFunction := ProcName(3) + ' / ' + ProcName(4)
Local cProcess := ProcName(3)

Local cOp       := If(cProgMenu == 'MATA250', M->D3_OP, '')


ConOut('-------------------------------------------')
ConOut('cReqAut  : ' + cReqAut)
ConOut('cProgMenu: ' + cProgMenu)
ConOut('cFunction: ' + cFunction)
ConOut('cOp      : ' + cvaltochar(cOp))
IF(cProcess == 'A250ESTOQ')
	conout("Processo de validação do Estoque")
Else
    conout("Atualização do Estoque")
ENDIF
ConOut('-------------------------------------------')

Return('D')