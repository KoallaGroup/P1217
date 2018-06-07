#include 'protheus.ch'
#include 'parmtype.ch'
#include "tbiconn.ch"


user function TstStartJob()

 /* Local lret := .F.
  lret := startjob("u_TstaRecLock",getenvserver(),.T.,"Data Atual " + cvaltochar(date()))
  if !lret
    return -1
  endif */
conout ("Passou pela StartJOB")
  startjob("u_MATA185",getenvserver(),.T.,)

return 