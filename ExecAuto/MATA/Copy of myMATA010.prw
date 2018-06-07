#Include 'Protheus.ch'
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"
  
User Function TMata010()

	Local aVetor := {}

	private lMsErroAuto := .F.

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "ATF"

 
	aVetor:= {{"B1_COD"         ,"99999999" 	     ,NIL},;
		{"B1_DESC"        ,"PRODUTO TESTE" ,NIL},;
		{"B1_TIPO"    	,"PA"            ,Nil},;
		{"B1_UM"      	,"CC"            ,Nil},;
		{"B1_LOCPAD"  	,"1"            ,Nil},;
		{"B1_PICM"    	,0               ,Nil},;
		{"B1_IPI"     	,0               ,Nil},;
		{"B1_CONTRAT" 	,"N"             ,Nil},;
		{"B1_LOCALIZ" 	,"N"             ,Nil}}
		       
		       
//		{"B1_GRUPO",  	,"0001"			, NIL},;
		       
	MSExecAuto({|x,y| Mata010(x,y)},aVetor,3)
	

	If lMsErroAuto
 		Conout("Erro na inclusão ")
 		Mostraerro()
 	Else
 		Conout("Produto Incluido com sucesso")
	Endif
Return


