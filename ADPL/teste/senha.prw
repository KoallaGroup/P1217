#include "PROTHEUS.CH"  
#include "TBICONN.CH" 

User Function senhaPSW()

//PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"

Local nx
Local aAllusers := FWSFALLUSERS()
For nx := 1 To Len(aAllusers)
 conout(aAllusers[nx][3] + " -" + aAllusers[nx][4] + " -" + aAllusers[nx][5])
Next
Return\\10.172.22.145