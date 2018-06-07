#include 'protheus.ch'
#include 'parmtype.ch'

user function tstMaTesInt()

Local cRet

aCols[n][aScan(aHeader,{|x| AllTrim(x[2])=="C6_OPER"})] := "01"

cRet := aCols[n][aScan(aHeader,{|x| AllTrim(x[2])=="C6_OPER"})] 

MaTesInt(2,cRet,M->C5_CLIENT,M->C5_LOJAENT,"C",M->C6_PRODUTO,"C6_TES") // Cliente 2 , loja 1, Produto 2

Return cRet
	
