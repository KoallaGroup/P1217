#include 'protheus.ch'
#include 'parmtype.ch'

user function tsay()

Local aTexto := {'TESTE1', 'TESTE2'}
Local nCol := 20

 DEFINE DIALOG oDlg TITLE "Exemplo TSay" FROM 180,180 TO 550,700 PIXEL
  
 // Cria Fonte para visualiza��o
 oFont := TFont():New('Courier new',,-18,.T.)
  
 // Usando o m�todo New
 oSay1:= TSay():New(01,01,{||'Texto para exibi��o I'},oDlg,,oFont,,,,.T.,CLR_RED,CLR_WHITE,200,20)
   
 // Usando o m�todo Create
  
  For nx:=1 to 2
  
  nCol := nx*nCol
  
  oSay:= TSay():Create(oDlg,{||'Texto para exibi��o'},nCol,01,,oFont,,,,.T.,CLR_RED,CLR_WHITE,200,20)
 
 // M�todos
  oSay:CtrlRefresh()
 
  oSay:SetText(aTexto[nx])
 
  next 
  
 //oSay:SetTextAlign( 2, 2 )
 
 // Propriedades
 oSay:lTransparent = .T.
 
 oSay:lWordWrap = .F.
 
ACTIVATE DIALOG oDlg CENTERED
Return