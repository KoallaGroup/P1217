#include "TbiConn.ch"
#include "Protheus.ch"
#include "rwmake.ch"
#INCLUDE "topconn.ch"


User Function Exemplo1()
  Local aFiles := {}
  Local nX
  local nCount 
  
  
  Conout("TESTE LOCAL")
  aFiles := Directory("C:\Agent\*.*", "D")
  
  nCount := Len( aFiles)
   
  For nX := 1 to nCount
      ConOut('Arquivo: ' + aFiles[nX,1] + ' - Size: ' + AllTrim(Str(aFiles[nX,2])) )
  Next nX
  
  
  Conout("TESTE Protheus Data")
  aFiles := Directory("\Tables\*.*", "D")
  
  nCount := Len( aFiles)
   
  For nX := 1 to nCount
      ConOut('Arquivo: ' + aFiles[nX,1] + ' - Size: ' + AllTrim(Str(aFiles[nX,2])) )
  Next n  
  



Return



