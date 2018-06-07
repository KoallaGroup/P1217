  #INCLUDE "PROTHEUS.CH"
  #INCLUDE "TBICONN.CH"
  
  /*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
  ษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑฑฑบ
  Programa  ณMYMATA030 บAutor  ณMicrosiga           บ Data ณ  30/03/12   บฑฑฑฑ
  ฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออ
  นฑฑฑฑบDesc.     ณ Rotina automatica do cadastro de clientes.                 บฑฑฑฑบ
            ณ                                                            
            บฑฑฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ
            นฑฑฑฑบUso       ณ AP                                                         
            บฑฑฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ
            ผฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
            ฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
            
User Function MyMata030()
Local 		aVetor 		:= {} //Array com as informa็oes do cadastro de clientes.
PRIVATE 	lMsErroAuto 	:= .F.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//| Abertura do ambiente                                         |
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT" TABLES "SA1"

	aVetor:={ 		{"A1_COD"       	, "000003"        	,Nil},; // Codigo
					{"A1_LOJA"      	,"01"               	,Nil},; // Loja
					{"A1_PESSOA"	 	,"J"               		,Nil},; // J = Jurido / F = Fisico
					{"A1_NOME"      	,"Cliente teste ExecAuto"  	,Nil},; // Nome
					{"A1_NREDUZ"    	,"AUTOMATICO"			,Nil},; // Nome reduz.
					{"A1_TIPO"      	,"F"					,Nil},; // Tipo
					{"A1_EST"       	,"SP"				    ,Nil},; // Estado
					{"A1_COD_MUN"      ,"18800"				,Nil},;  // cod mun
 					{"A1_END"       	,"adsadsad"						,Nil},; // Endereco
 					{"A1_MUN"       	,"SAO AUTOMATICO"		,Nil}} // Cidade

 //3- Inclusใo, 4- Altera็ใo, 5- Exclusใo
 MSExecAuto({|x,y| Mata030(x,y)},aVetor,3)


 	If lMsErroAuto
 		Conout("Erro na inclusใo ")
 		Mostraerro()
 	Else
 		Conout("Cliente Incluido com sucesso")
	Endif



Return 

