#include 'protheus.ch'
#include 'parmtype.ch'

user function DataValida()
	
Local dData := CTOD("23/02/18")

Local lNext	:= .T.                                    

Local dNewData := DataValida(dData, lNext)

ApMsgAlert("Proxima data válida será: "+ Dtoc(dNewData)+ ' - ' +DiaExtenso(dNewData))


Return