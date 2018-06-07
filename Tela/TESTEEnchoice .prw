#include 'protheus.ch'
#include 'parmtype.ch'

user function tEnchoice ()

Local aPosObj   := {}
Local aObjects  := {}
Local aSize     := MsAdvSize()
Local aButtons    := {}

Private aAltera := {}
Private aTELA := Array(0,0)
Private aGets := Array(0)

Private oDlg
Private aCampos    := {"NOUSER","C7_NUM","C7_FORNECE","C7_LOJA","C7_COND"}

  aObjects := {}
  AAdd( aObjects, { 000, 060, .T., .F. } )
  AAdd( aObjects, { 100, 100, .T., .T. } )
 
  aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 2, 2 }
  aPosObj := MsObjSize( aInfo, aObjects )
 
  DEFINE MSDIALOG oDlg TITLE 'Teste SC7' From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL
  EnChoice( "SC7",, 3,,,,aCampos,aPosObj[1],{"C7_NUM","C7_FORNECE","C7_LOJA","C7_COND"} , 3, , , , , ,.F. )
 
  ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||nOpca:=1,If(oGetDados:TudoOk(),If(!obrigatorio(aGets,aTela),nOpca := 0,oDlg:End()),nOpca := 0)},{||oDlg:End()}) CENTERED
 
Return