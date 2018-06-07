  #INCLUDE "PROTHEUS.CH"
  #INCLUDE "TBICONN.CH"
  
  /*�����������������������������������������������������������������������������
  �������������������������������������������������������������������������������
  �����������������������������������������������������������������������ͻ�����
  Programa  �MYMATA030 �Autor  �Microsiga           � Data �  30/03/12   �����
  ������������������������������������������������������������������������
  ������Desc.     � Rotina automatica do cadastro de clientes.                 ������
            �                                                            
            �����������������������������������������������������������������������������
            ������Uso       � AP                                                         
            �����������������������������������������������������������������������������
            ��������������������������������������������������������������������������������
            �����������������������������������������������������������������������������*/
            
User Function MyMata030()
Local 		aVetor 		:= {} //Array com as informa�oes do cadastro de clientes.
PRIVATE 	lMsErroAuto 	:= .F.

//��������������������������������������������������������������Ŀ
//| Abertura do ambiente                                         |
//����������������������������������������������������������������

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

 //3- Inclus�o, 4- Altera��o, 5- Exclus�o
 MSExecAuto({|x,y| Mata030(x,y)},aVetor,3)


 	If lMsErroAuto
 		Conout("Erro na inclus�o ")
 		Mostraerro()
 	Else
 		Conout("Cliente Incluido com sucesso")
	Endif



Return 

