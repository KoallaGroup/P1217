#include 'protheus.ch'
#include 'parmtype.ch'

user function ATFA010()
	
return

/*/
�����������������������������������������������������������������������������
�������������������������������������������������������������������������������
������������������������������������������������������������������������
������Programa  �MyATFA030 � Autor � Eduardo F. Lima       � Data � 01/12/11 �����
������������������������������������������������������������������������
������Descri��o �Exemplo de chamada do ATFA030 pela MSExecAuto() para        
������          �Baixa de ativos			                                  
�����������������������������������������������������������������������������
������Uso       �SIGAATF                                                     
�����������������������������������������������������������������������������
ٱ������������������������������������������������������������������������������
�����������������������������������������������������������������������������/*/
User Function  MyATFA030()

Local aDadosAuto := {}		// Array com os dados a serem enviados pela MsExecAuto() para gravacao automatica
Private lMsHelpAuto := .f.	// Determina se as mensagens de help devem ser direcionadas para o arq. de logPrivate 
lMsErroAuto := .f.	// Determina se houve alguma inconsistencia na execucao da rotina em relacao aos

aDadosAuto:= {	{'N3_CBASE'   , "0000000070"	, Nil},;	// Codigo base do ativo
				{'N3_ITEM'    , "0001"			, Nil},;	// Item sequencial do codigo base do ativo     
				{'AUTDTBX' , CTOD("30/11/11"), Nil},;	// Dever� ser informada a data efetiva da baixa do Bem. 
				{'AUTMOTBX' , "01", Nil},;	// Dever� ser informado o motivo da baixa. A tabela de motivos poder� ser alterado na rotina Tabela no m�dulo Configurador (tabela 16).
				{'AUTNOTA' , "Nota 10", Nil},;	// N�mero da Nota Fiscal. Dever� ser infor-mada, caso seja uma venda de Ativo.
				{'AUTSERIE' , "3 Serie C", Nil},;	// Serie da Nota Fiscal.
				{'AUTQUANT' , 1, Nil},;	// Quantidade da baixa. Caso a baixa seja por valor, dever� ser informado 0(zero).Se for pela quantidade, o valor ser�    proporcionalizado pela quantidade baixa-da.
				{'AUTPERCBX' , 100, Nil},;	// Percentual do bem a ser baixado.
				{'AUTBXFILHOS' , .F., Nil},;	// Indica se deve ser efetuada a baixa dos filhos 
				{'AUTVLRVENDA' , 1, Nil}}	// Caso se trate de uma venda de ativo, de-ver� ser informado o valor da venda do  mesmo.
				
				
MSExecAuto({|x, y, z| AtfA030(x, y, z)},aDadosAuto, 4)
					
					
If lMsErroAuto	lRetorno := .F.	

	MostraErro()
	
Else	lRetorno:=.T.
Alert("Baixou o T�tulo com Sucesso")
EndIf

Return