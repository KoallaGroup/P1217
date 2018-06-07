#Include 'Protheus.ch'
#Include 'Protheus.ch'
#include "tbiconn.ch"
User Function myMATA240()//



Local aVetor := {}

Private lMsErroAuto := .F.

prepare environment empresa "99" filial "01" modulo "est"

aVetor := {}

   
dbSelectArea("SD3")
dbGoTo(1)

aVetor:={ {"D3_TM","002",NIL},;
           {"D3_COD","1",NIL},;
           {"D3_QUANT",100,NIL},;
           {"D3_OP","",NIL},;
           {"D3_LOCAL","1",NIL},;  
           {"D3_DOC","",NIL},;
           {"D3_EMISSAO",ddatabase,NIL},;
           {"D3_CUSTO1",0,NIL},;
           {"D3_LOTECTL","",NIL}} 

   
MSExecAuto({|x,y| mata240(x,y)},aVetor,3) //Inclusao
//MSExecAuto({|x,y| mata240(x,y)},aVetor,5)
If lMsErroAuto
	CONOUT("Erro")
	mostraerro()
Else
	//CONOUT("Incluido com sucesso")
	CONOUT("Incluido com sucesso")
Endif

Return 
