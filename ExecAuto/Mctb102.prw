#include 'protheus.ch'
#include 'parmtype.ch'
#Include 'TBICONN.ch'

user function ctba102()
	
Local _lOk := .T.
Local aItens := {}
Local aCab := {}

PRIVATE lMsErroAuto
//PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'

aCab := { {'DDATALANC' ,dDataBase ,NIL},;
{'CLOTE' ,'008800' ,NIL},;
{'CSUBLOTE' ,'001' ,NIL},;
{'CDOC' , STRZERO( seconds() ,6) ,NIL},;
{'CPADRAO' ,'' ,NIL},;
{'NTOTINF' ,0 ,NIL},;
{'NTOTINFLOT' ,0 ,NIL} }

aAdd(aItens,{ {'CT2_FILIAL' ,'01' , NIL},;
{'CT2_LINHA' ,'001' , NIL},;
{'CT2_MOEDLC' ,'01' , NIL},; 
{'CT2_DC' ,'1' , NIL},;
{'CT2_DEBITO' ,'3.1.1               ' , NIL},;
{'CT2_CREDIT' ,'3.1.1               ' , NIL},;
{'CT2_VALOR' , 100 , NIL},;
{'CT2_ORIGEM' ,'MSEXECAUT', NIL},;
{'CT2_HP' ,'' , NIL},;
{'CT2_ROTINA' ,'FINA100   ' , NIL},;
{'CT2_HIST' ,'MSEXECAUT INCLUSAO CONTINUACAO DE HISTORICO COM MAIS DE 80 CARACTERES!!!!!!!!!!!', NIL} } )

//este trecho deve ser usado apenas quando necessário incluir continuação de histórico
/*
aAdd(aItens,{ {'CT2_FILIAL' ,'D MG 01 ' , NIL},;
{'CT2_LINHA' ,'002' , NIL},; 
{'CT2_DC' ,'4' , NIL},;
{'CT2_HIST' ,'CONT - MSEXECAUT INCLUSAO CONTINUACAO DE HISTORICO COM MAIS DE 80 CARACT', NIL} } )
*/
MSExecAuto( {|X,Y,Z| CTBA102(X,Y,Z)} ,aCab ,aItens, 3)
If lMsErroAuto <> Nil 
If !lMsErroAuto
_lOk := .T.
If !IsBlind()
MsgInfo('Inclusão com sucesso!')
EndIf
Else
_lOk := .F.
If !IsBlind()
MsgAlert('Erro na inclusao!')
Endif
EndIf
EndIf

Return