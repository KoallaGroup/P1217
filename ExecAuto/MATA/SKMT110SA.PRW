#INCLUDE "Protheus.ch"
#INCLUDE "rwmake.ch"

/*/{Protheus.doc} SKMT110SA.PRW
Exemplo Uso SigaAuto liberacao de SC

@type function
@author Eduardo Carraro - Novo Mundo Consultores
@since 21/02/2017
@version P12.1.17
/*/

User Function SKMT110SA()

Local cMsg		:= ""
Local lPerg		:= .f.
Local aSays		:= {}
Local aButtons	:= {}
Local lOk		:= .f.
Local cPerg     := "SKM110"

If AMIIn(02) .and. FwIsAdmin()
	//Inclusao da Pergunta
	PutSx1(cPerg,"01",OemToAnsi("Num. SC ?"),OemToAnsi("Num. SC ?"),OemToAnsi("Num. SC ?"),"mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{ OemToAnsi("Informe Número da SC")}, {}, {} )
	
	//Pergunto s/ Parametros ...
	Pergunte(cPerg,.f.)
	
	AADD(aSays,OemToAnsi("Esta rotina tem como objetivo liberar SC via SIGAAUTO"))
	
	AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. ) } } )
	AADD(aButtons, { 1,.T.,{|o| lOk := .t.,IIF(MsgBox(OemToAnsi("Confirma execução da Rotina ?"),OemToAnsi("Atenção!"),"YESNO"),o:oWnd:End(),lOk:=.f.) }} )
	AADD(aButtons, { 2,.T.,{|o| lOk := .f.,o:oWnd:End() }} )
	
	FormBatch(OemToAnsi("Exemplo Liberacao SC via SIGAAUTO"),aSays,aButtons)
	
	//Confirmacao
	If lOk
		FWMsgRun(, {|oMsg| FLBSCSA(oMsg,MV_PAR01) })
	EndIf
EndIf

//Restaura Areas
AEval(aAreas,{|aArea| RestArea(aArea)})

Return


Static Function FLBSCSA(oMsg,cNumSC)
**********************************************************************************************
* Execucao SIGAAUTO
*************
Local aLibs := {}
Local nRecSC1:=0
Private lMsHelpAuto := .f.
Private lMsErroAuto := .f.

//Posiciona SC1
SC1->(dbSetOrder(1))
SC1->(dbSeek(xFilial("SC1")+cNumSC))

While ! SC1->(Eof()) .and. xFilial("SC1") == SC1->C1_FILIAL .and. SC1->C1_NUM == cNumSC  
   oMsg:cCaption:=OemToAnsi("Aguarde, Liberando Item " + SC1->C1_ITEM)
   ProcessMessages()
   
    nRecSC1:=SC1->(RECNO())
    lMsErroAuto:=.f.
	//Realiza Liberacao Automatica
    aLibs:={}
    aadd(aLibs,{"C1_NUM"       ,SC1->C1_NUM,Nil})
    aadd(aLibs,{"C1_ITEM"      ,SC1->C1_ITEM,Nil})
    aadd(aLibs,{"C1_PRODUTO"   ,SC1->C1_PRODUTO,Nil})
    aadd(aLibs,{"C1_APROV"     ,'L',Nil})
    
    MSExecAuto({|x,y,z| MATA110(x,y,z)},aLibs,aLibs,7)
    
    If lMsErroAuto
    	MostraErro()
    EndIf
    
    SC1->(DbGoTo(nRecSC1))
    SC1->(DbSkip())
End

Return