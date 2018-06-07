#include 'protheus.ch'
#include 'parmtype.ch'

user function MT103IPC()

Local ExpN1 := PARAMIXB[1]
Local NCol 

Ncol := ascan(aheader, {|x| AllTrim(x[2]) == "D1_CLASFIS"})


alert("A Coluna do D1_CLASFIS é "+cvaltochar(Ncol))

	
return .f.

