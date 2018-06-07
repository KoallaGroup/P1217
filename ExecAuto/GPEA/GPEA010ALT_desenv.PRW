#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'PARMTYPE.CH'

User Function GPEA010ALT()

Local xAutoCab	:= {}
LMSERROAUTO:= .F.

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "GPE"

DbSelectArea("SRA")
DbSetOrder(1)
DbSeek("01"+"880001")

aAdd(xAutoCab, {"RA_FILIAL"	, "01", NIL} )
aAdd(xAutoCab, {"RA_MAT"		, "880001", NIL} ) 
aAdd(xAutoCab, {"RA_SALARIO", 3000		, NIL} ) 
aAdd(xAutoCab, {"RA_TIPOALT", "001"	, NIL} ) 
aAdd(xAutoCab, {"RA_DATAALT", SRA->RA_ADMISSA, NIL} ) 
aAdd(xAutoCab, {"RA_LOGRTP" , "AV", NIL} ) 
 
MSExecAuto({|x,y,k,w| GPEA010(x, y, k, w)}, NIL, NIL, xAutoCab,4)

If lMsErroAuto
	MostraErro()
Else
	MSGSTOP("ALTERADO ok ")
EndIf

Alert("Não Encontrou o Registro")

Return