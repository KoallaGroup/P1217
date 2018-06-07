#include 'protheus.ch'
#include 'parmtype.ch'

user FUNCTION teste()
 
  Local cT1 := "T1"
  Local idx := 0
  Local name := ""
  Local tp := ""
  Local age := "2"
   
  DBUseArea(.F., 'TOPCONN', cT1, (cT1), .F., .F.)
  WHILE (idx <= 5)
   
  name += "BA"
  tp += "T"
  age += "2"
   
  (cT1)->( DBAppend( .F. ) )
  (cT1)->FIELD_NAME := name
  (cT1)->FIELD_TYPE := tp
  (cT1)->FIELD_AGE := age
  (cT1)->( DBCommit() )
   
  idx++
  ENDDO
  DBCloseArea()
   
return
 
FUNCTION Example()
  Local cT1 := "T1"
   
  TCLink()
   
  DBCreate("T1", {{"FIELD_NAME", "C", 10, 0}, ;
                  {"FIELD_TYPE", "C", 10, 0}, ;
                  {"FIELD_AGE", "C", 10, 0}, ;
                  {"FIELD_NICK", "C", 10, 0}, ;
                  {"FIELD_COL", "C", 10, 0}}, "TOPCONN")
                   
  U_insert()
 
  DBUseArea(.F., 'TOPCONN', cT1, (cT1), .F., .T.)
 
  (cT1)->(DbSetFilter({|| left(FIELD_NAME, 4)="BABA" }, "FIELD_NAME=BABA"))
   
  (cT1)->(DBGoTop())
                   
  IF ((cT1)->FIELD_AGE == "222       ")
    conout("Found!")
  ENDIF
   
  DBCloseArea()
   
  TCUnlink()
RETURN