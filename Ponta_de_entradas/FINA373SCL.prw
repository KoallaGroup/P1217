#INCLUDE 'Protheus.ch'

USER FUNCTION FA373SCL()
LOCAL aRet := PARAMIXB[1]
LOCAL nI   := 0

IF !EMPTY(aRet) //.AND. TYPE(aRet) == 'A'
 FOR nI := 1 TO LEN(aRet)
  aRet[nI,1] := {'TESTE',"(11) 22409901)"}
  aRet[nI,3] := '34600015156454545'
 NEXT nI
ENDIF

RETURN aRet

