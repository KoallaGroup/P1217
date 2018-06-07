#include 'protheus.ch'
#include 'parmtype.ch'

user function font()
  DEFINE DIALOG oDlg TITLE "Exemplo TFont" FROM 180,180 TO 550,700 PIXEL
 
    // TFont   
    oTFont := TFont():New('Arial Narrow',,-16,.T.)
 
     // Aplica Font em um TSay
    oTSay := TSay():New( 01, 01,{||'TSay para teste do TFont (usado Arial Narrow)'},oDlg;
             ,,oTFont,.T.,.F.,.F.,.T.,0,,250,20,.F.,.T.,.F.,.F.,.F.,.F. )  
 
    Name      := oTFont:Name   
    nWidth    := oTFont:nWidth   
    nHeigh    := oTFont:nHeight
    Bold      := oTFont:Bold   
    Italic    := oTFont:Italic   
    Underline := oTFont:Underline
    
    oTFont2 := TFont():New('Courier new',,-16,.T.)
 
     // Aplica Font em um TSay
    oTSay2 := TSay():New( 01, 01,{||'TSay para teste do TFont (usado Courier new)'},oDlg;
             ,,oTFont2,.T.,.F.,.F.,.T.,0,,250,40,.F.,.T.,.F.,.F.,.F.,.F. )  
 
    Name      := oTFont2:Name   
    nWidth    := oTFont2:nWidth   
    nHeigh    := oTFont2:nHeight
    Bold      := oTFont2:Bold   
    Italic    := oTFont2:Italic   
    Underline := oTFont2:Underline  
    
    oTFont3 := TFont():New('Times New Roman',,-16,.T.)
     // Aplica Font em um TSay
    oTSay3 := TSay():New( 01, 01,{||'TSay para teste do TFont (usado Times New Roman)'},oDlg;
             ,,oTFont3,.T.,.F.,.F.,.T.,0,,250,60,.F.,.T.,.F.,.F.,.F.,.F. )  
 
    Name      := oTFont3:Name   
    nWidth    := oTFont3:nWidth   
    nHeigh    := oTFont3:nHeight
    Bold      := oTFont3:Bold   
    Italic    := oTFont3:Italic   
    Underline := oTFont3:Underline      
    
    
    
    

  ACTIVATE DIALOG oDlg CENTERED
Return	
