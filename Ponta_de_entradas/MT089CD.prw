#include 'protheus.ch'
#include 'parmtype.ch'

user function MT089CD()

Local bCond := PARAMIXB[1] //Condicao que avalia os campos do SFM
Local bSort := PARAMIXB[2] //Forma de ordenacao do array onde o 1o elemento sera utilizado. Esse array inicialmente possui 9 posicoes
Local bIRWhile := PARAMIXB[3] //Regra de selecao dos registros do SFM
Local bAddTes := PARAMIXB[4] //Conteudo a ser acrescentado no array
Local cTabela := PARAMIXB[5] //Tabela que esta sendo tratada
Local cTpOper := PARAMIXB[6] //Tipo de Operação

      If cTabela == "SC6"   
      
         bCond	:= {||( M->C5_TIPOCLI == (cAliasSFM)->FM_XTPCLI .Or. Empty((cAliasSFM)->FM_XTPCLI) ) } //Acrescenta compo novo a regra, esse campo devera ser acrescentdo no X2_UNICO do SFM.	
         bSort	:= {|x,y| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[10]+x[7] > y[1]+y[2]+y[3]+y[4]+y[5]+y[6]+y[10]+y[7]}//Altero a ordem do array, posicao 10, para considerar o campo especifico acrescentado na linha abaixo	
         bIRWhile:= {||.T.}    	
         bAddTes	:= {||aAdd(aTes[Len(aTes)],(cAliasSFM)->FM_XTPCLI ) }//Acrescento campo a ser considerado na TES Inteligente.
	   Else	
         bCond	:= {||.T.}	
         bSort	:= bSort	
         bIRWhile:= {||.T.}    	
         bAddTes	:= {||.T.}
         
       EndIf
       
       
Return({bCond,bSort,bIRWhile,bAddTes,cTpOper })       
         
