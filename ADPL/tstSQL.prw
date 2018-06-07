#include 'protheus.ch'
#include 'parmtype.ch'

user function tstSQL()



local ccomando
local cAliasTst := ""	

ALERT('teste SQL')

  CAliasTST := getnextalias()
  
ccomando := "Seletc * from" +  Retsqlname("SDY") + " SYD"
ccomando += " where SYD.D_E_L_E_T =' '"

ccomando := ChangeQuery(ccomando)

dbuseArea(.t., "TOPCONN", TcGenQry(,,ccomando), cAliastst, .t., .t.)


  do While !Eof()
  
    dbSkip()
    
  enddo
  dbcloseArea()  
return