#include 'protheus.ch'
#include 'parmtype.ch'

user function M410FSQL()

Local _vpFiltro := ""

Alert("M410FSQL")

//_vpFiltro := "C5_CLIENTE = 'CL0003'"
_vpFiltro := "C5_NUM < '000220' .and. C5_CONDPAG == 'BOL' .and. C5_TIPOCLI =='F'"
//_vpFiltro := "C5_CLIENT $ 'CL0007|CL0003|'"

Return(_vpFiltro)

 
	
