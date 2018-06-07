#Include "Protheus.ch"
#include "rwmake.ch"
#include "TbiConn.ch"
 
User Function mata650()
Local aMATA650      := {}       //-Array com os campos
//������������������Ŀ
//� 3 - Inclusao     �
//� 4 - Alteracao    �
//� 5 - Exclusao     �
//��������������������
Local nOpc              := 3
Private lMsErroAuto     := .F.
 
PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
 
aMata650  := {{'C2_FILIAL'   ,"01"                ,NIL},;
				{'C2_NUM'      ,"000030"            ,NIL},; 
				{'C2_ITEM'     ,"01"                ,NIL},; 
				{'C2_SEQUEN'   ,"001"               ,NIL},;
				{'C2_PRODUTO'  ,"02              "   ,NIL},;          
				{"C2_LOCAL"    , "1 "               ,NIL},;
          		{"C2_QUANT"    , 100	          		 ,NIL},;
         		{"C2_DATPRI"   , ddatabase          ,NIL},;
         		{"C2_DATPRF"   , ddatabase          ,NIL},;
         		{"C2_EMISSAO"  , ddatabase          ,NIL},; 
         		{"C2_BATROT"   , 'MATA650             ',NIL},;
         		{'AUTEXPLODE'  ,'S'					 ,Nil}}     
                 
ConOut("Inicio  : "+Time())
  //{'C2_NUM'      ,"000097"                ,NIL},;         
//��������������������������������������������������������������Ŀ
//� Se alteracao ou exclusao, deve-se posicionar no registro     �
//� da SC2 antes de executar a rotina automatica                 �
//����������������������������������������������������������������
If nOpc == 4 .Or. nOpc == 5
    SC2->(DbSetOrder(1)) // FILIAL + NUM + ITEM + SEQUEN + ITEMGRD
    SC2->(DbSeek(xFilial("SC2")+"000097"+"01"+"002"))
EndIf
     
msExecAuto({|x,Y| Mata650(x,Y)},aMata650,nOpc)
If !lMsErroAuto
    ConOut("Sucesso! ")
Else
    ConOut("Erro!")
    MostraErro()
EndIf
 
ConOut("Fim  : "+Time())
 
RESET ENVIRONMENT
 
Return Nil