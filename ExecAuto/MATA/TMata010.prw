#INCLUDE "RWMAKE.CH" 
#INCLUDE "TBICONN.CH" 

User Function TMata010()

Local aVetor := {}

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "EST"

//--- Exemplo: Inclusao --- //

aVetor:= {{"B1_COD"         ,'EXECAUTO03     ' 	     ,NIL},;  
			{"B1_DESC"        ,"TESTE EXECAUTO                " ,NIL},;                     
			{"B1_TIPO"    	,"PA"            ,Nil},;                   
			{"B1_UM"      	,"CC"            ,Nil},;                   
			{"B1_PESO"  		,10          ,Nil},;     
			{"B1_LOCPAD" 	,	"01"             ,Nil},;
			{"B1_RASTRO"  	,"N"            ,Nil},;
			{"B1_LOCALIZ" 	,"N"             ,Nil}}
			 
			
MSExecAuto({|x,y| Mata010(x,y)},aVetor,3) 



/*
//--- Exemplo: Alteracao --- //

aVetor:= {{"B1_COD"         ,"9994" 	     ,NIL},;                    
			{"B1_DESC"        ,"PRODUTO TESTE - ALTERADO" ,NIL}}				
			
MSExecAuto({|x,y| Mata010(x,y)},aVetor,4) 


//--- Exemplo: Exclusao --- //

aVetor:= {{"B1_COD"         ,"TSTMVC01       " 	     ,NIL},;                    
			{"B1_DESC"        ,"TSTMVC01                      " ,NIL}}				 
			
MSExecAuto({|x,y| Mata010(x,y)},aVetor,5) 

*/

Return
