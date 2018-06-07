#include 'protheus.ch'
#include 'parmtype.ch'
#include "tbiconn.ch"

user function myMATA242()

Local aAutoCab := {}
Local aAutoItens := {}

Private lMsErroAuto := .F.

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"


aAutoCab := {	{"cProduto"   , Pad("2              ", Len(SD3->D3_COD))	 , Nil},;
   					{"cLocOrig"   , "1 "				 , Nil},;
   					{"nQtdOrig"   , 100 				 , Nil},;			
   					{"nQtdOrigSe" , CriaVar("D3_QTSEGUM")		 , Nil},;			
   					{"cDocumento" , Pad("000000002", Len(SD3->D3_DOC))    , Nil},;			
   					{"cNumLote"   , CriaVar("D3_NUMLOTE")		 , Nil},;			
   					{"cLoteDigi"  , CriaVar("D3_LOTECTL")		 , Nil},;			
   					{"dDtValid"   , CriaVar("D3_DTVALID")		 , Nil},;			
   					{"nPotencia"  , CriaVar("D3_POTENCI")		 , Nil},;			
   					{"cLocaliza"  , CriaVar("D3_LOCALIZ")		 , Nil},;			
   					{"cNumSerie"  , CriaVar("D3_NUMSERI")		 , Nil}}
   					
   					
aAutoItens := {{	{"D3_COD"    , Pad("3              ", Len(SD3->D3_COD))	, Nil}, ;
						{"D3_LOCAL"  , "1 "							, Nil}, ;			
						{"D3_QUANT"  , 1							, Nil}, ;			
						{"D3_QTSEGUM", 1							, Nil}, ;			
						{"D3_RATEIO" , 20 							, Nil}},;		     			 
					 {	{"D3_COD"    , Pad("03             ", Len(SD3->D3_COD))	, Nil}, ;			
					 	{"D3_LOCAL"  , "1 "							, Nil}, ;			
					 	{"D3_QUANT"  , 24							, Nil}, ;			
					 	{"D3_QTSEGUM", 2							, Nil}, ;			
					 	{"D3_RATEIO" , 80 							, Nil}}}
					 	
					 	
//inclusão					 	
MSExecAuto({|v,x,y,z| Mata242(v,x,y,z)},aAutoCab,aAutoItens,3,.T.) 

If lMsErroAuto	
Mostraerro()
EndIf

Alert("Inclusao Ok. Verifique arquivos e continue para estorno")
/*
// estorno
MSExecAuto({|v,x,y,z| Mata242(v,x,y,z)},aAutoCab,aAutoItens,5,.T.) 

If lMsErroAuto	

Mostraerro()

EndIf
*/
Return
	
