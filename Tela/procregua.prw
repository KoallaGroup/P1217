#include "protheus.ch"
#include 'parmtype.ch'
#INCLUDE "FWMBROWSE.CH"
#INCLUDE "TBICONN.CH"  


User Function TestProc()

Local aCampos := {}
Local oDlg, oSay1, oLbxLocal, oPanel1
local oPanel2
Aadd(aCampos,{"", "", ""})
DEFINE MSDIALOG oDlg TITLE "Teste Processa" From 000,0 TO 100,300 OF oMainWnd PIXEL
oDlg:lMaximized := .T. 
@ 000, 000 MSPANEL oPanel1 SIZE 10, 50 OF oDlg 
oPanel1:align:= CONTROL_ALIGN_TOP   
@ 12, 05 SAY oSay1 VAR "O botão Busca traz todos os campos cadastrados no SX3." OF oPanel1 PIXEL
@ 25, 40 BUTTON "Busca" PIXEL SIZE 40,12 OF oPanel1 ACTION U_TestPrc(@aCampos, @oLbx)   
@ 25, 100 BUTTON "Fechar" PIXEL SIZE 40,12 OF oPanel1 ACTION oDlg:End()

@ 000, 000 MSPANEL oPanel2 SIZE 10, 90 OF oDlg 
oPanel2:align:= CONTROL_ALIGN_ALLCLIENT	   
@ 30,05 LISTBOX oLbx FIELDS HEADER "Tabela", "Ordem", "Campo" SIZE 60, 30, 100 OF oPanel2 PIXEL     
oLbx:SetArray(aCampos)                                                
oLbx:bLine := {|| {aCampos[oLbx:nAt,1],aCampos[oLbx:nAt,2], aCampos[oLbx:nAt, 3]}}   
oLbx:align:= CONTROL_ALIGN_ALLCLIENT			         
ACTIVATE MSDIALOG oDlg CENTERED
Return                                                                        

User Function TestPrc(aCampos, oLbx)
Processa( {|| U_TestSX3(aCampos) }, "Aguarde...", "Carregando definição dos campos...",.F.)
oLbx:SetArray(aCampos)                                             
oLbx:bLine := {|| {aCampos[oLbx:nAt,1],aCampos[oLbx:nAt,2], aCampos[oLbx:nAt, 3]}}
oLbx:Refresh()
Return

User Function TestSX3(aCampos)

aCampos := {}        
DbSelectArea("SX3")
DbGoTop()
ProcRegua(RecCount())
WHILE !Eof()                                               
IncProc()       
Aadd(aCampos, {X3_ARQUIVO, X3_ORDEM, X3_CAMPO})   
DbSkip()
END
Return