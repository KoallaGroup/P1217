#include 'protheus.ch'
#include 'parmtype.ch'

User Function MT120TEL()



local	 aArea			:= GetArea()
LOCAL cEF0101
Local	 aAreaSC7		:= SC7->(GetArea())
Local	 oDialog    	:= PARAMIXB[1]//Objeto da Dialog do Pedido de Compras
Local	 aPosGet   	:= PARAMIXB[2]//Array contendo a posição dos gets do pedido de compras  
Local	 nOpcx     	:= PARAMIXB[4]//Opção Selecionada no Pedido de Compras (inclusão,admin alteração, exclusão, etc ..)    
Local	 nRecPC    	:= PARAMIXB[5]//Número do recno do registro do pedido de compras selecionado   
Local	 lEdit     	:= IIF(nOpcx == 3 /*Inclusao*/ .Or. nOpcx == 4/*Alteracao*/ .Or. nOpcx == 6/*Copia*/,.T.,.F.) //#ECV20121126.o 
Local	 lRet			:= .T.

SC7->(DbGoTo(nRecPC))

aAreaSC7		:= SC7->(GetArea())
cEF0101 := IIF(nOpcx == 3, CriaVar("C7_NUM",.F.), SC7->C7_NUM)

@ 063, aPosGet[1,3]+368 SAY Alltrim(RetTitle("C7_NUM")) OF oDialog PIXEL SIZE 040, 100
@ 063, aPosGet[1,4]+362 MSGET cEF0101 OF oDialog PIXEL PICTURE PesqPict('SC7','C7_NUM');
 F3 "SI3" /*CpoRetF3('I3_CUSTO')*/ VALID ValidCF01(cEF0101) WHEN INCLUI SIZE 40, 9 HASBUTTON

//RestArea(aAreaSC7)
RestArea(aArea)

Return lRet

