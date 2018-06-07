#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "TBICONN.CH"

user function GPEA010alt()
 
local xAutoCab := {} 
LMSERROAUTO := .f.
PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"


dbSelectArea("SRA") 
dbSetOrder(1) 
dbSeek("880001") 

aAdd(xAutoCab,{"RA_FILIAL"	, "01"	, Nil}) 
aAdd(xAutoCab,{"RA_MAT"	, "880001"	, Nil}) 
aAdd(xAutoCab,{"RA_SALARIO"	, 3700	, Nil})
aAdd(xAutoCab,{"RA_TIPOALT"	, '001'	, Nil})
aAdd(xAutoCab,{"RA_DATAALT"	, Stod('20180109')	, Nil})
aAdd(xAutoCab,{"RA_LOGRTP"	, "AV"	, Nil})

MSExecAuto({|x,y,k,w| GPEA010(x,y,k,w)},NIL,NIL,xAutoCab,4) 
if lMsErroAuto 
MostraErro() 
Else 
MSGSTOP("ALTERADO OK") 
EndIf 
Alert("Não encontrou o registro")


Return